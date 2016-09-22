//
//  BuyView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/22.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Goods.h"

@interface BuyView : UIView
// 与之关联的商品
@property (nonatomic ,strong) Goods *goods;
// 是否显示0
@property (nonatomic )        BOOL zearIsShow;
// 不显示减号
@property (nonatomic )        BOOL zearNeverShow;

@end
