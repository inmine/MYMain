//
//  MYLoginViewController.m
//  YingMin
//
//  Created by admin on 16/7/1.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYLoginViewController.h"
#import "MYTabBarController.h"
#import "EMSDK.h"

@interface MYLoginViewController ()

@property (nonatomic, strong) UITextField *zhuanghuTF;
@property (nonatomic, strong) UITextField *minmaTF;

@end

@implementation MYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"YingMinChat";
    
    UITextField *zhuanghuTF = [[UITextField alloc] init];
    zhuanghuTF.frame = CGRectMake(50, 100, 200, 30);
    zhuanghuTF.backgroundColor = [UIColor grayColor];
    zhuanghuTF.placeholder = @"个人账户／手机";
    [self.view addSubview:zhuanghuTF];
    self.zhuanghuTF = zhuanghuTF;
    
    UITextField *minmaTF = [[UITextField alloc] init];
    minmaTF.frame = CGRectMake(50, 150, 200, 30);
    minmaTF.backgroundColor = [UIColor grayColor];
    minmaTF.placeholder = @"密码";
    [self.view addSubview:minmaTF];
    self.minmaTF = minmaTF;
    
    UIButton *zhuce = [[UIButton alloc] init];
    zhuce.backgroundColor = [UIColor blueColor];
    zhuce.frame = CGRectMake(50, 200, 70, 50);
    [zhuce setTitle:@"注册" forState:UIControlStateNormal];
    [zhuce setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [zhuce addTarget:self action:@selector(zhuceClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:zhuce];
    
    UIButton *denglu = [[UIButton alloc] init];
    denglu.backgroundColor = [UIColor redColor];
    denglu.frame = CGRectMake(150, 200, 70, 50);
    [denglu setTitle:@"登录" forState:UIControlStateNormal];
    [denglu setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [denglu addTarget:self action:@selector(dengluClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:denglu];
    
}

- (void)zhuceClick{
    
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:self.zhuanghuTF.text password:self.minmaTF.text];
    if (error==nil) {
        NSLog(@"注册成功");
    }else{
        NSLog(@"注册失败");
    }
}

- (void)dengluClick{
    

    // 自动登录：即首次登录成功后，不需要再次调用登录方法，在下次 APP 启动时，SDK 会自动为您登录。并且如果您自动登录失败，也可以读取到之前的会话信息。
    EMError *error = [[EMClient sharedClient] loginWithUsername:self.zhuanghuTF.text password:self.minmaTF.text];
    if (!error)
    {
        NSLog(@"登录成功");
        [[EMClient sharedClient].options setIsAutoLogin:YES];
        
       
        // window 切换视图是不可逆的(适用上个视图只使用一次)
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        [UIView animateWithDuration:0.5 animations:^{
            self.view.alpha = 0.1;
        } completion:^(BOOL finished) {
             MYTabBarController *tabbarVC = [[MYTabBarController alloc] init];
            [ChatDemoHelper shareHelper].mainVC = tabbarVC;
            window.rootViewController = tabbarVC;
        }];
        
        
        // 让环信SDK在"第一次"登录完成之后，自动从服务器获取好友列表，添加到本地数据库(Buddy表)
        EMError *aerror = nil;
        NSArray *userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&aerror];
        NSLog(@"%@",userlist);
        if (!aerror) {
            NSLog(@"获取成功");
        }else{
            NSLog(@"获取失败%@",aerror.errorDescription);
        }
        
    }else{
        NSLog(@"登录失败");
    }
}


@end
