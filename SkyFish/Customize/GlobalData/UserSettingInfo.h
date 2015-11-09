//
//  UserSettingInfo.h
//  SmartPay
//
//  Created by Zhang on 14-9-18.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSettingInfo : NSObject

@property (nonatomic, strong) NSString *customerNo;//customerNo
@property (nonatomic, strong) NSString *fingerPassword;
@property (nonatomic, strong) NSNumber *retryCount;

- (NSString *)description;
- (void)synchronize;

@end
