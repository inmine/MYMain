//
//  UIBarButtonItem+Extension.h
//  MY微博
//
//  Created by mac on 15/12/22.
//  Copyright (c) 2015年 Mr.Ying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action Image:(NSString *)image highlight:(NSString *)highlight;

@end
