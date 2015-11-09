//
//  GlobalData.h
//  SmartPay
//
//  Created by admin on 14-8-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import "UserSettingInfo.h"

@interface GlobalData : NSObject

@property (nonatomic, strong) UserInfo* currentUserInfo;
@property (nonatomic, strong) UserSettingInfo* currentUserSettingInfo;
@property (nonatomic, strong) NSString *userAccount;//用户登录名
@property (nonatomic, strong) NSString *userPassword;//用户登录名

+ (GlobalData *)sharedInstance;
- (void)synchronize;

@end
