//
//  MineHeadView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/24.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "MineHeadView.h"

@implementation MineHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"v2_my_avatar_bg"];
        
        UIButton *button = [[UIButton alloc]init];
        [button setImage:[UIImage imageNamed:@"v2_my_settings_icon"] forState:UIControlStateNormal];
        [self addSubview:button];
        
        UIImageView *headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_my_avatar"]];
        [self addSubview:headImageView];
        
        UILabel *phoneLable = [[UILabel alloc]init];
        phoneLable.text = @"编程小学生";
        phoneLable.font = [UIFont systemFontOfSize:20];
        phoneLable.textColor = [UIColor whiteColor];
        phoneLable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:phoneLable];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self).offset(-10);
            make.top.equalTo(self).offset(10);
            make.width.and.height.mas_equalTo(50);
        }];
        
        [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(50);
        }];
        
        [phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(headImageView.mas_bottom).offset(5);
            make.leading.trailing.equalTo(self);
            make.height.equalTo(@30);
        }];
    }
    return self;
}

@end
