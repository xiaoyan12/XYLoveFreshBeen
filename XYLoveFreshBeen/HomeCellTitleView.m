//
//  HomeCellTitleView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HomeCellTitleView.h"
#import "UIColor+Extension.h"

@interface HomeCellTitleView ()

@property (nonatomic ,strong) UIView *rectangleView;
@property (nonatomic ,strong) UILabel *titleLable;

@end

@implementation HomeCellTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _rectangleView = [[UIView alloc]init];
        _titleLable = [[UILabel alloc]init];
        _titleLable.text = @"优选水果";
        _titleLable.font = [UIFont systemFontOfSize:15];
        [_titleLable sizeToFit];
        UILabel *moreLable = [[UILabel alloc]init];
        moreLable.text = @"更多 >";
        moreLable.font = [UIFont systemFontOfSize:13];
        [moreLable sizeToFit];
        moreLable.textAlignment = NSTextAlignmentRight;
        moreLable.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [self addSubview:_rectangleView];
        [self addSubview:_titleLable];
        [self addSubview:moreLable];
        
        [_rectangleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.width.mas_equalTo(5);
            make.height.mas_equalTo(15);
            make.centerY.equalTo(self);
        }];
        [_titleLable  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_rectangleView.mas_trailing).offset(5);
            make.width.mas_equalTo(XYWidth/2);
            make.centerY.equalTo(self);
        }];
        [moreLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_titleLable.mas_trailing);
            make.trailing.equalTo(self).offset(-10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

-(void)setActRow:(ActRow *)actRow{
    UIColor *color = [UIColor gitColor:actRow.category_detail.category_color];
    self.rectangleView.backgroundColor = color;
    self.titleLable.textColor = color;
    self.titleLable.text = actRow.category_detail.name;
}

@end
