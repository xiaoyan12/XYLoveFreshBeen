//
//  HomeCell.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HomeCell.h"
#import "BuyView.h"
#import "DiscountPriceView.h"

@interface HomeCell ()
//背景图
@property (nonatomic ,strong) UIImageView *backImageView;
//商品图片
@property (nonatomic ,strong) UIImageView *goodsImageView;
//商品名字的图片
@property (nonatomic ,strong) UILabel *nameLable;
//精选的图片
@property (nonatomic ,strong) UIImageView *fineImageView;
// 买一赠一的图片
@property (nonatomic ,strong) UIImageView *giveImageView;
//商品单位的图片
@property (nonatomic ,strong) UILabel *specificsLable;
//折扣
@property (nonatomic ,strong) DiscountPriceView *discountPriceView;
//选择数量
@property (nonatomic ,strong) BuyView *buyView;
@property (nonatomic )        HomeCellType type;

@end

@implementation HomeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _backImageView = [[UIImageView alloc]init];
        _backImageView.contentMode = UIViewContentModeCenter;
        _goodsImageView = [[UIImageView alloc]init];
        _nameLable = [[UILabel alloc]init];
        _nameLable.font = [UIFont systemFontOfSize:14];
        _fineImageView = [[UIImageView alloc]init];
        [_fineImageView setImage:[UIImage imageNamed:@"jingxuan.png"]];
        _giveImageView = [[UIImageView alloc]init];
        [_giveImageView setImage:[UIImage imageNamed:@"buyOne.png"]];
        _specificsLable = [[UILabel alloc]init];
        _specificsLable.font = [UIFont systemFontOfSize:12];
        _specificsLable.textColor = [UIColor darkGrayColor];
        _discountPriceView = [[DiscountPriceView alloc]init];
        _buyView = [[BuyView alloc]init];
        
        [self addSubview:_backImageView];
        [self addSubview:_goodsImageView];
        [self addSubview:_nameLable];
        [self addSubview:_fineImageView];
        [self addSubview:_giveImageView];
        [self addSubview:_specificsLable];
        [self addSubview:_discountPriceView];
        [self addSubview:_buyView];
        
        [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.leading.equalTo(self);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(self.mas_width);
        }];
        
        [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_goodsImageView.mas_bottom);
            make.leading.equalTo(self).offset(5);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(20);
        }];
        
        [_fineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLable);
            make.top.equalTo(_nameLable.mas_bottom);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(15);
        }];
        
        [_giveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_fineImageView.mas_trailing);
            make.top.equalTo(_fineImageView);
            make.width.mas_equalTo(30);
            make.height.mas_equalTo(15);
        }];
        
        [_specificsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_nameLable);
            make.top.equalTo(_fineImageView.mas_bottom);
            make.width.mas_equalTo(self.mas_width);
            make.height.mas_equalTo(20);
        }];
        
        [_discountPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.leading.equalTo(_nameLable);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(25);
        }];
        
        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).offset(-5);
            make.trailing.equalTo(self).offset(-5);
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(25);
        }];
    }
    return self;
}

-(void)setType:(HomeCellType)type{
    self.backImageView.hidden = !(type == HomeCellTypeHorizontal);
    self.goodsImageView.hidden = (type == HomeCellTypeHorizontal);
    self.nameLable.hidden = (type == HomeCellTypeHorizontal);
    self.giveImageView.hidden = (type == HomeCellTypeHorizontal);
    self.fineImageView.hidden = (type == HomeCellTypeHorizontal);
    self.specificsLable.hidden = (type == HomeCellTypeHorizontal);
    self.discountPriceView.hidden = (type == HomeCellTypeHorizontal);
    self.buyView.hidden = (type == HomeCellTypeHorizontal);
}

-(void)setGoods:(Goods *)goods{
    self.type = HomeCellTypeVertical;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    self.nameLable.text = goods.name;
    if ([goods.pm_desc isEqualToString:@"买一赠一"]) {
        self.giveImageView.hidden = NO;
    }else{
        self.giveImageView.hidden = YES;
    }
    
    self.specificsLable.text = goods.specifics;
    self.discountPriceView.goods = goods;
    self.buyView.goods = goods;
}

-(void)setActivity:(Activity *)activity{
    self.type = HomeCellTypeHorizontal;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:activity.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_full_size"]];
}

-(void)setBuyViewShowZear:(BOOL)buyViewShowZear{
    self.buyView.zearNeverShow = buyViewShowZear;
}
@end
