//
//  BrandView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeHeadData.h"

typedef NS_ENUM(NSInteger, BrandViewType){
    BrandViewTypeThree,
    BrandViewTypeFour
};
@interface BrandView : UIView

@property (nonatomic ,copy) ClickCallback callback;
@property (nonatomic )      CGFloat height;

-(instancetype)initWithActRow:(ActInfo *)actInfo;

@end
