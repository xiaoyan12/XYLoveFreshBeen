//
//  MyOrderHeadView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "MyOrderHeadView.h"

@implementation MyOrderHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *myOrderLable = [[UILabel alloc]init];
        myOrderLable.text = @"我的订单";
        myOrderLable.font = [UIFont systemFontOfSize:14];
        [myOrderLable sizeToFit];
        [self addSubview:myOrderLable];
        
        UILabel *checkOrderLable = [[UILabel alloc]init];
        checkOrderLable.text = @"查看全部订单";
        checkOrderLable.font = [UIFont systemFontOfSize:14];
        checkOrderLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [checkOrderLable sizeToFit];
        [self addSubview:checkOrderLable];
        
        UIImageView *arrowView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
        [self addSubview:arrowView];
        
        [myOrderLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.centerY.equalTo(self);
        }];
        
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
        }];
        
        [checkOrderLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(arrowView.mas_leading).offset(-10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
