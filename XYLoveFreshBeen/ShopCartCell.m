//
//  ShopCartCell.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/23.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ShopCartCell.h"
#import "BuyView.h"
#import "NSString+Extension.h"

@interface ShopCartCell ()

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UILabel *priceLable;
@property (nonatomic ,strong) BuyView *buyView;

@end

@implementation ShopCartCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _titleLable = [[UILabel alloc]init];
        _titleLable.font = [UIFont systemFontOfSize:15];
        [_titleLable sizeToFit];
        _titleLable.textColor = [UIColor blackColor];
        [self addSubview:_titleLable];
        
        _priceLable = [[UILabel alloc]init];
        _priceLable.font = [UIFont systemFontOfSize:15];
        [_priceLable sizeToFit];
        _priceLable.textColor = [UIColor blackColor];
        [self addSubview:_priceLable];
        
        _buyView = [[BuyView alloc]init];
        [self addSubview:_buyView];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.centerY.equalTo(self);
        }];
        
        [_buyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(70);
            make.height.mas_equalTo(25);
            make.centerY.equalTo(self);
            make.trailing.equalTo(self).offset(-10);
        }];
        
        [_priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(_buyView.mas_leading).offset(-10);
            make.centerY.equalTo(self);
        }];
    }
    return self;
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[ShopCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

-(void)setGoods:(Goods *)goods{
    self.titleLable.text = [NSString stringWithFormat:@"[精选]%@",goods.name];
    self.priceLable.text = [goods.price cleanDecimalPointZear];
    self.buyView.goods = goods;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
