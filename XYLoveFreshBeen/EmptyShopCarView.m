//
//  EmptyShopCarView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "EmptyShopCarView.h"

@implementation EmptyShopCarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:@"v2_shop_empty"];
        imageView.contentMode = UIViewContentModeCenter;
        [self addSubview:imageView];
    
        UILabel *titleLable = [[UILabel alloc]init];
        titleLable.text = @"亲,购物车空空的耶~赶紧挑好吃的吧";
        titleLable.font = [UIFont systemFontOfSize:16];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [self addSubview:titleLable];
    
        UIButton *button = [[UIButton alloc]init];
        [button setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
        [button setTitle:@"去逛逛" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:100/255.0 green:100/255.0  blue:100/255.0  alpha:1.0] forState:UIControlStateNormal];
        [self addSubview:button];
      
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.top.equalTo(imageView.mas_bottom);
            make.height.mas_equalTo(50);
        }];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLable.mas_bottom);
            make.centerX.equalTo(self);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(150);
        }];
    }
    return self;
}
@end
