//
//  UINavigationController+Theme.h
//  SmartPay
//
//  Created by admin on 14-8-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Theme)

+ (UIBarButtonItem *)themedHiddenButtonWithTarget:(id)target andSelector:(SEL)selector;

+ (UIBarButtonItem *)themedBackButtonWithTarget:(id)target andSelector:(SEL)selector;

+ (UIBarButtonItem *)themedCancelButtonWithTarget:(id)target andSelector:(SEL)selector;

+ (UIBarButtonItem *)themedAddButtonWithTarget:(id)target andSelector:(SEL)selector;

+ (UIBarButtonItem *)themedBarButtonWithTarget:(id)target andSelector:(SEL)selector andButtonTitle:(NSString*)theTitle;

+ (UIBarButtonItem *)themedBarButtonWithCustomView:(UIView*)theCustomView;

+ (UIBarButtonItem *)themedSearchButtonWithTarget:(id)target andSelector:(SEL)selector;

+ (UIBarButtonItem *)themedMoreButtonWithTarget:(id)target andSelector:(SEL)selector;

+ (UIBarButtonItem *)themedLeftMenuButtonWithTarget:(id)target andSelector:(SEL)selector;

@end
