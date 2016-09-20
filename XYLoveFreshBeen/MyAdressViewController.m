//
//  MyAdressViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "MyAdressViewController.h"
#import "AddressCell.h"
#import "UserInfo.h"

@interface MyAdressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *tableView;

@property (nonatomic ,strong) NSArray *address;

@end

@implementation MyAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self buildBottonView];
    [self buildAddressTableView];
    [self buildNavigationItem];
    [self loadAddressData];
    // Do any additional setup after loading the view.
}

-(void)buildNavigationItem{
    self.navigationItem.title = @"我的收货地址";
}

-(void)buildAddressTableView{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 80;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-60);
    }];
    self.tableView = tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.address.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressCell *cell = [AddressCell cellWithTable:tableView indexPath:indexPath callbackBlock:^(NSInteger tag) {
        NSLog(@"tag ===%ld",tag);
    }];
    
    cell.address = self.address[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [UserInfo sharedInstance].defaultAddress = self.address[indexPath.row];
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)loadAddressData{
    __weak typeof(self) weakSelf = self;
    
    [AddressData loadAdressData:^(id data, NSError *error) {
        weakSelf.address = data;
        [weakSelf.tableView reloadData];
    }];
}

-(void)buildBottonView{
    UIView *bottonView = [[UIView alloc]init];
    bottonView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottonView];
    [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    UIButton *button = [[UIButton alloc]init];
    button.backgroundColor = [UIColor colorWithRed:253/255.0 green:212/255.0 blue:49/255.0 alpha:1.0];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitle:@"+ 新增地址" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(addAddressButtonClick) forControlEvents:UIControlEventTouchUpInside];
    button.layer.masksToBounds = YES;
    
    [bottonView addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bottonView).offset(12);
        make.width.equalTo(bottonView).multipliedBy(0.7);
        make.centerX.equalTo(bottonView);
        make.bottom.equalTo(bottonView).offset(-12);
    }];
    
}

-(void)addAddressButtonClick{
    
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
