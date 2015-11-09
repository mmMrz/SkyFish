//
//  UIImage+FixOrientation.h
//  CQSQ
//
//  Created by 张燕枭 on 15/8/24.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (FixOrientation)

- (UIImage *)fixOrientation;

- (UIImage *)fixOrientationWithCurrentUIImageOrientation:(UIImageOrientation)currentOrientation;

@end
