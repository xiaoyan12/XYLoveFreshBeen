//
//  ShopCarTableFootView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ShopCarTableFootView.h"
#import "NSString+Extension.h"

@interface ShopCarTableFootView ()

@property (nonatomic ,strong) UILabel *priceLable;
@property (nonatomic ,strong) UIButton *sureButton;

@end

@implementation ShopCarTableFootView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _priceLable = [[UILabel alloc]init];
        _priceLable.textColor = [UIColor redColor];
        _priceLable.font = [UIFont systemFontOfSize:14];
        [self addSubview:_priceLable];
        
        _sureButton = [[UIButton alloc]init];
        _sureButton.backgroundColor = [UIColor colorWithRed:253/255.0 green:212/255.0 blue:49/2555.0 alpha:1.0];
        [_sureButton setTitle:@"选好了" forState:UIControlStateNormal];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_sureButton addTarget:self action:@selector(sureButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sureButton];
        
        [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(20);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(100);
            make.height.equalTo(self);
        }];
        
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(90);
        }];
    }
    return self;
}

-(void)sureButtonClick:(UIButton *)sender{
    if (self.sureButtonClick) {
        self.sureButtonClick();
    }
}

-(void)setPrice:(CGFloat)price{
    NSString *priceStr = [[NSString stringWithFormat:@"%f",price] cleanDecimalPointZear];
    self.priceLable.text = [NSString stringWithFormat:@"共￥%@",priceStr];
    
}
@end
