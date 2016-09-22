//
//  DiscountPriceView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/22.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "DiscountPriceView.h"
#import "NSString+Extension.h"

@interface DiscountPriceView ()

@property (nonatomic ,strong) UILabel *marketPriceLable;
@property (nonatomic ,strong) UILabel *priceLable;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic )        BOOL hasMarketPrice;

@end

@implementation DiscountPriceView

-(instancetype)init{
    if (self = [super init]) {
        _marketPriceLable = [[UILabel alloc]init];
        _marketPriceLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:_marketPriceLable];
        _priceLable = [[UILabel alloc]init];
        _priceLable.textColor = [UIColor redColor];
        _priceLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:_priceLable];
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = [UIColor blackColor];
        [self addSubview:_lineView];
        
        [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.centerY.equalTo(self);
        }];
        
        [_marketPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_priceLable.mas_trailing).offset(3);
            make.centerY.equalTo(self);
        }];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(_marketPriceLable.mas_width);
            make.height.mas_equalTo(1);
            make.leading.equalTo(_marketPriceLable);
            make.centerY.equalTo(_marketPriceLable);
        }];
    }
    return self;
}

-(void)setGoods:(Goods *)goods{
    self.priceLable.text = [NSString stringWithFormat:@"￥%@",[goods.price cleanDecimalPointZear]];
    self.marketPriceLable.text = [NSString stringWithFormat:@"￥%@",[goods.market_price cleanDecimalPointZear]];
    [self.priceLable sizeToFit];
    [self.marketPriceLable sizeToFit];
    if ([goods.price isEqualToString:goods.market_price]) {
        self.marketPriceLable.hidden = YES;
        self.lineView.hidden = YES;
    }else{
        self.marketPriceLable.hidden = NO;
        self.lineView.hidden = NO;
    }
    
}
@end
