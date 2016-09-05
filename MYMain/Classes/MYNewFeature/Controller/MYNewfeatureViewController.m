//
//  MYNewfeatureViewController.m
//  MYMain
//
//  Created by admin on 16/6/28.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYNewfeatureViewController.h"
#import "MYLoginViewController.h"

/** 新特性图片张数 */
#define MYNewFeatureCount 4

@interface MYNewfeatureViewController ()<UIScrollViewDelegate>

/** UIScrollView */
@property (strong, nonatomic) UIScrollView *scrollView;
/** 新特性页码 */
@property (nonatomic, strong) UIPageControl *pageControl;
/** 开始按钮 */
@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation MYNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建 UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    // UIScrollView 中添加图片
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    
    for (int i=0; i< MYNewFeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.x = scrollW * i;
        imageView.y = 0;
        
        NSString *nfstr = [NSString stringWithFormat:@"new_feature_%d",i+1];
        imageView.image = [UIImage imageNamed:nfstr];
        [scrollView addSubview:imageView];
        
        // 取出最后一张照片
        if (i == MYNewFeatureCount - 1) {
            [self creatBtn:imageView];
        }
    }
    
#warning 默认情况下，scrollView一创建出来，它里面可能就存在一些子控件了
#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
    //  UIScrollView的其他属性
    scrollView.contentSize = CGSizeMake(scrollW * MYNewFeatureCount, 0);
    // 去掉反弹效果
    scrollView.bounces = NO;
    // 去掉水平方向上的滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 具有分页效果
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    
    // 创建UIpageControll
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = MYNewFeatureCount;
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.centerY.equalTo(self.view.mas_bottom).with.offset(-60);
        make.width.equalTo(@(100));
        make.height.equalTo(@(44));
    }];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
    
    // 如果在最后一页 动画显示开始
    if (self.pageControl.currentPage == MYNewFeatureCount - 1) {
        [UIView animateWithDuration:1 animations:^{
            [self.startBtn layoutIfNeeded];
            self.startBtn.y = HEIGHT-120-20;
            self.startBtn.alpha = 1;
        }];
    }
}

#pragma mark - 最后一页添加按钮
- (void)creatBtn:(UIImageView *)imageView{
    
    // 用户交互
    imageView.userInteractionEnabled = YES;
    
    // 开始MYMain
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateNormal];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    startBtn.alpha = 0;
    [imageView addSubview:startBtn];
    self.startBtn = startBtn;
    [startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView.mas_centerX);
        make.centerY.equalTo(imageView.mas_bottom);
        make.width.equalTo(@(120));
        make.height.equalTo(@(44));
    }];
    
    // 分享按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享MY.Ying" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    [imageView addSubview:shareBtn];
    
    // EdgeInsets: 自切
    // contentEdgeInsets:会影响按钮内部的所有内容（里面的imageView和titleLabel）
    //    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 100, 0, 0);
    
    // titleEdgeInsets:只影响按钮内部的titleLabel
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    // imageEdgeInsets:只影响按钮内部的imageView
    
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView.mas_centerX);
        make.bottom.equalTo(imageView.mas_bottom).with.offset(-170);
        make.width.equalTo(@(140));
        make.height.equalTo(@(44));
    }];
    
}

#pragma mark -  分享取反
- (void)shareClick:(UIButton *)shareBtn{
    
    // 取反
    shareBtn.selected = !shareBtn.isSelected;
}

#pragma mark - 开始
- (void)startClick{
    
    // 可逆切换视图
//    MYTabBarController *tabBarVC = [[MYTabBarController alloc] init];
//    [self presentViewController:tabBarVC animated:YES completion:nil];
    
    // window 切换视图是不可逆的(适用上个视图只使用一次)
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.alpha = 0.1;
    } completion:^(BOOL finished) {
        MYLoginViewController *loginVC = [[MYLoginViewController alloc] init];
        window.rootViewController = loginVC;
    }];
    
}

@end
