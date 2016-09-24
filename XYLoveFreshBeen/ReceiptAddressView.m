//
//  ReceiptAddressView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ReceiptAddressView.h"

@interface ReceiptAddressView ()

@property (nonatomic ,strong) UILabel *consigneeLbale;
@property (nonatomic ,strong) UILabel *phoneNumLable;
@property (nonatomic ,strong) UILabel *receiptLable;

@property (nonatomic ,strong) UILabel *consigneeTextLable;
@property (nonatomic ,strong) UILabel *phoneNumTextLbale;
@property (nonatomic ,strong) UILabel *receiptTextLable;

@property (nonatomic ,strong) UIImageView *topImageView;
@property (nonatomic ,strong) UIImageView *bottomImageView;
@property (nonatomic ,strong) UIImageView *arrowImageView;

@property (nonatomic ,strong) UIButton *modifyBtn;
@property (nonatomic ,copy) ModifyBtnClick modifyBtnClick;

@end

@implementation ReceiptAddressView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
        _bottomImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_shoprail"]];
        [self addSubview:_topImageView];
        [self addSubview:_bottomImageView];
        
        _consigneeLbale = [[UILabel alloc]init];
        _phoneNumLable = [[UILabel alloc]init];
        _receiptLable = [[UILabel alloc]init];
        _consigneeTextLable = [[UILabel alloc]init];
        _phoneNumTextLbale = [[UILabel alloc]init];
        _receiptTextLable = [[UILabel alloc]init];
        
        [self initLbale:_consigneeLbale title:@"收货人："];
        [self initLbale:_receiptLable title:@"收货地址："];
        [self initLbale:_phoneNumLable title:@"电话："];
        [self initLbale:_consigneeTextLable title:@""];
        [self initLbale:_phoneNumTextLbale title:@""];
        [self initLbale:_receiptTextLable title:@""];
        
        _modifyBtn = [[UIButton alloc]init];
        [_modifyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _modifyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_modifyBtn setTitle:@"修改" forState:UIControlStateNormal];
        [_modifyBtn addTarget:self action:@selector(modifiyAddress) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_modifyBtn];
        
        _arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_go"]];
        [self addSubview:_arrowImageView];
    }
    return self;
}

-(void)modifiyAddress{
    if (self.modifyBtnClick) {
        self.modifyBtnClick();
    }
}
-(void)initLbale:(UILabel *)lable title:(NSString *)text{
    lable.text = text;
    lable.font = [UIFont systemFontOfSize:12];
    lable.textColor = [UIColor blackColor];
    [lable sizeToFit];
    [self addSubview:lable];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat leftMargin = 15;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    self.topImageView.frame = CGRectMake(0, 0, width, 2);
    self.bottomImageView.frame = CGRectMake(0, height - 2, width, 2);
    self.consigneeLbale.frame = CGRectMake(leftMargin, 10, self.consigneeLbale.frame.size.width, self.consigneeLbale.frame.size.height);
    self.consigneeTextLable.frame = CGRectMake(CGRectGetMaxX(self.consigneeLbale.frame) + 5, self.consigneeLbale.frame.origin.y, 150, self.consigneeLbale.frame.size.height);
    self.phoneNumLable.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.consigneeLbale.frame) + 5, self.phoneNumLable.frame.size.width, self.phoneNumLable.frame.size.height);
    self.phoneNumTextLbale.frame = CGRectMake(self.consigneeTextLable.frame.origin.x, self.phoneNumLable.frame.origin.y, 150, self.phoneNumLable.frame.size.height);
    self.receiptLable.frame = CGRectMake(leftMargin, CGRectGetMaxY(self.phoneNumTextLbale.frame) + 5, self.receiptLable.frame.size.width, self.receiptLable.frame.size.height);
    self.receiptTextLable.frame = CGRectMake(self.consigneeTextLable.frame.origin.x, self.receiptLable.frame.origin.y, 150, self.receiptLable.frame.size.height);
    self.modifyBtn.frame = CGRectMake(width - 60, 0, 30, height);
    self.arrowImageView.frame = CGRectMake(width - 15, (height - self.arrowImageView.frame.size.height) * 0.5, self.arrowImageView.frame.size.width, self.arrowImageView.frame.size.height);
}

-(instancetype)initWithFrame:(CGRect)frame modify:(ModifyBtnClick)modify{
    self = [self initWithFrame:frame];
    self.modifyBtnClick = modify;
    return self;
}

-(void)setAddress:(Address *)address{
    self.consigneeTextLable.text = [NSString stringWithFormat:@"%@ 先生",address.accept_name];
    self.phoneNumTextLbale.text = address.telphone;
    self.receiptTextLable.text = address.address;
}
@end
