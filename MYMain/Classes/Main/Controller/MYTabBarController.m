//
//  MYTabBarController.m
//  MYMain
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYTabBarController.h"
#import "MYNavigationViewController.h"
#import "MYMainViewController.h"
#import "MYMainTwoViewController.h"
#import "MYMainThreeViewController.h"
#import "MYMineViewController.h"
#import "MYTabBar.h"

@interface MYTabBarController ()<MYTabBarDelegate>

@end

@implementation MYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    NSString *from = [[EMClient sharedClient] currentUsername];
   
    // 设置子控制器
    MYMainViewController *mainVC = [[MYMainViewController alloc] init];
    [self addChildVC:mainVC title:@"Main" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    MYMainTwoViewController *mainTwoVC = [[MYMainTwoViewController alloc] init];
    [self addChildVC:mainTwoVC title:from image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    MYMainThreeViewController *mainThreeVC = [[MYMainThreeViewController alloc] init];
    [self addChildVC:mainThreeVC title:@"Three" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    MYMineViewController *mineVC = [[MYMineViewController alloc] init];
    [self addChildVC:mineVC title:@"Mine" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // 自定义TabBar
    MYTabBar *plusTabBar = [[MYTabBar alloc] init];
    // 点击按钮弹出下个界面的 delegate
    plusTabBar.delegate = self;
    
    // KVC 将plusTabBar 给了 tabBar 相当于 self.tabBar = plusTabBar;
    [self setValue:plusTabBar forKeyPath:@"tabBar"];
    
}

// 很多重复代码 －－> 将重复代码抽取到一个方法中
// 1,相同的东西变成参数
// 2,不同的东西变成参数
// 3,在使用到这段代码的这个地方调用方法，传递参数
- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    
    //设置子控制器的文字和图片
    childVC.tabBarItem.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    // 声明： 这张图片按照原始的样子显示出来，不要自动渲染成其他颜色（比如蓝色）
    // 不要渲染图片
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //导航栏中的文字
    childVC.navigationItem.title = title;
    
    // 不要渲染文字 (为选中的颜色)
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName]= [UIColor lightGrayColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    // 选中后的颜色
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    //    childVC.view.backgroundColor = [UIColor redColor];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    MYNavigationViewController *nav = [[MYNavigationViewController alloc] initWithRootViewController:childVC];
    // 添加为子控制器
    [self addChildViewController:nav];
    
}

#pragma mark - 特殊tabbar
- (void)tabBarClickPlusButton:(MYTabBar *)tabbar{
    
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor greenColor];
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
