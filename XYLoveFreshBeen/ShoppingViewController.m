//
//  ShoppingViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ShoppingViewController.h"
#import "EmptyShopCarView.h"
#import "ShopCarTableFootView.h"
#import "UserShopCarTool.h"
#import "ReceiptAddressView.h"
#import "ShopCarCommentsView.h"
#import "ShopCarMarkerView.h"
#import "ShopCarSignTimeView.h"
#import "UserInfo.h"
#import "OrserPayWayViewController.h"
#import "ShopCartCell.h"

@interface ShoppingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) EmptyShopCarView *emptyUI;
@property (nonatomic ,strong) UIView *tableHeadView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *shopCar;
@property (nonatomic ,strong) ShopCarTableFootView *tableFootView;

@end

@implementation ShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    [self addNotification];
    [self buildTableView];
    [self buildEmptyUI];
    // Do any additional setup after loading the view.
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRemoveProduct) name:LFBShopCarDidRemoveProductNSNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyNumberChange) name:LFBShopCarBuyNumberDidChangeNotification object:nil];
}
-(void)didRemoveProduct{
    if (self.shopCar.count == 0) {
        self.emptyUI.hidden = NO;
        self.tableView.hidden = YES;
        return;
    }
    [self.tableView reloadData];
}

-(void)buyNumberChange{
    self.tableFootView.price = [[UserShopCarTool sharedInstance]getShopCarGoodsPrice];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark --- tableView
-(void)buildTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.hidden = YES;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self buildTableHeadView];
    [self buildTbaleFootView];
}

-(void)buildTableHeadView{
    self.tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, XYWidth, 250)];
    self.tableHeadView.backgroundColor = self.view.backgroundColor;
    ReceiptAddressView *addressView = [[ReceiptAddressView alloc]initWithFrame:CGRectMake(0, 10, XYWidth, 70)];
    addressView.address = [UserInfo sharedInstance].defaultAddress;
    ShopCarMarkerView * markerView = [[ShopCarMarkerView alloc]initWithFrame:CGRectMake(0, 90, XYWidth, 60)];
    ShopCarSignTimeView *signTimeView = [[ShopCarSignTimeView alloc]initWithFrame:CGRectMake(0, 150, XYWidth, 50)];
    ShopCarCommentsView *commentView = [[ShopCarCommentsView alloc]initWithFrame:CGRectMake(0, 200, XYWidth, 50)];
    [self addToHeadViewWithBorder:addressView];
    [self addToHeadViewWithBorder:markerView];
    [self addToHeadViewWithBorder:signTimeView];
    [self addToHeadViewWithBorder:commentView];
    
    self.tableView.tableHeaderView = self.tableHeadView;
    
}

-(void)addToHeadViewWithBorder:(UIView *)view{
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
    [self.tableHeadView addSubview:view];
}

-(void)buildTbaleFootView{
    self.tableFootView = [[ShopCarTableFootView alloc]initWithFrame:CGRectMake(0, 0, XYWidth, 50)];
    self.tableFootView.price = [[UserShopCarTool sharedInstance] getShopCarGoodsPrice];
    __weak typeof(self) weakSelf = self;
    self.tableFootView.sureButtonClick = ^{
        [weakSelf.navigationController pushViewController:[[OrserPayWayViewController alloc]init] animated:YES];
    };
    self.tableView.tableFooterView = self.tableFootView;
}
#pragma mark --tableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.shopCar.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShopCartCell *cell = [ShopCartCell cellWithTableView:tableView];
    cell.goods = self.shopCar[indexPath.row];
    return cell;
}
#pragma mark --购物车为空时，显示的图片
-(void)buildEmptyUI{
    self.emptyUI = [[EmptyShopCarView alloc]init];
    self.emptyUI.hidden = YES;
    [self.view addSubview:self.emptyUI];
    [self.emptyUI mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(170);
        make.centerY.equalTo(self.view).offset(-60);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([[UserShopCarTool sharedInstance] isEmpty]) {
        self.emptyUI.hidden = NO;
        self.tableView.hidden = YES;
    }else{
        self.emptyUI.hidden = YES;
        
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]];
        [SVProgressHUD showWithStatus:@"信息正在加载中..."];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.shopCar = [UserShopCarTool sharedInstance].shopCar;
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
            self.tableView.hidden = NO;
        });
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
