//
//  ItemLeftButten.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/19.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "ItemLeftButten.h"

@implementation ItemLeftButten

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat offset = -20;
    self.titleLabel.frame = CGRectMake(offset, height -15, width, 15);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(offset, 0, width, height -15);
    self.imageView.contentMode = UIViewContentModeCenter;
}

@end

@implementation ItemRightButten

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel sizeToFit];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    CGFloat offset = 20;
    self.titleLabel.frame = CGRectMake(offset, height -15, width, 15);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(offset, 0, width, height -15);
    self.imageView.contentMode = UIViewContentModeCenter;
}

@end
