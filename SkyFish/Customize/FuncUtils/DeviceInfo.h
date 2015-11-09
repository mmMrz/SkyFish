//
//  DeviceInfo.h
//  SmartPay
//
//  Created by Zhang on 14-12-25.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceInfo : NSObject

@property (nonatomic, strong, readonly) NSString *deviceNo;
@property (nonatomic, strong, readonly) NSString *deviceModel;

@end
