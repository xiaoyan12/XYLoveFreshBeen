//
//  UIBarButtonItem+Butten.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "UIBarButtonItem+Butten.h"
#import "ItemLeftButten.h"
@implementation UIBarButtonItem (Butten)

+(instancetype)barButtonItem:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action type:(ItemButtonType)type{
    UIButton *button;
    if (type == LeftItemButten) {
        button = [ItemLeftButten buttonWithType:UIButtonTypeCustom];
    }else{
        button = [ItemRightButten buttonWithType:UIButtonTypeCustom];
    }
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
