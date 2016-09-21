//
//  HotView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface HotView : UIView

@property (nonatomic ,copy) ClickCallback callback;

-(instancetype)initWithImages:(NSArray<NSString *> *)images title:(NSArray *)titles placeHolder:(UIImage *)image;

@end
