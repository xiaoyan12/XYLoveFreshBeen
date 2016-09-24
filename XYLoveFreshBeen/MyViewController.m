//
//  MyViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "MyViewController.h"
#import "MineHeadView.h"
#import "TitleIconAction.h"
#import "MyOrderHeadView.h"
//#import "TitleIconView.h"
#import "MenuView.h"
#import "FooterBannerData.h"
#import "PageScrollView.h"

@interface MyViewController ()

@property (nonatomic ,strong) NSArray *orderMenus;
@property (nonatomic ,strong) NSArray *mineMenus;
@property (nonatomic ,strong) UIScrollView *mainScrollView;
@property (nonatomic ,strong) MineHeadView *mineHeadView;
@property (nonatomic ,strong) UIView *footerView;

@end

@implementation MyViewController

-(NSArray *)orderMenus{
    if (_orderMenus == nil) {
        _orderMenus = @[
                        [TitleIconAction titleIconWith:@"待支付" icon:[UIImage imageNamed:@"icon_daifukuan"] controller:nil tag:0],
                        [TitleIconAction titleIconWith:@"待收货" icon:[UIImage imageNamed:@"icon_daishouhuo"] controller:nil tag:1],
                        [TitleIconAction titleIconWith:@"待评价" icon:[UIImage imageNamed:@"icon_daipingjia"] controller:nil tag:2],
                        [TitleIconAction titleIconWith:@"退款/售后" icon:[UIImage imageNamed:@"icon_tuikuan"] controller:nil tag:3]
                        ];
    }
    return _orderMenus;
}

-(NSArray *)mineMenus{
    if (_mineMenus == nil) {
        _mineMenus = @[
                       [TitleIconAction titleIconWith:@"收货地址" icon:[UIImage imageNamed:@"v2_my_address_icon-1"] controller:nil tag:0],
                       [TitleIconAction titleIconWith:@"我的店铺" icon:[UIImage imageNamed:@"icon_mystore-1"] controller:nil tag:0],
                       [TitleIconAction titleIconWith:@"优惠券" icon:[UIImage imageNamed:@"icon_mycoupon"] controller:nil tag:0],
                       [TitleIconAction titleIconWith:@"我的消息" icon:[UIImage imageNamed:@"icon_message"] controller:nil tag:0],
                       [TitleIconAction titleIconWith:@"在线客服" icon:[UIImage imageNamed:@"v2_my_serviceonline_icon-1"] controller:nil tag:0],
                       [TitleIconAction titleIconWith:@"意见反馈" icon:[UIImage imageNamed:@"v2_my_feedback_icon-1"] controller:nil tag:0],
                       [TitleIconAction titleIconWith:@"分享给朋友" icon:[UIImage imageNamed:@"v2_my_share_icon-1"] controller:nil tag:0],
                       [TitleIconAction titleIconWith:@"帮助中心" icon:[UIImage imageNamed:@"icon_help"] controller:nil tag:0]
                       ];

    }
    return _mineMenus;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self buildHeadView];
    [self buildScrollView];
    [self loadFooterBannerData];
    // Do any additional setup after loading the view.
}

-(void)buildHeadView{
    self.mineHeadView = [[MineHeadView alloc]init];
    [self.view addSubview:self.mineHeadView];
    
    [self.mineHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(self.view);
        make.height.mas_equalTo(160);
    }];
}

-(void)buildScrollView{
    self.mainScrollView = [[UIScrollView alloc]init];
    self.mainScrollView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mineHeadView.mas_bottom);
        make.leading.trailing.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-49);
    }];
    
    UIView *contentView = [[UIView alloc]init];
    [self.mainScrollView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mainScrollView);
        make.width.equalTo(self.mainScrollView);
    }];
    
    MyOrderHeadView *orderHeadView = [[MyOrderHeadView alloc]init];
    [contentView addSubview:orderHeadView];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = self.view.backgroundColor;
    [contentView addSubview:lineView];
    
    MenuView *orderMenuView = [[MenuView alloc]initMenus:self.orderMenus WithLine:NO];
    [contentView addSubview:orderMenuView];
    
    MenuView *mineMenuView = [[MenuView alloc]initMenus:self.mineMenus WithLine:YES];
    [contentView addSubview:mineMenuView];
    
    UIView *footView = [[UIView alloc]init];
    self.footerView = footView;
    footView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:footView];
    
    [orderHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.equalTo(self.mainScrollView).offset(10);
        make.height.mas_equalTo(40);
        make.width.equalTo(contentView);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderHeadView.mas_bottom);
        make.leading.equalTo(@0);
        make.width.equalTo(@0);
        make.height.mas_equalTo(1);
    }];
    
    [orderMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(@0);
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(80);
        make.width.equalTo(contentView);
    }];
    
    [mineMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(orderMenuView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(@0);
        make.height.mas_equalTo(180);
    }];
    
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mineMenuView.mas_bottom).offset(10);
        make.leading.trailing.equalTo(@0);
        make.height.mas_equalTo(150);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(footView);
    }];
}

-(void)loadFooterBannerData{
    [FooterBannerData loadFootBannerData:^(id data, NSError *error) {
        NSMutableArray *imageUrl = [NSMutableArray array];
        
        [data enumerateObjectsUsingBlock:^(Activity *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [imageUrl addObject:obj.img];
        }];
        PageScrollView *pageScrollView = [PageScrollView pageScrollView:imageUrl placeHolder:[UIImage imageNamed:@"v2_placeholder_full_size"]];
        [self.footerView addSubview:pageScrollView];
        [pageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.footerView).offset(10);
            make.trailing.equalTo(self.footerView).offset(-10);
            make.centerY.equalTo(self.footerView);
            make.height.mas_equalTo(self.footerView.mas_width).multipliedBy(0.37);
        }];
    }];
}

-(void)loadView{
    [super loadView];
    self.navigationController.navigationBar.hidden = YES;
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
