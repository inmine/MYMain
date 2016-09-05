//
//  MYCycleScrollView.h
//  MYMain
//
//  Created by admin on 16/6/27.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCycleScrollView : UIView<UIScrollViewDelegate>{
    
    NSMutableArray *_imageName;
    NSInteger _currentIndex;
    UIScrollView *_scrollView;
    //用来储存3个图片的视图
    NSMutableArray *_viewArray;
    NSTimer *_timer;
    BOOL _isDraw;
}

- (instancetype)initWithFrame:(CGRect)frame imageList:(NSMutableArray *)imageName;
- (NSInteger)indexForCurrentIndex:(NSInteger)index;
- (void)updateScrollView;
- (void)autoScroll;

@end
