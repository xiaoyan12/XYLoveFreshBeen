//
//  ShopCarSingnTimeView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ShopCarSignTimeView.h"

@implementation ShopCarSignTimeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *signTimeTitleLbale = [[UILabel alloc]init];
        signTimeTitleLbale.text = @"收货时间";
        [signTimeTitleLbale sizeToFit];
        signTimeTitleLbale.font = [UIFont systemFontOfSize:15];
        [self addSubview:signTimeTitleLbale];
        
        UILabel *signTimeLbale = [[UILabel alloc]init];
        signTimeLbale.text = @"闪电送，及时达";
        signTimeLbale.textColor = [UIColor redColor];
        signTimeLbale.font = [UIFont systemFontOfSize:15];
        [signTimeLbale sizeToFit];
        [self addSubview:signTimeLbale];
        
        UIButton *reserveBtn = [[UIButton alloc]init];
        [reserveBtn setTitle:@"可预订" forState:UIControlStateNormal];
        [reserveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        reserveBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:reserveBtn];
        
        UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
        [self addSubview:arrowImageView];
        
        [signTimeTitleLbale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];
        
        [signTimeLbale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(signTimeTitleLbale.mas_trailing).offset(10);
            make.centerY.equalTo(self);
        }];
        
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
        }];
        
        [reserveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(arrowImageView.mas_leading).offset(-20);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

@end
