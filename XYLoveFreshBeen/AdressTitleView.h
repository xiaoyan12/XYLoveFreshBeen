//
//  AdressTitleView.h
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Address;
@interface AdressTitleView : UIView

-(CGFloat)adressViewWidth;

-(void)setTitle:(Address *)adress;

@end
