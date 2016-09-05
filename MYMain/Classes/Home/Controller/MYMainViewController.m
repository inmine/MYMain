//
//  MYMainCollectionViewController.m
//  MYMain
//
//  Created by admin on 16/6/22.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYMainViewController.h"
#import "EMSDK.h"

@interface MYMainViewController ()<SDCycleScrollViewDelegate,EMClientDelegate,EMContactManagerDelegate,UIAlertViewDelegate>

/**  */
@property (nonatomic, strong) NSArray *addImageArray;

/** 好友名称 */
@property (nonatomic, copy) NSString *buddyUsername;

@end

@implementation MYMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    
    // 屏幕的宽高
    NSLog(@"%f,%f",WIDTH,HEIGHT);
    
    // 状态栏(statusbar)
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    NSLog(@"status width - %f", rectStatus.size.width); // 宽度
    NSLog(@"status height - %f", rectStatus.size.height);   // 高度
    
    // 导航栏（navigationbar）
    CGRect rectNav = self.navigationController.navigationBar.frame;
    NSLog(@"nav width - %f", rectNav.size.width); // 宽度
    NSLog(@"nav height - %f", rectNav.size.height);   // 高度
    
    // 添加 滚动条
    [self addRolling];
    
}

#pragma mark - 添加 滚动条
- (void)addRolling{
    
    // 本地图片
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",
                            @"h4.jpg",
                            ];
    
    // 图片配文字
    NSArray *titles = @[@"海贼王",
                        @"火影忍者",
                        @"江户川柯南",
                        @"浪客剑心"
                        ];
    
    // 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT* 0.25) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    // 页面点居右
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    // 每页文字
    cycleScrollView2.titlesGroup = titles;
    // 加载图片
    cycleScrollView2.imageURLStringsGroup = imageNames;
    // 自定义分页控件小圆标颜色
    cycleScrollView2.currentPageDotColor = [UIColor whiteColor];
    [self.view addSubview:cycleScrollView2];
    
}

#pragma mark - SDCycleScrollViewDelegate 点击某张触发事件
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    
    [self.navigationController pushViewController:[NSClassFromString(@"DemoVCWithXib") new] animated:YES];
}

#pragma mark - EMClientDelegate 网络状况链接改变
- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState{
//    EMConnectionConnected = 0,  /*! *\~chinese 已连接 *\~english Connected */
//    EMConnectionDisconnected,   /*! *\~chinese 未连接 *\~english Not connected */
    if (aConnectionState == EMConnectionConnected) {
        MYLog(@"已经连接");
        self.title = @"Main";
    }else{
        MYLog(@"未连接");
        self.title = @"未连接";
    }
}

#pragma mark - EMClientDelegate 自动登录失败时的回调
- (void)didAutoLoginWithError:(EMError *)aError{
    if (!aError) {
        MYLog(@"网络连接后，自动重连接成功");
    }else{
        MYLog(@"网络断开后，自动重连接失败");
    }
}

#pragma mark - EMContactManagerDelegate 好友请求被同意
/*!
 *  \~chinese
 *  用户B同意用户A的加好友请求后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername{
    
    // 提醒用户，好友请求被同意
    NSString *message = [NSString stringWithFormat:@"%@ 同意了你的好友请求",aUsername];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil,nil];
    [alert show];
}

#pragma mark - EMContactManagerDelegate 好友请求被拒绝
/*!
 *  \~chinese
 *  用户B拒绝用户A的加好友请求后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 */
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername{
    
    // 提醒用户，好友请求被拒绝
    NSString *message = [NSString stringWithFormat:@"%@ 拒绝了你的好友请求",aUsername];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"好友添加消息" message:message delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil,nil];
    [alert show];
}

#pragma mark - EMContactManagerDelegate 请求我添加好友
/*!
 *  用户A发送加用户B为好友的申请，用户B会收到这个回调
 *
 *  @param aUsername   用户名
 *  @param aMessage    附属信息
 */
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage{
    
    self.buddyUsername = aUsername;
    
    // 提醒用户，对方请求加我为好友
    NSString *message = [NSString stringWithFormat:@"%@ 请求添加为好友",aUsername];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:aMessage delegate:nil cancelButtonTitle:@"拒绝" otherButtonTitles:@"同意",nil];
    alert.delegate = self;
    [alert show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {  // 拒绝
        MYLog(@"拒绝");
        EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.buddyUsername];
        if (!error) {
             MYLog(@"发送拒绝成功");
        }
    }else{  // 同意
        MYLog(@"同意");
        EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.buddyUsername];
        if (!error) {
             MYLog(@"发送同意成功");
        }
    }
}

#pragma mark - 移除
- (void)dealloc{
    
    //移除好友回调
    [[EMClient sharedClient].contactManager removeDelegate:self];
}



@end
