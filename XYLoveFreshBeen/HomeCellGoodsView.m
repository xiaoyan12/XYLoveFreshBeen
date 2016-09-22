//
//  HomeCellGoodsView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HomeCellGoodsView.h"
#import "HomeCell.h"

@implementation HomeCellGoodsView

-(instancetype)init{
    if (self = [super init]) {
        for (NSInteger i = 0; i < 3; i++) {
            HomeCell *homecell = [[HomeCell alloc]init];
            homecell.layer.borderColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0].CGColor;
            homecell.layer.borderWidth = 0.5;
            [self addSubview:homecell];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat cellH = 200;
    CGFloat cellW = XYWidth /3;
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        HomeCell *cell = self.subviews[i];
        cell.frame = CGRectMake(i * cellW, 0, cellW, cellH);
    }
}

-(void)setActRow:(ActRow *)actRow{
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        HomeCell *cell = self.subviews[i];
        cell.buyViewShowZear = YES;
        cell.goods = actRow.category_detail.goods[i];
    }
}
@end

