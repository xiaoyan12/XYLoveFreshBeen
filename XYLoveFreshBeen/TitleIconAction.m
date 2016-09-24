//
//  TitleIconAction.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "TitleIconAction.h"

@implementation TitleIconAction

+(instancetype)titleIconWith:(NSString *)title icon:(UIImage *)image controller:(UIViewController *)controller tag:(NSInteger)tag{
    TitleIconAction *titleIconAction = [[self alloc]init];
    titleIconAction.title = title;
    titleIconAction.icon = image;
    titleIconAction.controller = controller;
    titleIconAction.tag = tag;
    return titleIconAction;
}
@end
