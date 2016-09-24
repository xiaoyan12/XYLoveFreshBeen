//
//  ShopCarMarkerView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ShopCarMarkerView.h"

@implementation ShopCarMarkerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *iamgeView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_lighting"]];
        [self addSubview:iamgeView];
        UILabel *marketTitleLable = [[UILabel alloc]init];
        marketTitleLable.text = @"闪电超市";
        marketTitleLable.font = [UIFont systemFontOfSize:12];
        marketTitleLable.textColor = [UIColor lightGrayColor];
        [marketTitleLable sizeToFit];
        [self addSubview:marketTitleLable];
        
        UILabel *marketTipsLable = [[UILabel alloc]init];
        marketTipsLable.text = @"22:00前满￥30免运费,22:00后满￥50面运费";
        [marketTipsLable sizeToFit];
        marketTipsLable.textColor = [UIColor lightGrayColor];
        marketTipsLable.font = [UIFont systemFontOfSize:10];
        [self addSubview:marketTipsLable];
        
        UIImageView *redDotImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"reddot"]];
        [self addSubview:redDotImageView];
        
        [iamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.top.equalTo(self).offset(5);
            make.width.mas_equalTo(20);
            make.height.mas_equalTo(20);
        }];
        
        [marketTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(iamgeView.mas_trailing).offset(15);
            make.centerY.equalTo(iamgeView);
        }];
        
        [redDotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.top.equalTo(iamgeView.mas_bottom).offset(20);
            make.width.mas_equalTo(4);
            make.height.mas_equalTo(4);
        }];
        
        [marketTipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(redDotImageView.mas_trailing).offset(15);
            make.centerY.equalTo(redDotImageView);
        }];
    }
    return self;
}

@end
