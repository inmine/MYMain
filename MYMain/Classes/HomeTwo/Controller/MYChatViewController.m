//
//  MYChatViewController.m
//  MYMain
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYChatViewController.h"
#import "MYCustomMessageCell.h"
//#import "MYCallViewController.h"

@interface MYChatViewController ()<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource,EMLocationViewDelegate,EMCallManagerDelegate>
//{
//    NSTimer *_callTimer;
//}
//
//@property (strong, nonatomic) EMCallSession *callSession;
///** <#注释#> */
//@property (nonatomic,strong) MYCallViewController *callController;

@end

@implementation MYChatViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, 0, 0);
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
    self.tabBarController.tabBar.bounds = CGRectMake(0, self.view.frame.origin.y - 64, self.view.frame.size.width, 44);
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 好友名
    self.title= self.buddyName;
    
    // 代理（目前用于调用更换头像的方法）
    self.delegate = self;
    self.dataSource = self;
    
    // 进入聊天页面就刷新
//    [self tableViewDidTriggerHeaderRefresh];
    
#pragma mark - 实时通讯
//    // 发起语音会话
//    EMError *error = nil;
//    EMCallSession *callSessionVoice = [[EMClient sharedClient].callManager makeVoiceCall:self.buddyName error:&error];
//    
//    // 发起视频会话
//    EMCallSession *callSessionVideo = [[EMClient sharedClient].callManager makeVideoCall:self.buddyName error:&error];
//    
//    // 接受方同意通话请求
//    error = [[EMClient sharedClient].callManager answerCall:self.buddyName];
//    
//    // 结束通话
//    [[EMClient sharedClient].callManager endCall:self.buddyName reason:EMCallEndReasonHangup];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(makeCall:) name:KNOTIFICATION_CALL object:nil];
    
}

//- (void)makeCall:(NSNotification*)notify
//{
//    if (notify.object) {
//        [self makeCallWithUsername:[notify.object valueForKey:@"chatter"] isVideo:[[notify.object objectForKey:@"type"] boolValue]];
//    }
//}
//- (void)makeCallWithUsername:(NSString *)aUsername
//                     isVideo:(BOOL)aIsVideo
//{
//    if ([aUsername length] == 0) {
//        return;
//    }
//    
//    if (aIsVideo) {
//        _callSession = [[EMClient sharedClient].callManager makeVideoCall:aUsername error:nil];
//    }
//    else{
//        _callSession = [[EMClient sharedClient].callManager makeVoiceCall:aUsername error:nil];
//    }
//    
//    if(_callSession){
//        [self _startCallTimer];
//        
//        _callController = [[MYCallViewController alloc] initWithSession:_callSession isCaller:YES status:NSLocalizedString(@"连接建立完成", @"Connecting...")];
//        //        _callController.modalPresentationStyle = UIModalPresentationOverFullScreen;
//        //        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//        //        [delegate.navigationController presentViewController:_callController animated:NO completion:nil];
//        [self presentViewController:_callController animated:NO completion:nil];
//    }
//    else{
////        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"call.initFailed", @"Establish call failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"连接失败", @"Establish call failure") delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//        [alertView show];
//    }
//    
//}
//
//- (void)_startCallTimer
//{
//    _callTimer = [NSTimer scheduledTimerWithTimeInterval:50 target:self selector:@selector(_cancelCall) userInfo:nil repeats:NO];
//}
//- (void)_cancelCall
//{
//    [self hangupCallWithReason:EMCallEndReasonNoResponse];
//    
////    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"call.autoHangup", @"No response and Hang up") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"没有响应,自动挂断", @"No response and Hang up") delegate:self cancelButtonTitle:NSLocalizedString(@"ok", @"OK") otherButtonTitles:nil, nil];
//    [alertView show];
//}
//- (void)hangupCallWithReason:(EMCallEndReason)aReason
//{
//    [self _stopCallTimer];
//    
//    if (_callSession) {
//        [[EMClient sharedClient].callManager endCall:_callSession.sessionId reason:aReason];
//    }
//    
//    _callSession = nil;
//    [_callController close];
//    _callController = nil;
//}
//- (void)_stopCallTimer
//{
//    if (_callTimer == nil) {
//        return;
//    }
//    
//    [_callTimer invalidate];
//    _callTimer = nil;
//}

/*!
 @method
 @brief 获取消息自定义cell
 @discussion 用户根据messageModel判断是否显示自定义cell。返回nil显示默认cell，否则显示用户自定义cell
 @param tableView 当前消息视图的tableView
 @param messageModel 消息模型
 @result 返回用户自定义cell
 */
//具体创建自定义Cell的样例：
- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)model
{
    return nil;
}

/*!
 @method
 @brief 选中消息的回调
 @discussion 用户根据messageModel判断，是否自定义处理消息选中时间。返回YES为自定义处理，返回NO为默认处理
 @param viewController 当前消息视图
 @param messageModel 消息模型
 @result 是否采用自定义处理
 */

