//
//  UIImage+Size.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/12.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Size)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;

@end
