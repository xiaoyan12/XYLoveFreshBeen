//
//  AdressTitleView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "AdressTitleView.h"
#import "UserInfo.h"
#import "AddressData.h"

@interface AdressTitleView ()

@property (nonatomic ,strong) UILabel *palyLable;
@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *arrowImage;

@end

@implementation AdressTitleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.palyLable = [[UILabel alloc]init];
        self.palyLable.text = @"配送至";
        self.palyLable.layer.borderWidth = 1;
        self.palyLable.font = [UIFont systemFontOfSize:10];
        [self.palyLable sizeToFit];
        [self addSubview:self.palyLable];
        [self.palyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        self.titleLable = [[UILabel alloc]init];
        Address *address = [[UserInfo sharedInstance]defaultAddress];
        if (address) {
            self.titleLable.text = address.address;
        }else{
            self.titleLable.text = @"您想送到哪儿";
        }
        self.titleLable.font = [UIFont systemFontOfSize:10];
        [self.titleLable sizeToFit];
        [self addSubview:self.titleLable];
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.palyLable.mas_trailing).offset(5);
            make.centerY.equalTo(self);
        }];
        
        self.arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"allowBlack"]];
        [self addSubview:self.arrowImage];
        [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(6);
            make.leading.equalTo(self.titleLable.mas_trailing).offset(5);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

-(CGFloat)adressViewWidth{
    [self layoutIfNeeded];
    return CGRectGetMaxX(self.arrowImage.frame);
}

-(void)setTitle:(Address *)adress{
    self.titleLable.text = adress.address;
}

@end
