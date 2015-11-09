//
//  UIView+Utilities.m
//  SmartPay
//
//  Created by admin on 14-8-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(x);
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(y);
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(right - frame.size.width);
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(bottom - frame.size.height);
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(ceilf(centerX), self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, ceilf(centerY));
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (NSArray *)allSubviews {
    NSArray *results = [self subviews];
    for (UIView *subview in [self subviews]) {
        NSArray *subviews = [subview allSubviews];
        if (subviews) {
            results = [results arrayByAddingObjectsFromArray:subviews];
        }
    }
    return results;
}

- (id)firstResponder {
    for (id subview in [self allSubviews]) {
        if ([subview isKindOfClass:[UITextField class]] &&
            [(UITextField *)subview isFirstResponder]) {
            return (UITextField *)subview;
        }
        else if ([subview isKindOfClass:[UITextView class]] &&
                 [(UITextView *)subview isFirstResponder]) {
            return (UITextView *)subview;
        }
    }
    return nil;
}

- (void)showDebug {
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [[UIColor redColor] CGColor];
}

- (void)showDebugWithColor:(UIColor *)color {
    self.layer.borderWidth = 1.0f;
    self.layer.borderColor = [color CGColor];
}



@end
