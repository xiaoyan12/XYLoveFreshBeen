//
//  BuyView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/22.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "BuyView.h"
#import "UserShopCarTool.h"

@interface BuyView ()
// 加号按钮
@property (nonatomic ,strong) UIButton *addGoodsButton;
// 减号按钮
@property (nonatomic ,strong) UIButton *reduceGoodsButton;
// 数量lable
@property (nonatomic ,strong) UILabel *countLable;
// 库存没货lable
@property (nonatomic ,strong) UILabel *supplementLable;
// 购买商品的数量
@property (nonatomic )        NSInteger buyNumber;

@end


@implementation BuyView

-(instancetype)init{
    self = [super init];
    if (!self) {
        return nil;
    }
    _addGoodsButton = [[UIButton alloc]init];
    
    [_addGoodsButton setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
    [_addGoodsButton addTarget:self action:@selector(addGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_addGoodsButton];
    
    _countLable = [[UILabel alloc]init];
    _countLable.text = @"0";
    _countLable.font = [UIFont systemFontOfSize:14];
    _countLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_countLable];
    
    _reduceGoodsButton = [[UIButton alloc]init];
    [_reduceGoodsButton setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
    [_reduceGoodsButton addTarget:self action:@selector(reduceButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reduceGoodsButton];
    
    _supplementLable = [[UILabel alloc]init];
    _supplementLable.textColor = [UIColor redColor];
    _supplementLable.text = @"补货中";
    _supplementLable.hidden = YES;
    _supplementLable.textAlignment = NSTextAlignmentCenter;
    _supplementLable.font = [UIFont systemFontOfSize:13];
    [self addSubview:_supplementLable];
    
    [_reduceGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_height);
    }];
    
    [_countLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_reduceGoodsButton.mas_trailing).offset(3);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.trailing.equalTo(_addGoodsButton.mas_leading).offset(-2);
    }];
    
    [_addGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
        make.width.mas_equalTo(self.mas_height);
    }];
    
    [_supplementLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    return self;
}

-(void)addGoodsButtonClick{
    if (self.buyNumber >= self.goods.number) {
        [[NSNotificationCenter defaultCenter] postNotificationName:HomeGoodsInventoryProblem object:self.goods.name];
        return;
    }
    self.buyNumber++;
    self.goods.userBuyNumber = self.buyNumber;
    self.countLable.text = [NSString stringWithFormat:@"%ld",self.buyNumber];
    [[UserShopCarTool sharedInstance] addSupermarkProductToSHopCar:self.goods];
    [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarBuyNumberDidChangeNotification object:nil];
}

-(void)reduceButtonClick{
    if (self.buyNumber <= 0) {
        return;
    }
    self.buyNumber--;
    self.goods.userBuyNumber = self.buyNumber;
    if (self.buyNumber == 0) {
        [[UserShopCarTool sharedInstance] removeFromProductShopCar:self.goods];
    }else{
        self.countLable.text = [NSString stringWithFormat:@"%ld",self.buyNumber];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LFBShopCarBuyNumberDidChangeNotification object:nil];
}

-(void)setGoods:(Goods *)goods{
    _goods = goods;
    if (goods.number <= 0) {
        [self supplementLableShow:YES];
    }else{
        [self supplementLableShow:NO];
    }
    self.buyNumber = goods.userBuyNumber;
}

-(void)supplementLableShow:(BOOL)show{
    if (show) {
        self.supplementLable.hidden = NO;
        self.countLable.hidden = YES;
        self.addGoodsButton.hidden = YES;
        self.reduceGoodsButton.hidden = YES;
    }else{
        self.supplementLable.hidden = YES;
        self.countLable.hidden = NO;
        self.addGoodsButton.hidden = NO;
        self.reduceGoodsButton.hidden = NO;
    }
}

-(void)setBuyNumber:(NSInteger)buyNumber{
    _buyNumber = buyNumber;
    if (self.zearNeverShow) {
        self.reduceGoodsButton.hidden = YES;
        self.countLable.hidden = YES;
    }else{
        if (buyNumber == 0) {
            self.reduceGoodsButton.hidden = YES && !self.zearIsShow;
            self.countLable.hidden = YES && !self.zearIsShow;
        }else{
            self.countLable.text = [NSString stringWithFormat:@"%ld",(long)buyNumber];
            self.reduceGoodsButton.hidden = NO;
            self.countLable.hidden = NO;
        }
    }
}
@end
