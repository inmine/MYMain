//
//  AppDelegate.m
//  MYMain
//
//  Created by admin on 16/6/22.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "AppDelegate.h"
#import "MYTabBarController.h"
#import "MYNewfeatureViewController.h"
#import "MYLoginViewController.h"
//#import "MYChatHelper.h"

@interface AppDelegate ()<EMClientDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1,创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 2,设置根控制器
    NSString *key = @"CFBundleVersion";
    
    // 上次版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    // 取出当前版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // 判读版本号是否一样
    if ([lastVersion isEqualToString:currentVersion]) {
        
        //一样，直接进入主页面
        MYLoginViewController *loginVC = [[MYLoginViewController alloc] init];
        self.window.rootViewController = loginVC;
    }else{
        
        //  不一样，进入版本新特性
        MYNewfeatureViewController *newFeatureVC = [[MYNewfeatureViewController alloc] init];
        self.window.rootViewController = newFeatureVC;
        
        // 将当前版本存入沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
//    MYLoginViewController *loginVC = [[MYLoginViewController alloc] init];
//    self.window.rootViewController = loginVC;
    
    // 3,显视窗口
    [self.window makeKeyAndVisible];

#pragma mark - 注册的AppKey
    //AppKey:注册的AppKey，详细见下面注释。
    //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
    EMOptions *options = [EMOptions optionsWithAppkey:@"inmine#yingmin"];
    options.apnsCertName = @".xmppchat";
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [ChatDemoHelper shareHelper];
#pragma mark - 红包
    // 红包：appKey为环信分配的appKey,格式为#
    //TODO:1 配置商户的AppKey
//    [[RedPacketUserConfig sharedConfig] configWithAppKey:@"inmine#yingmin"];
    
#pragma mark - 添加回调监听代理
    // 设置chatManager代理
    // 写个nil 默认代理会在主线程调用
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
#pragma mark - 自动登录
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        NSLog(@"没有登录");
    }else{
        NSLog(@"自动登录登录");
        // window 切换视图是不可逆的(适用上个视图只使用一次)
        MYTabBarController *tabbarVC = [[MYTabBarController alloc] init];
        [ChatDemoHelper shareHelper].mainVC = tabbarVC;
        self.window.rootViewController = tabbarVC;
        
    }
    
#pragma mark - 被动退出登录
//    EMError *error = [[EMClient sharedClient] logout:YES];
//    if (!error) {
//        MYLog(@"被动退出登录");
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        MYLoginViewController *loginVC = [[MYLoginViewController alloc] init];
//        window.rootViewController = loginVC;
//        
//    }
    
    return YES;
}

#pragma mark 被动退出登录的回调
- (void)didAutoLoginWithError:(EMError *)aError{
    if (!aError) {
        NSLog(@"自动登录成功");
    }else{
        NSLog(@"自动登录失败 %@",aError);
    }
}

#pragma mark 退出登录的回调
/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)didLoginFromOtherDevice{
    NSLog(@"当前登录账号在其它设备登录");
}

/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)didRemovedFromServer{
     NSLog(@"当前登录账号已经被从服务器端删除");
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

@end
