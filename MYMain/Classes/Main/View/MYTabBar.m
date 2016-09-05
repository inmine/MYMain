//
//  MYTabBar.m
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYTabBar.h"
@interface MYTabBar()

@property (nonatomic, weak) UIButton *plusBtn;

@end

@implementation MYTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
 /*********** 中间特殊tabbar  *********/
//        UIButton *plusBtn = [[UIButton alloc] init];
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
//        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
//        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
//        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        plusBtn.size = plusBtn.currentBackgroundImage.size;
//        [plusBtn addTarget:self action:@selector(PlusClick) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:plusBtn];
//        
//        self.plusBtn = plusBtn;
    }
    return self;
}

- (void)PlusClick{
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarClickPlusButton:)]) {
        
        [self.delegate tabBarClickPlusButton:self];
    }
    
}

// Subviews 的布局
- (void)layoutSubviews{
    
    [super layoutSubviews];
    
/************* 5个tabbar *************/
//    self.plusBtn.centerX = self.width * 0.5;
//    self.plusBtn.centerY = self.height * 0.5;
//    
//    // 2.设置其他tabbarButton的位置和尺寸
//    CGFloat tabbarButtonW = self.width / 5;
//    CGFloat tabbarButtonIndex = 0;
//    
//    for (UIView *child in self.subviews) {
//        
//        Class class = NSClassFromString(@"UITabBarButton");
//        // 判断child 是否是 UITabBarButton
//        if ([child isKindOfClass:class]) {
//            
//            child.width = tabbarButtonW;
//            child.x = tabbarButtonW * tabbarButtonIndex;
//            
//            tabbarButtonIndex ++;
//            
//            if (tabbarButtonIndex == 2) {
//                
//                tabbarButtonIndex ++;
//            }
//        }
//        
//    }
    
    
/************* 4个tabbar *************/
    // 2.设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonW = self.width / 4;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        
        Class class = NSClassFromString(@"UITabBarButton");
        // 判断child 是否是 UITabBarButton
        if ([child isKindOfClass:class]) {
            
            child.width = tabbarButtonW;
            child.x = tabbarButtonW * tabbarButtonIndex;
            
            tabbarButtonIndex ++;
            
        }
        
    }
    
    
}

@end
