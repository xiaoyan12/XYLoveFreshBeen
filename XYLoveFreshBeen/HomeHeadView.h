//
//  HomeHeadView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotView.h"
#import "PageScrollView.h"
#import "BrandView.h"
#import "HeadlineView.h"
#import "HomeHeadData.h"

@interface HomeHeadView : UIView

@property (nonatomic ,strong) HotView *hotView;
@property (nonatomic ,strong) PageScrollView *pageView;
@property (nonatomic ,strong) BrandView *brandView;
@property (nonatomic ,strong) BrandView *sceneView;
@property (nonatomic ,strong) HeadlineView *headlineView;
@property (nonatomic )        CGFloat height;
@property (nonatomic ,copy)   ClickCallback callback;

- (instancetype)initWithHeadData:(HomeHeadData *)headData;

@end
