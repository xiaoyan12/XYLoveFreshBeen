//
//  AppDelegate.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/18.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "AppDelegate.h"
#import "XYAppConst.h"
#import "GuidePageController.h"
#import "MainTabBarControll.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setAppStyle];
    [self buildKeyWindow];
    [self addNotification];
    return YES;
}
//设置入口控制器
-(void)buildKeyWindow{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    NSString *isFirstOpenApp = [[NSUserDefaults standardUserDefaults]objectForKey:IsFristOpenApp];
    
    if (isFirstOpenApp == nil) {
        self.window.rootViewController = [[GuidePageController alloc]init];
        [[NSUserDefaults standardUserDefaults] setObject:IsFristOpenApp forKey:IsFristOpenApp];
    }else{
        self.window.rootViewController = [[MainTabBarControll alloc]init];
    }
}

-(void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabarController) name:GuideViewControllerDidFinish object:nil];
}

-(void)showMainTabarController{
    self.window.rootViewController = [[MainTabBarControll alloc]init];
}

-(void)setAppStyle{
    UITabBar *item = [UITabBar appearance];
    item.tintColor = [UIColor orangeColor];
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    navigationBar.translucent = NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
