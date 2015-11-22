//
//  UserInfo.h
//  SmartPay
//
//  Created by admin on 14-8-18.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject<NSCoding>

- (void)setUserInfoWithDic:(NSDictionary*)theUserInfoDic;

@property (nonatomic, strong) NSString *uid;//用户ID
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) UIImage *avatarImg;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *bg;
@property (nonatomic, strong) UIImage *bgImg;
@property (nonatomic, strong) NSString *skill;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *adress;
@property (nonatomic, strong) NSString *blogCount;
@property (nonatomic, strong) NSString *attentionCount;
@property (nonatomic, strong) NSString *fansCount;
@property (nonatomic, strong) NSString *rongToken;
@property (nonatomic, strong) NSString *token;//登录后返回
@property (nonatomic, strong) NSString *qiniuToken;
@property (nonatomic, strong) NSString *gender;

- (void)synchronize;

@end
