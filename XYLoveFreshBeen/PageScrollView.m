//
//  PageScrollView.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/20.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "PageScrollView.h"

@interface PageScrollView ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIPageControl *pageControl;
@property (nonatomic ,strong) UIScrollView *imageScrollView;
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic ,strong) NSArray<NSString *> *images;
@property (nonatomic ,strong) UIImage *placeHolderImage;

@end

static const NSInteger MaxImageViewCount = 3;

@implementation PageScrollView

+(instancetype)pageScrollView:(NSArray<NSString *> *)images placeHolder:(UIImage *)placeHolderImage{
    PageScrollView *pageSrollView = [[self alloc]init];
    pageSrollView.images = images;
    pageSrollView.placeHolderImage = placeHolderImage;
    
    return pageSrollView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIScrollView *view = [[UIScrollView alloc]init];
        view.showsVerticalScrollIndicator = NO;
        view.showsHorizontalScrollIndicator = NO;
        view.pagingEnabled = YES;
        view.bounces = NO;
        view.delegate = self;
        [self addSubview:view];
        self.imageScrollView = view;

        for (NSInteger i = 0; i < MaxImageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
            [imageView addGestureRecognizer:tap];
            [self.imageScrollView addSubview:imageView];
        }
        self.pageControl = [[UIPageControl alloc]init];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_selected"]];
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_normal"]];
        [self addSubview:self.pageControl];
        
    }
    return self;
}

-(void)imageViewClick:(UITapGestureRecognizer *)tap{
    if (_callback) {
        _callback(HeadViewItemTypePage,tap.view.tag);
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageScrollView.frame = self.bounds;
    CGFloat imageScrollViewW = self.imageScrollView.frame.size.width;
    CGFloat imageScrollViewH = self.imageScrollView.frame.size.height;
    self.imageScrollView.contentSize = CGSizeMake(imageScrollViewW * MaxImageViewCount, 0);
    for (NSInteger i = 0; i < self.imageScrollView.subviews.count; i++) {
        UIImageView *imageView = self.imageScrollView.subviews[i];
        imageView.frame = CGRectMake(i * imageScrollViewW, 0, imageScrollViewW, imageScrollViewH);
    }
    self.pageControl.frame = CGRectMake(imageScrollViewW - 80, imageScrollViewH - 20, 80, 20);
    [self updatePageScrollView];
}

-(void)updatePageScrollView{
    for (NSInteger i = 0; i < self.imageScrollView.subviews.count; i++) {
        UIImageView *imageView = self.imageScrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        if (i == 0) {
            index --;
        }else if (i == 2){
            index ++;
        }
        
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        }else if (index > self.pageControl.numberOfPages -1){
            index = 0;
        }
        imageView.tag = index;
        [imageView sd_setImageWithURL:[NSURL URLWithString:self.images[index]] placeholderImage:self.placeHolderImage];
    }
    self.imageScrollView.contentOffset = CGPointMake(self.imageScrollView.frame.size.width, 0);
}

-(void)setImages:(NSArray<NSString *> *)images{
    _images = images;
    _pageControl.numberOfPages = images.count;
    _pageControl.currentPage = 0;
    
    [self stopTimer];
    [self startTimer];
    [self updatePageScrollView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat minDistance = MAXFLOAT;
    NSInteger page = 0;
    for (NSInteger i = 0; i<self.imageScrollView.subviews.count; i++) {
        UIImageView *imageView = self.imageScrollView.subviews[i];
        CGFloat distance = fabs(self.imageScrollView.contentOffset.x - imageView.frame.origin.x);
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updatePageScrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self updatePageScrollView];
}

-(void)startTimer{
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:self.timer forMode:NSDefaultRunLoopMode];
    
}

-(void)next{
    [self.imageScrollView setContentOffset:CGPointMake(self.imageScrollView.frame.size.width * 2, 0) animated:YES];
}

-(void)stopTimer{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}
@end
