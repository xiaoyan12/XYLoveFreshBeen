//
//  HomeHeaderCell.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HomeHeaderCell.h"

@interface HomeHeaderCell ()

@property (nonatomic ,strong) UILabel *titleLable;

@end

@implementation HomeHeaderCell

-(instancetype) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.text = @"鲜锋热卖";
        _titleLable.font = [UIFont systemFontOfSize:15];
        _titleLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [_titleLable sizeToFit];
        [self addSubview:_titleLable];
        
        UIView *leftLine = [[UIView alloc]init];
        UIView *rightLine = [[UIView alloc]init];
        UIColor *color = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
        leftLine.backgroundColor = color;
        rightLine.backgroundColor = color;
        [self addSubview:leftLine];
        [self addSubview:rightLine];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        
        [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(1);
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.trailing.equalTo(_titleLable.mas_leading).offset(-10);
        }];
        
        [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(1);
            make.centerY.equalTo(self);
            make.leading.equalTo(_titleLable.mas_trailing).offset(10);
            make.trailing.equalTo(self).offset(-10);
        }];
        
    }
    return self;
}

-(void)showTitleLable:(BOOL)show{
    for (UIView *view in self.subviews) {
        view.hidden = !show;
    }
}
@end

/*
 *    HomeFooterCell
 *
 */

@interface HomeFooterCell ()

@property (nonatomic ,strong) UILabel *titleLable;

@end

@implementation HomeFooterCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.text = @"点击查看更多商品 >";
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [_titleLable sizeToFit];
        [self addSubview:_titleLable];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.width.mas_equalTo(self);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}
@end
