//
//  MYCustomMessageCell.h
//  MYMain
//
//  Created by admin on 16/8/9.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCustomMessageCell : UITableViewCell

+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)messageModel;

@end
