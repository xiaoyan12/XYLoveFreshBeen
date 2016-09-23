//
//  ProductsViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ProductsViewController.h"
#import "ProductCell.h"
#import "SuperMarketHeadView.h"
#import "XYRefreshHeader.h"

@interface ProductsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic )        CGFloat lastOffsetY;
@property (nonatomic )        BOOL isScrollDown;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    [self buildProductTableView];
    // Do any additional setup after loading the view.
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCarBuyNumberDidChange) name:LFBShopCarBuyNumberDidChangeNotification object:nil];
}
-(void)shopCarBuyNumberDidChange{
    [self.tableView reloadData];
}

-(void)loadView{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(XYWidth *0.25, 0, XYWidth*0.75, XYHeight -64 -49)];
}

-(void)buildProductTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    XYRefreshHeader *header = [XYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.tableView.mj_header = header;
}

-(void)headerRefresh{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

#pragma mark --代理、数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.superData.categories.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.superData.categories[section].products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProductCell *cell = [ProductCell cellWithTableView:tableView];
    cell.goods = self.superData.categories[indexPath.section].products[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SuperMarketHeadView *headerView = [SuperMarketHeadView headerCellWith:tableView];
    headerView.title = self.superData.categories[section].name;
    return headerView;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (!self.isScrollDown && [self.delegate respondsToSelector:@selector(willDislayHeaderView:)]) {
        [self.delegate willDislayHeaderView:section];
    }
}

-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
    if (self.isScrollDown && [self.delegate respondsToSelector:@selector(willDislayHeaderView:)]) {
        [self.delegate didEndDislayHeaderView:section];
    }
}

#pragma mark --scrollView delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.isScrollDown = self.lastOffsetY < scrollView.contentOffset.y;
    self.lastOffsetY = scrollView.contentOffset.y;
}

#pragma mark -- flashTableViewdelegate

-(void)didTableView:(UITableView *)tableView clickedAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

-(void)setSuperData:(SuperMarketData *)superData{
    _superData = superData;
    [self.tableView reloadData];
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
