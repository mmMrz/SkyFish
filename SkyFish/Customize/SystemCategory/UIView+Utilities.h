//
//  UIView+Utilities.h
//  SmartPay
//
//  Created by admin on 14-8-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utilities)

- (CGFloat)left;

- (void)setLeft:(CGFloat)x;

- (CGFloat)top;

- (void)setTop:(CGFloat)y;

- (CGFloat)right;

- (void)setRight:(CGFloat)right;

- (CGFloat)bottom;

- (void)setBottom:(CGFloat)bottom;

- (CGFloat)centerX;

- (void)setCenterX:(CGFloat)centerX;

- (CGFloat)centerY;

- (void)setCenterY:(CGFloat)centerY;

- (CGFloat)width;

- (void)setWidth:(CGFloat)width;

- (CGFloat)height;

- (void)setHeight:(CGFloat)height;

- (CGPoint)origin;

- (void)setOrigin:(CGPoint)origin;

- (CGSize)size;

- (void)setSize:(CGSize)size;

- (NSArray *)allSubviews;

- (id)firstResponder;

- (void)showDebug;

- (void)showDebugWithColor:(UIColor *)color;

@end
