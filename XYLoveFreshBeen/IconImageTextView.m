//
//  IconImageTextView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "IconImageTextView.h"

@interface IconImageTextView ()

@property (nonatomic ,strong) UIImage *placeHolder;
@property (nonatomic ,strong) UILabel *lable;
@property (nonatomic ,strong) UIImageView *imageView;

@end

@implementation IconImageTextView

-(instancetype)init{
    if (self = [super init]) {
        self.imageView = [[UIImageView alloc]init];
        self.imageView.userInteractionEnabled = NO;
        [self addSubview:self.imageView];
        
        self.lable = [[UILabel alloc]init];
        self.lable.userInteractionEnabled = NO;
        self.lable.font = [UIFont systemFontOfSize:12];
        self.lable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.lable];
        [self.lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.height.mas_equalTo(20);
        }];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(5);
            make.top.mas_equalTo(5);
            make.trailing.mas_equalTo(-5);
            make.bottom.equalTo(self.lable.mas_top).offset(-5);
        }];
    }
    return self;
}

+(instancetype)IconImageTextView:(NSString *)imsge title:(NSString *)title placeHolder:(UIImage *)placeHolder{
    IconImageTextView *view = [[self alloc]init];
    [view.imageView sd_setImageWithURL:[NSURL URLWithString:imsge] placeholderImage:placeHolder];
    view.lable.text = title;
    return view;
}
@end
