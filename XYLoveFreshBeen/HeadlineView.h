//
//  HeadlineView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeadData.h"

@interface HeadlineView : UIView

@property (nonatomic ,strong) ActInfo *headline;
@property (nonatomic ,copy)   ClickCallback callback;

@end
