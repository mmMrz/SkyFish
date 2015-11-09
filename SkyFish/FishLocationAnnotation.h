//
//  CSPointAnnotation.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/6.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "FishLocationCallOut.h"

@interface FishLocationAnnotation : MAAnnotationView
/*!
 @brief 标注view中心坐标
 */
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) FishLocationCallOut *calloutView;
@property (nonatomic, copy) NSNumber *costType;

@end
