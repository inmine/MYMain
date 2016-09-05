//
//  MYAddFriendViewController.m
//  MYMain
//
//  Created by admin on 16/7/3.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYAddFriendViewController.h"
#import "EMSDK.h"

@interface MYAddFriendViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *afTF;

@end

@implementation MYAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加好友";
    
    UIBarButtonItem *searchFriend = [[UIBarButtonItem alloc] initWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchFriendClick)];
    [self.navigationItem setRightBarButtonItem:searchFriend animated:YES];
    
    // 添加好友搜索框
    UITextField *afTF = [[UITextField alloc] init];
    afTF.frame = CGRectMake(50, 100, 200, 30);
    afTF.placeholder= @"请输入要查找的好友";
    afTF.delegate = self;
    afTF.returnKeyType = UIReturnKeyDone;
    afTF.backgroundColor = [UIColor grayColor];
    [self.view addSubview:afTF];
    self.afTF = afTF;
    
}

#pragma mark - 添加好友
- (void)searchFriendClick{
    
    // 1.获取要添加好友的名字
    NSString *username = self.afTF.text;
    
    // 2.向服务器发送一个添加好友的请求
    // buddy 哥儿们
    // message ： 请求添加好友的 额外信息
    NSString *loginUsername = [EMClient sharedClient].currentUsername;
    NSString *message = [@"我是" stringByAppendingString:loginUsername];
    
    EMError *error = [[EMClient sharedClient].contactManager addContact:username message:message];
     MYLog(@"username:%@",loginUsername);
    if (!error) {
        NSLog(@"获取成功");
    }else{
        NSLog(@"获取失败%@",error);
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    
    return YES;
}

@end
