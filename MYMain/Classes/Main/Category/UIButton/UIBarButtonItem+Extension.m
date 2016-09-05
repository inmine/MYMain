//
//  UIBarButtonItem+Extension.m
//  MY微博
//
//  Created by mac on 15/12/22.
//  Copyright (c) 2015年 Mr.Ying. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action Image:(NSString *)image highlight:(NSString *)highlight{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];

}

@end
