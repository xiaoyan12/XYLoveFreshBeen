//
//  UIBarButtonItem+Butten.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger ,ItemButtonType){
    LeftItemButten,
    RightItemButten
};

@interface UIBarButtonItem (Butten)

+(instancetype)barButtonItem:(NSString *)title image:(NSString *)image target:(id)target action:(SEL)action type:(ItemButtonType)type;

@end