//选中消息回调的样例：
- (BOOL)messageViewController:(EaseMessageViewController *)viewController
        didSelectMessageModel:(id<IMessageModel>)messageModel
{
    BOOL flag = NO;
    //样例为如果消息是文件消息用户自定义处理选中逻辑
    switch (messageModel.bodyType) {
        case EMMessageBodyTypeImage:
        case EMMessageBodyTypeLocation:
        case EMMessageBodyTypeVideo:
        case EMMessageBodyTypeVoice:
            break;
        case EMMessageBodyTypeFile:
        {
            flag = YES;
            NSLog(@"用户自定义实现");
        }
            break;
        default:
            break;
    }
    return flag;
}

/*!
 @method
 @brief 点击消息头像
 @discussion 获取用户点击头像回调
 @param viewController 当前消息视图
 @param messageModel 消息模型
 @result
 */

//获取用户点击头像回调的样例：
- (void)messageViewController:(EaseMessageViewController *)viewController
  didSelectAvatarMessageModel:(id<IMessageModel>)messageModel
{
    //UserProfileViewController用户自定义的个人信息视图
    //样例的逻辑是选中消息头像后，进入该消息发送者的个人信息
    MYLog(@"点击头像了");
}

/*!
 @method
 @brief 底部录音功能按钮状态回调
 @discussion 获取底部录音功能按钮状态回调，根据EaseRecordViewType，用户自定义处理UI的逻辑
 @param viewController 当前消息视图
 @param recordView 录音视图
 @param type 录音按钮当前状态
 @result
 */
//录音按钮状态的回调样例：
- (void)messageViewController:(EaseMessageViewController *)viewController
          didSelectRecordView:(UIView *)recordView
                 withEvenType:(EaseRecordViewType)type
{
    /*
     EaseRecordViewTypeTouchDown,//录音按钮按下
     EaseRecordViewTypeTouchUpInside,//手指在录音按钮内部时离开
     EaseRecordViewTypeTouchUpOutside,//手指在录音按钮外部时离开
     EaseRecordViewTypeDragInside,//手指移动到录音按钮内部
     EaseRecordViewTypeDragOutside,//手指移动到录音按钮外部
     */
    //根据type类型，用户自定义处理UI的逻辑
    switch (type) {
        case EaseRecordViewTypeTouchDown:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView  recordButtonTouchDown];
            }
        }
            break;
        case EaseRecordViewTypeTouchUpInside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonTouchUpInside];
            }
            [self.recordView removeFromSuperview];
        }
            break;
        case EaseRecordViewTypeTouchUpOutside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonTouchUpOutside];
            }
            [self.recordView removeFromSuperview];
        }
            break;
        case EaseRecordViewTypeDragInside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonDragInside];
            }
        }
            break;
        case EaseRecordViewTypeDragOutside:
        {
            if ([self.recordView isKindOfClass:[EaseRecordView class]]) {
                [(EaseRecordView *)self.recordView recordButtonDragOutside];
            }
        }
            break;
        default:
            break;
    }
}


/*!
 @method
 @brief 触发长按手势
 @discussion 获取触发长按手势的回调，默认是NO
 @param viewController 当前消息视图
 @param indexPath 长按消息对应的indexPath
 @result
 */

- (BOOL)messageViewController:(EaseMessageViewController *)viewController
   didLongPressRowAtIndexPath:(NSIndexPath *)indexPath
{
    //样例给出的逻辑是长按cell之后显示menu视图
    id object = [self.dataArray objectAtIndex:indexPath.row];
    if (![object isKindOfClass:[NSString class]]) {
        EaseMessageCell *cell = (EaseMessageCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell becomeFirstResponder];
        self.menuIndexPath = indexPath;
        [self showMenuViewController:cell.bubbleView andIndexPath:indexPath messageType:cell.model.bodyType];
        
    }
    return YES;
}


/*!
 @method
 @brief 将EMMessage类型转换为符合<IMessageModel>协议的类型
 @discussion 将EMMessage类型转换为符合<IMessageModel>协议的类型,设置用户信息,消息显示用户昵称和头像
 @param viewController 当前消息视图
 @param EMMessage 聊天消息对象类型
 @result 返回<IMessageModel>协议的类型
 */
//具体样例： 设置用户信息，消息显示用户昵称和头像
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    NSString *from = [[EMClient sharedClient] currentUsername];
    if ([message.from isEqualToString:from]) {
        //用户可以根据自己的用户体系，根据message设置用户昵称和头像
        id<IMessageModel> model = nil;
        model = [[EaseMessageModel alloc] initWithMessage:message];
        model.avatarImage = [UIImage imageNamed:@"img.jpg"];//默认头像
        model.avatarURLPath = @"http://pic26.nipic.com/20121226/11597936_112914647182_2.jpg";//头像网络地址
        model.nickname = @"小米君";//用户昵称
        return model;
    }else{
        //用户可以根据自己的用户体系，根据message设置用户昵称和头像
        id<IMessageModel> model = nil;
        model = [[EaseMessageModel alloc] initWithMessage:message];
        model.avatarImage = [UIImage imageNamed:@"img2.jpg"];//默认头像
        model.avatarURLPath = @"http://pic26.nipic.com/20121226/11597936_112914647182_2.jpg";//头像网络地址
        model.nickname = @"Naruto";//用户昵称
        return model;
    }
    
    return nil;
}

