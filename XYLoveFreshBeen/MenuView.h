//
//  MenuView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleIconAction.h"

@interface MenuView : UIView

-(instancetype)initMenus:(NSArray<TitleIconAction *> *)menus WithLine:(BOOL)showLine;

@end
