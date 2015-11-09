//
//  UIView+VFL.h
//  （1）
//
//  Created by liushuang on 15-1-26.
//  Copyright (c) 2015年 YODO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (VFL)
-(void)addConstraintWithviews:(NSDictionary *)views fomat:(id)vfl1, ... NS_REQUIRES_NIL_TERMINATION;
-(void)addConstraintWithFomat:(NSString *)Vfl views:(NSDictionary *)views;
-(void)addConstraintWithFomat:(NSString *)Vfl metrics:(NSDictionary *)metrics views:(NSDictionary *)views;
-(void)addConstraintWithviews:(NSDictionary *)views metrics:(NSDictionary *)metrics fomat:(id)vfl1, ...NS_REQUIRES_NIL_TERMINATION;
-(void)addConstraintWithviews:(NSDictionary *)views options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics fomat:(id)vfl1, ...NS_REQUIRES_NIL_TERMINATION;
@end
