//
//  MenuView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "MenuView.h"
#import "TitleIconView.h"

static const NSInteger DefaultRowNumbers = 4;

@interface MenuView ()

@property (nonatomic ,strong) NSArray<TitleIconAction *> *menus;
@property (nonatomic )        BOOL showLine;

@end

@implementation MenuView

-(instancetype)initMenus:(NSArray<TitleIconAction *> *)menus WithLine:(BOOL)showLine{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.menus = menus;
        for (TitleIconAction *menu in menus) {
            TitleIconView *titleIconView = [[TitleIconView alloc]initWithTitleLable:menu.title icon:menu.icon boder:showLine];
            titleIconView.userInteractionEnabled = YES;
            titleIconView.tag = menu.tag;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleIconViewClick:)];
            [titleIconView addGestureRecognizer:tap];
            [self addSubview:titleIconView];
        }
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat viewW = self.bounds.size.width / DefaultRowNumbers;
    CGFloat viewH = self.bounds.size.height / (self.menus.count / DefaultRowNumbers);
    
    for (NSInteger i = 0; i < self.subviews.count; i++) {
        TitleIconView *titleView = self.subviews[i];
        CGFloat viewX = (i % DefaultRowNumbers) *viewW;
        CGFloat viewY = (i / DefaultRowNumbers) *viewH;
        titleView.frame = CGRectMake(viewX, viewY, viewW, viewH);
    }
}

-(void)titleIconViewClick:(UITapGestureRecognizer *)tap{
    
}
@end
