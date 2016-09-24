//
//  TitleIconAction.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TitleIconAction : NSObject

@property (nonatomic ,copy) NSString *title;
@property (nonatomic ,strong) UIImage *icon;
@property (nonatomic ,strong) UIViewController *controller;
@property (nonatomic )        NSInteger tag;

+(instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controller tag:(NSInteger)tag;

@end
