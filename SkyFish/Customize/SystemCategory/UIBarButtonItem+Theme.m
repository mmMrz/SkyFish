//
//  UINavigationController+Theme.m
//  SmartPay
//
//  Created by admin on 14-8-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIBarButtonItem+Theme.h"

@implementation UIBarButtonItem (Theme)

+ (UIBarButtonItem *)themedHiddenButtonWithTarget:(id)target andSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"noPic"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)themedBackButtonWithTarget:(id)target andSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"返回箭头"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 20, 20)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)themedCancelButtonWithTarget:(id)target andSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [button setFrame:CGRectMake(0, 0, 60, 40)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)themedAddButtonWithTarget:(id)target andSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"btn_pd_add"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 30,30)];//buttonImage.size.width, buttonImage.size.height)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)themedBarButtonWithTarget:(id)target andSelector:(SEL)selector andButtonTitle:(NSString*)theTitle {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(0, 0, 80.0f, 32.0f)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [button setTitle:theTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] forState:UIControlStateDisabled];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)themedBarButtonWithCustomView:(UIView*)theCustomView {
    return [[UIBarButtonItem alloc] initWithCustomView:theCustomView];
}

+ (UIBarButtonItem *)themedSearchButtonWithTarget:(id)target andSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"drawer_search"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)themedMoreButtonWithTarget:(id)target andSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"my_menu"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)themedLeftMenuButtonWithTarget:(id)target andSelector:(SEL)selector {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImage = [UIImage imageNamed:@"按钮_左侧菜单"];
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0, 0, 20, 20)];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
