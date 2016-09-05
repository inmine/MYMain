//
//  MYMainTwoViewController.m
//  MYMain
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYMainTwoViewController.h"
#import "MYAddFriendViewController.h"
#import "MYChatViewController.h"

@interface MYMainTwoViewController ()<UITableViewDelegate,UITableViewDataSource,EMClientDelegate,EMContactManagerDelegate>

/** 所有的好友 */
@property(nonatomic, strong)  UITableView *tableView;
/** 所有的好友 */
@property(nonatomic, strong)  NSArray *buddyList;

@end

@implementation MYMainTwoViewController

/** 所有的好友 */
- (NSArray *)buddyList{
    if (!_buddyList) {
        _buddyList = [[NSArray alloc] init];
    }
    return _buddyList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 添加聊天管理器的代理
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
   
    UIBarButtonItem *addFriend = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStyleBordered target:self action:@selector(addFriendClick)];
    [self.navigationItem setRightBarButtonItem:addFriend animated:YES];
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView = tableView;
    
    // 从数据库获取所有的好友
    self.buddyList = [[EMClient sharedClient].contactManager getContactsFromDB];
    
}

#pragma mark - 添加好友
- (void)addFriendClick{
    
    MYAddFriendViewController *addFriendVC = [[MYAddFriendViewController alloc] init];
    [self.navigationController pushViewController:addFriendVC animated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.buddyList.count;
}

#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"buddyListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    // 获取好友列表
    cell.textLabel.text = self.buddyList[indexPath.row];
    // 获取好友头像
    cell.imageView.image = [UIImage imageNamed:@"chatListCellHead"];

    return cell;
}

// 进入聊天界面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MYChatViewController *chatVC = [[MYChatViewController alloc] initWithConversationChatter:self.buddyList[indexPath.row] conversationType:EMConversationTypeChat];
    chatVC.buddyName = self.buddyList[indexPath.row];
    [self.navigationController pushViewController:chatVC animated:YES];
    
}

// 向左滑动删除好友
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 设置删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        NSString *deleteBuddy = self.buddyList[indexPath.row];
        // 删除好友
        EMError *error = [[EMClient sharedClient].contactManager deleteContact:deleteBuddy];
        if (!error) {
            MYLog(@"删除成功");
        }
    }];

    //滑动按钮背景
    deleteRowAction.backgroundColor = [UIColor colorWithRed:0.1332 green:0.6634 blue:1.0 alpha:1.0];
    
    return @[deleteRowAction];
}

#pragma mark - EMClientDelegate  自动登录
- (void)didAutoLoginWithError:(EMError *)aError{

    if (!aError) { //自动登录成功，从服务器获取所有的好友
        
        // 从数据库获取所有的好友
        self.buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&aError];
        // 刷新列表
        [self.tableView reloadData];
    }
}

#pragma mark - 添加好友后，更新列表
/*!
 *  \~chinese
 *  用户B同意用户A的加好友请求后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 */
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername{
    
    EMError *error = nil;
    self.buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        MYLog(@"更新获取成功 -- %@",self.buddyList);
        // 刷新
        [self.tableView reloadData];
    }
}

#pragma mark - 同意接受好友添加，更新列表
/*!
 *  \~chinese
 *  用户B同意用户A的好友申请后，用户A和用户B都会收到这个回调
 *
 *  @param aUsername   用户好友关系的另一方
 */
- (void)didReceiveAddedFromUsername:(NSString *)aUsername{
    
    EMError *error = nil;
    self.buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        MYLog(@"更新获取成功 -- %@",self.buddyList);
        // 刷新
        [self.tableView reloadData];
    }
}

#pragma mark - 同意接受好友添加，更新列表
/*!
 *  \~chinese
 *  用户B删除与用户A的好友关系后，用户A会收到这个回调
 *
 *  @param aUsername   用户B
 */
- (void)didReceiveDeletedFromUsername:(NSString *)aUsername{
    
    EMError *error = nil;
    self.buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (!error) {
        MYLog(@"更新获取成功 -- %@",self.buddyList);
        // 刷新
        [self.tableView reloadData];
    }
}


@end
