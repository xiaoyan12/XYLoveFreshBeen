//
//  MainTabBarControll.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/18.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "MainTabBarControll.h"
#import "BashNavigationController.h"
#import "HomeViewController.h"
#import "FlashViewController.h"
#import "ShoppingViewController.h"
#import "MyViewController.h"
#import "UserShopCarTool.h"

@interface MainTabBarControll ()

@end

@implementation MainTabBarControll

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    [self buildMainTabbarController];
    // Do any additional setup after loading the view.
}

-(void)buildMainTabbarController{
    [self setUpTheChildViewController:@"首页" viewController:[HomeViewController  new] image:@"v2_home" selectedImage:@"v2_home_r"];
    [self setUpTheChildViewController:@"闪电超市" viewController:[FlashViewController new] image:@"v2_order" selectedImage:@"v2_order_r"];
    [self setUpTheChildViewController:@"购物车" viewController:[ShoppingViewController new] image:@"shopCart" selectedImage:@"shopCart_r"];
    [self setUpTheChildViewController:@"我的" viewController:[MyViewController new] image:@"v2_my" selectedImage:@"v2_my_r"];
}

-(void)setUpTheChildViewController:(NSString *)title viewController:(UIViewController *)controller image:(NSString *)image selectedImage:(NSString *)selectedImage{
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = [UIImage imageNamed:image];
    item.selectedImage = [UIImage imageNamed:selectedImage];
    item.title = title;
    controller.tabBarItem = item;
    BashNavigationController *nav = [[BashNavigationController alloc]initWithRootViewController:controller];
    
    [self addChildViewController:nav];
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shopCarBuyNumberChanged) name:LFBShopCarBuyNumberDidChangeNotification object:nil];
}

-(void)shopCarBuyNumberChanged{
    UIViewController *controller = self.childViewControllers[2];
    UITabBarItem *item = controller.tabBarItem;
    NSInteger goodsNumer = [[UserShopCarTool sharedInstance]getShopCarGoodsNumer];
    
    if (goodsNumer == 0) {
        item.badgeValue = nil;
        return;
    }
    item.badgeValue = [NSString stringWithFormat:@"%ld",goodsNumer];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:LFBShopCarBuyNumberDidChangeNotification object:nil];
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
