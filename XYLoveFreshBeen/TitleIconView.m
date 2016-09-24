//
//  TitleIconView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "TitleIconView.h"

@interface TitleIconView ()

@property (nonatomic ,strong) UILabel *titleLbale;
@property (nonatomic ,strong) UIImageView *iconImageView;

@end


@implementation TitleIconView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLbale = [[UILabel alloc]init];
        _titleLbale.font = [UIFont systemFontOfSize:12];
        _titleLbale.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLbale];
        
        _iconImageView = [[UIImageView alloc]init];
        _iconImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_iconImageView];
        
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(-10);
        }];
        
        [_titleLbale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImageView.mas_bottom).offset(3);
            make.leading.trailing.equalTo(self);
            make.height.mas_equalTo(20);
        }];
    }
    return self;
}

-(instancetype)initWithTitleLable:(NSString *)title icon:(UIImage *)image boder:(BOOL)showBorder{
    self = [super init];
    if (showBorder) {
        self.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
        self.layer.borderWidth = 0.5;
    }
    self.titleLbale.text = title;
    self.iconImageView.image = image;
    return self;
}

@end
