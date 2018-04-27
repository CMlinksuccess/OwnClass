//
//  ImageAutoScrollView.m
//  ImageAutoScrollView
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ImageAutoScrollView.h"

#define kScrollWith self.frame.size.width
#define kScrollHeight  self.frame.size.height

@interface ImageAutoScrollView ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIPageControl *pageView;

@property (nonatomic,strong)NSTimer *timer;

@end
@implementation ImageAutoScrollView

- (void)createScrollView
{
    
    if (self.scrollView == nil) {
        
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScrollWith, kScrollHeight)];
        [self addSubview:self.scrollView];
    }
    
    [self removeNStimer];
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    
    
    //set delegate
    self.scrollView.delegate = self;
    
    self.scrollView.pagingEnabled = YES;
    
    self.scrollView.showsHorizontalScrollIndicator = NO;

    for (NSInteger i = 0; i < self.imageArray.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed: self.imageArray[i]]];
        imageView.frame = CGRectMake(i * kScrollWith, 0 , kScrollWith, kScrollHeight);
        [self.scrollView addSubview:imageView];
    }
    
    //set scrollView contentSize
    self.scrollView.contentSize = CGSizeMake(kScrollWith * self.imageArray.count, 0);
    
    if (self.pageView == nil) {
        
        self.pageView = [[UIPageControl alloc]initWithFrame:CGRectMake(0, kScrollHeight - 18, kScrollWith, 18)];
        [self addSubview:self.pageView];
    }
    self.pageView.numberOfPages = self.imageArray.count;
    self.pageView.currentPageIndicatorTintColor = self.currentColor;
    self.pageView.pageIndicatorTintColor = self.NoncurrentColor;
 
    if (self.isAutoScroll) {
        
        [self startNStimer];
    }
}


- (void)startNStimer
{
    
    if (_scrollTime == 0 ) {
        _scrollTime = 2;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollTime target:self selector:@selector(nextAction:)  userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

- (void)removeNStimer
{
    [self.timer invalidate];
    self.timer = nil;

}

//scroll next page
- (void)nextAction:(NSTimer *)timer
{
    NSInteger page = 0;
    if (self.pageView.currentPage == self.imageArray.count - 1) {
        page = 0;
    }else{
       page = self.pageView.currentPage + 1;
    }
    
    CGPoint offset = CGPointMake(page  * self.scrollView.frame.size.width, 0);
    [self.scrollView setContentOffset:offset animated:YES];

}


#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageView.currentPage = (scrollView.contentOffset.x + scrollView.frame.size.width * .5) / scrollView.frame.size.width;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeNStimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.isAutoScroll) {
        
        [self startNStimer];
    }
}

#pragma mark -set property
-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    [self createScrollView];
}

- (void)setCurrentColor:(UIColor *)currentColor
{
    _currentColor = currentColor;
    
    [self createScrollView];
}

-(void)setNoncurrentColor:(UIColor *)NoncurrentColor
{
    _NoncurrentColor = NoncurrentColor;
    
    [self createScrollView];
}

- (void)setScrollTime:(NSInteger)scrollTime
{
    _scrollTime = scrollTime;
    
    [self createScrollView];
}

- (void)setIsAutoScroll:(BOOL)isAutoScroll
{
    _isAutoScroll = isAutoScroll;
    
    [self createScrollView];
}
@end
























