//
//  ShopCarCommentsView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ShopCarCommentsView.h"

@implementation ShopCarCommentsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLbale = [[UILabel alloc]init];
        titleLbale.text = @"收货备注";
        [titleLbale sizeToFit];
        titleLbale.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleLbale];
        
        UITextField *textField = [[UITextField alloc]init];
        textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        textField.autocorrectionType = UITextAutocorrectionTypeNo;
        textField.font = [UIFont systemFontOfSize:15];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.placeholder = @"可输入100字以内特殊要求内容";
        [self addSubview:textField];
        
        [titleLbale mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.width.mas_equalTo(80);
            make.centerY.equalTo(self);
        }];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titleLbale.mas_trailing).offset(5);
            make.centerY.equalTo(self);
            make.trailing.equalTo(self).offset(-20);
        }];
    }
    return self;
}

@end
