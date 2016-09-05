//
//  MYCycleScrollView.m
//  MYMain
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYCycleScrollView.h"

@interface MYCycleScrollView () {
    UIPageControl *_page;
    double _numOfPage;
}

@end

@implementation MYCycleScrollView

- (instancetype)initWithFrame:(CGRect)frame imageList:(NSMutableArray *)imageName {
    
    self = [super initWithFrame:frame];
    if (self) {
        _imageName = [[NSMutableArray alloc] init];
        _viewArray = [[NSMutableArray alloc] init];
        _imageName = imageName;
        _currentIndex = 0;
        [self initializeAppearance];
    }
    return self;
}

// 下标处理
- (NSInteger)indexForCurrentIndex:(NSInteger)index {
    
    if (index < 0) {
        return [_imageName count] - 1;
    }
    if (index > [_imageName count] - 1) {
        return 0;
    }
    return index;
}

- (void)initializeAppearance {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.contentSize = CGSizeMake(CGRectGetMaxX(self.bounds) * 3, CGRectGetMaxY(self.bounds));
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    
    for (int i = 0; i < 3;  i ++) {
        
        NSInteger index = [self indexForCurrentIndex:i - 1];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.bounds) * i, 0, CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds))];
        //        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:_imageName[index]];
        //        [imageView setImageWithURL:[NSURL URLWithString:_imageName[index]]];
        [_scrollView addSubview:imageView];
        //        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.left.equalTo(@(CGRectGetMaxX(self.bounds) * i));
        //            make.width.mas_equalTo(@(CGRectGetMaxX(self.bounds)));
        //            make.height.mas_equalTo(@(CGRectGetMaxY(self.bounds)));
        //        }];
        [_viewArray addObject:imageView];
    }
    [_scrollView setContentOffset:CGPointMake(CGRectGetMaxX(self.bounds), 0) animated:NO];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    // 添加分页控制器
    _page = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    _page.numberOfPages = _imageName.count;
    _page.center = CGPointMake(self.bounds.size.width / 6 * 5, self.bounds.size.height * 0.95);
    [self addSubview:_page];
    
    // 开始定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    
}

// 配置自动滚动
- (void)autoScroll {
    
    CGPoint newOffset = CGPointMake(_scrollView.contentOffset.x * 2, 0);
    [_scrollView setContentOffset:newOffset animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateScrollView];
    // 计算偏移量 更改分页控制器显示
    _numOfPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    _page.currentPage = _currentIndex;
}

/**
 *  刷新ScrollView
 */
- (void)updateScrollView {
    
    BOOL isNeedUpdate = NO;
    if (_scrollView.contentOffset.x <= 0) {
        isNeedUpdate = YES;
        _currentIndex --;
        _currentIndex = [self indexForCurrentIndex:_currentIndex];
    }
    if (_scrollView.contentOffset.x >= CGRectGetMaxX(self.bounds) * 2) {
        isNeedUpdate = YES;
        _currentIndex ++;
        _currentIndex = [self indexForCurrentIndex:_currentIndex];
    }
    if (isNeedUpdate == NO) {
        
        return;
    }
    
    for (int i = 0; i < 3; i ++) {
        UIImageView *imageView = _viewArray[i];
        NSInteger index = _currentIndex + i - 1;
        index = [self indexForCurrentIndex:index];
        imageView.image = [UIImage imageNamed:_imageName[index]];
        //        [imageView setImageWithURL:[NSURL URLWithString:_imageName[index]]];
    }
    
    [_scrollView setContentOffset:CGPointMake(CGRectGetMaxX(self.bounds), 0) animated:NO];
}


- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    if (_isDraw == NO) {
        [_timer invalidate];
        [self performSelector:@selector(addTimer) withObject:self afterDelay:3];
        _isDraw = YES;
    }
}
/**
 *  添加定时器
 */
- (void)addTimer {
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _isDraw = NO;
}

@end
