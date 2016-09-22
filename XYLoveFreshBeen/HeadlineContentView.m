//
//  HeadlineContentView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/22.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HeadlineContentView.h"

@interface HeadlineContentView ()

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UILabel *contentLable;

@end

@implementation HeadlineContentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.textColor = [UIColor redColor];
        _titleLable.font = [UIFont systemFontOfSize:12];
        _titleLable.layer.borderColor = [UIColor redColor].CGColor;
        _titleLable.layer.borderWidth = 1;
        _titleLable.layer.cornerRadius = 3;
        _titleLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLable];
        
        _contentLable = [[UILabel alloc]init];
        [_contentLable sizeToFit];
        _contentLable.font = [UIFont systemFontOfSize:12];
        _contentLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [self addSubview:_contentLable];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(18);
        }];
        
        [_contentLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_titleLable.mas_trailing).offset(10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}


-(void)setActRow:(ActRow *)actRow{
    self.titleLable.text = actRow.headline_detail.title;
    self.contentLable.text = actRow.headline_detail.content;
}

@end
