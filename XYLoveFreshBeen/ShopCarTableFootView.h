//
//  ShopCarTableFootView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SureButtonClick)();

@interface ShopCarTableFootView : UIView

@property (nonatomic ) CGFloat price;
@property (nonatomic ,copy) SureButtonClick sureButtonClick;

@end
