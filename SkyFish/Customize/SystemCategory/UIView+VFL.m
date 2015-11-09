//
//  UIView+VFL.m
//  （1）
//
//  Created by liushuang on 15-1-26.
//  Copyright (c) 2015年 YODO. All rights reserved.
//

#import "UIView+VFL.h"

@implementation UIView (VFL)
-(void)addConstraintWithviews:(NSDictionary *)views fomat:(id)vfl1, ...
{
    NSArray *values = [views allValues];
    for (UIView *view in values) {
       
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    id  vflStr;
    va_list list;
    
    if(vfl1)
    {
        //取得第一个参数的值
        [self addConstraintWithFomat:vfl1 views:views];
        
        va_start(list, vfl1);
        while ((vflStr= va_arg(list, id)))
        {//从第2个参数开始，依此取得所有参数的值
            
            [self  addConstraintWithFomat:vflStr views:views];
            
        }
        va_end(list);
    }


}

-(void)addConstraintWithviews:(NSDictionary *)views metrics:(NSDictionary *)metrics fomat:(id)vfl1, ...
{
    NSArray *values = [views allValues];
    for (UIView *view in values) {
        
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    id  vflStr;
    va_list list;
    
    if(vfl1)
    {
        //取得第一个参数的值
        [self addConstraintWithFomat:vfl1 metrics:metrics views:views];
        
        va_start(list, vfl1);
        while ((vflStr= va_arg(list, id)))
        {//从第2个参数开始，依此取得所有参数的值
            
            [self  addConstraintWithFomat:vflStr metrics:metrics views:views];
            
        }
        va_end(list);
    }
    
    
}

-(void)addConstraintWithviews:(NSDictionary *)views options:(NSLayoutFormatOptions)options metrics:(NSDictionary *)metrics fomat:(id)vfl1, ...
{
    NSArray *values = [views allValues];
    for (UIView *view in values) {
        
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    }
    
    id  vflStr;
    va_list list;
    
    if(vfl1)
    {
        //取得第一个参数的值
        [self addConstraintWithFomat:vfl1 options:options  metrics:metrics views:views];
        
        va_start(list, vfl1);
        while ((vflStr= va_arg(list, id)))
        {//从第2个参数开始，依此取得所有参数的值
            
           [self addConstraintWithFomat:vfl1 options:options  metrics:metrics views:views];
            
        }
        va_end(list);
    }
    
    
}

-(void)addConstraintWithFomat:(NSString *)Vfl views:(NSDictionary *)views
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:Vfl options:0 metrics:nil views:views]];
    
}
-(void)addConstraintWithFomat:(NSString *)Vfl metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
 [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:Vfl options:0 metrics:metrics views:views]];
}

-(void)addConstraintWithFomat:(NSString *)Vfl options:(NSLayoutFormatOptions )options metrics:(NSDictionary *)metrics views:(NSDictionary *)views
{
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:Vfl options:options metrics:metrics views:views]];
}


@end
