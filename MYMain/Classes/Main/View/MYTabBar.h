//
//  MYTabBar.h
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYTabBar;
// #warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol MYTabBarDelegate <UITabBarDelegate>

// 可选实现
@optional
- (void)tabBarClickPlusButton: (MYTabBar *)tabbar;

@end

@interface MYTabBar : UITabBar <MYTabBarDelegate>

@property (nonatomic, weak) id<MYTabBarDelegate> delegate;

@end
