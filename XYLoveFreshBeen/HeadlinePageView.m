//
//  HeadlinePageView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "HeadlinePageView.h"
#import "HeadlineContentView.h"

@interface HeadlinePageView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,strong) UIScrollView *scrollView;
@property (nonatomic )        NSInteger currentPage;

@end
//最大重用个数
static const CGFloat MaxContentViewCount = 3;

@implementation HeadlinePageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        for (NSInteger i = 0; i<MaxContentViewCount; i++) {
            HeadlineContentView *contentView = [[HeadlineContentView alloc]init];
            contentView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contentViewClick:)];
            [contentView addGestureRecognizer:tap];
            [_scrollView addSubview:contentView];
        }
    }
    return self;
}

-(void)contentViewClick:(UITapGestureRecognizer *)tap{
    if (self.callback) {
        self.callback(HeadViewItemTypeHeadline, tap.view.tag);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    CGFloat scrollViewW = self.scrollView.frame.size.width;
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    self.scrollView.contentSize = CGSizeMake(scrollViewW, scrollViewH *MaxContentViewCount);
    for (NSInteger i = 0; i < MaxContentViewCount; i++) {
        HeadlineContentView *contentView = self.scrollView.subviews[i];
        contentView.frame = CGRectMake(0, i *scrollViewH, scrollViewW, scrollViewH);
    }
}

-(void)updateHeadlinePageView{
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    for (NSInteger i = 0; i < MaxContentViewCount; i++) {
        NSInteger index = self.currentPage;
        HeadlineContentView *contentView = self.scrollView.subviews[i];
        if (i == 0) {
            index --;
        }else if (i == 2){
            index ++;
        }
        
        if (index < 0) {
            index = self.headline.act_rows.count - 1;
        }else if (index > self.headline.act_rows.count - 1){
            index = 0;
        }
        contentView.tag = index;
        contentView.actRow = self.headline.act_rows[index];
    }
    self.scrollView.contentOffset = CGPointMake(0, scrollViewH);
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat minDistance = MAXFLOAT;
    for (NSInteger i = 0; i < MaxContentViewCount; i++) {
        HeadlineContentView *contentView = self.scrollView.subviews[i];
        CGFloat distance = fabs(contentView.frame.origin.y - self.scrollView.contentOffset.y);
        if (distance < minDistance) {
            minDistance = distance;
            self.currentPage = contentView.tag;
        }
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updateHeadlinePageView];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateHeadlinePageView];
}

-(void)statrTimer{
    self.timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

-(void)stopTimer{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

-(void)next{
    CGFloat scrollViewH = self.scrollView.frame.size.height;
    
    [self.scrollView setContentOffset:CGPointMake(0, 2 *scrollViewH) animated:YES];
}
-(void)setHeadline:(ActInfo *)headline{
    [self layoutIfNeeded];
    _headline = headline;
    self.currentPage = 0;
    [self stopTimer];
    [self statrTimer];
    [self updateHeadlinePageView];
}
@end
