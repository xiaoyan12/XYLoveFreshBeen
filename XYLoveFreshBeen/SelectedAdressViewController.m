//
//  SelectedAdressViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "SelectedAdressViewController.h"
#import "UIBarButtonItem+Butten.h"
#import "AdressTitleView.h"
#import "UserInfo.h"
#import "MyAdressViewController.h"

@interface SelectedAdressViewController ()

@end

@implementation SelectedAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self buildNavgationBar];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    Address *defaultAdress = [[UserInfo sharedInstance]defaultAddress];
    if (defaultAdress) {
        AdressTitleView *titleView = [[AdressTitleView alloc]init];
        titleView.frame = CGRectMake(0, 0, [titleView adressViewWidth], 30);
        self.navigationItem.titleView = titleView;
        [self.navigationItem.titleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClick)]];
    }
}

-(void)titleViewClick{
    [self.navigationController pushViewController:[MyAdressViewController new] animated:YES];
}
-(void)buildNavgationBar{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItem:@"扫一扫" image:@"icon_black_scancode" target:self action:@selector(leftItemClick) type:LeftItemButten];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItem:@"搜索" image:@"icon_search" target:self action:@selector(rightItemClick) type:RightItemButten];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:253/2555.0 green:212/255.0 blue:49/255.0 alpha:1.0];
}

-(void)leftItemClick{
    
}
-(void)rightItemClick{
    
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