#pragma mark - 发送消息
- (void)sendTextMessage:(NSString *)text{

    //发送文字消息
    EMMessage *message = [EaseSDKHelper sendTextMessage:text
                                                     to:self.buddyName//接收方
                                            messageType:EMChatTypeChat//消息类型
                                             messageExt:nil]; //扩展信息
    
    //发送构造成功的消息
    [[EMClient sharedClient].chatManager asyncSendMessage:message progress:nil completion:^(EMMessage *aMessage, EMError *aError) {
        
        MYLog(@"发送成功%@",text);
    }];
    
    // 刷新界面
    [self addMessageToDataSource:message
                        progress:nil];
}


#pragma mark -  收到消息的回调，带有附件类型的消息可以用 SDK 提供的下载附件方法下载（后面会讲到）
- (void)didReceiveMessages:(NSArray *)aMessages
{
    for (EMMessage *message in aMessages) {
        EMMessageBody *msgBody = message.body;
        switch (msgBody.type) {
            case EMMessageBodyTypeText:
            {
                // 收到的文字消息
                EMTextMessageBody *textBody = (EMTextMessageBody *)msgBody;
                NSString *txt = textBody.text;
                NSLog(@"收到的文字是 txt -- %@",txt);
            }
                break;
            case EMMessageBodyTypeImage:
            {
                // 得到一个图片消息body
                EMImageMessageBody *body = ((EMImageMessageBody *)msgBody);
                NSLog(@"大图remote路径 -- %@"   ,body.remotePath);
                NSLog(@"大图local路径 -- %@"    ,body.localPath); // // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"大图的secret -- %@"    ,body.secretKey);
                NSLog(@"大图的W -- %f ,大图的H -- %f",body.size.width,body.size.height);
                NSLog(@"大图的下载状态 -- %lu",body.downloadStatus);
                
                
                // 缩略图sdk会自动下载
                NSLog(@"小图remote路径 -- %@"   ,body.thumbnailRemotePath);
                NSLog(@"小图local路径 -- %@"    ,body.thumbnailLocalPath);
                NSLog(@"小图的secret -- %@"    ,body.thumbnailSecretKey);
                NSLog(@"小图的W -- %f ,大图的H -- %f",body.thumbnailSize.width,body.thumbnailSize.height);
                NSLog(@"小图的下载状态 -- %lu",body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeLocation:
            {
                EMLocationMessageBody *body = (EMLocationMessageBody *)msgBody;
                NSLog(@"纬度-- %f",body.latitude);
                NSLog(@"经度-- %f",body.longitude);
                NSLog(@"地址-- %@",body.address);
            }
                break;
            case EMMessageBodyTypeVoice:
            {
                // 音频sdk会自动下载
                EMVoiceMessageBody *body = (EMVoiceMessageBody *)msgBody;
                NSLog(@"音频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"音频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在（音频会自动调用）
                NSLog(@"音频的secret -- %@"        ,body.secretKey);
                NSLog(@"音频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"音频文件的下载状态 -- %lu"   ,body.downloadStatus);
                NSLog(@"音频的时间长度 -- %lu"      ,body.duration);
            }
                break;
            case EMMessageBodyTypeVideo:
            {
                EMVideoMessageBody *body = (EMVideoMessageBody *)msgBody;
                
                NSLog(@"视频remote路径 -- %@"      ,body.remotePath);
                NSLog(@"视频local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"视频的secret -- %@"        ,body.secretKey);
                NSLog(@"视频文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"视频文件的下载状态 -- %lu"   ,body.downloadStatus);
                NSLog(@"视频的时间长度 -- %lu"      ,body.duration);
                NSLog(@"视频的W -- %f ,视频的H -- %f", body.thumbnailSize.width, body.thumbnailSize.height);
                
                // 缩略图sdk会自动下载
                NSLog(@"缩略图的remote路径 -- %@"     ,body.thumbnailRemotePath);
                NSLog(@"缩略图的local路径 -- %@"      ,body.thumbnailLocalPath);
                NSLog(@"缩略图的secret -- %@"        ,body.thumbnailSecretKey);
                NSLog(@"缩略图的下载状态 -- %lu"      ,body.thumbnailDownloadStatus);
            }
                break;
            case EMMessageBodyTypeFile:
            {
                EMFileMessageBody *body = (EMFileMessageBody *)msgBody;
                NSLog(@"文件remote路径 -- %@"      ,body.remotePath);
                NSLog(@"文件local路径 -- %@"       ,body.localPath); // 需要使用sdk提供的下载方法后才会存在
                NSLog(@"文件的secret -- %@"        ,body.secretKey);
                NSLog(@"文件文件大小 -- %lld"       ,body.fileLength);
                NSLog(@"文件文件的下载状态 -- %lu"   ,body.downloadStatus);
            }
                break;
                
            default:
                break;
        }
        
        // 刷新界面
        [self addMessageToDataSource:message
                            progress:nil];
        
    }
}


@end
