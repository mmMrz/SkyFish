
//
//  Theme.m
//  CQSQ
//
//  Created by 张燕枭 on 15-5-15.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "UINavigationBar+Theme.h"

@implementation UINavigationBar(Theme)

- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIImage *img = [UIImage imageNamed: @"home_logo"];
    CGPoint point = {0,0};
    [img drawAtPoint:point];
    
}

@end
