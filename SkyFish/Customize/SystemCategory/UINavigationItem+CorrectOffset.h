//
//  UINavigationItem+CorrectOffset.h
//  SmartPay
//
//  Created by admin on 14-8-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationItem (CorrectOffset)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem;
- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem andNegativeSpacerWidth:(float)width;
- (void)addTitleView:(UIView *)titleView;
- (void)addTitleViewWithTitle:(NSString*)title;
- (void)removeTitleView;

@end
