//
//  HomeCategoryCell.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HomeCategoryCell.h"
#import "HomeCellGoodsView.h"
#import "HomeCellTitleView.h"

@interface HomeCategoryCell ()

@property (nonatomic ,strong) HomeCellGoodsView *goodsView;
@property (nonatomic ,strong) HomeCellTitleView *titleView;
@property (nonatomic ,strong) UIImageView *barandImageView;

@end

@implementation HomeCategoryCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _titleView = [[HomeCellTitleView alloc]init];
        [self addSubview:_titleView];
        _barandImageView = [[UIImageView alloc]init];
        [self addSubview:_barandImageView];
        _goodsView = [[HomeCellGoodsView alloc]init];
        [self addSubview:_goodsView];
        
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.leading.equalTo(self);
            make.width.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        
        [_barandImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self).offset(10);
            make.trailing.equalTo(self).offset(-10);
            make.top.equalTo(_titleView.mas_bottom);
            make.height.mas_equalTo(80);
        }];
        
        [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(_barandImageView.mas_bottom);
            make.trailing.equalTo(self);
            make.height.mas_equalTo(200);
        }];
    }
    return self;
}

-(void)setActRow:(ActRow *)actRow{
    self.titleView.actRow = actRow;
    [self.barandImageView sd_setImageWithURL:[NSURL URLWithString:actRow.activity.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_full_size"]];
    self.goodsView.actRow = actRow;
}
@end
