//
//  GlobalData.m
//  SmartPay
//
//  Created by admin on 14-8-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

@synthesize currentUserInfo=_currentUserInfo;
@synthesize currentUserSettingInfo=_currentUserSettingInfo;

static GlobalData *instance = nil;

+ (GlobalData *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalData alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        _currentUserInfo = [self lastLoginedUserInfo];
        NSMutableDictionary *globalData = [[NSUserDefaults standardUserDefaults] objectForKey:@"globalData"];
        _userAccount = [globalData objectForKey:@"userAccount"];
        _userPassword = [globalData objectForKey:@"userPassword"];
    }
    return self;
}

- (NSArray*)allHistoryUserInfos
{
    NSArray *allUserInfos = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfos"] allObjects];
    return allUserInfos;
}

- (UserInfo*)userInfoWithUserId:(NSString*)userId
{
    NSData *data = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfos"] objectForKey:userId];
    UserInfo *theUserInfo = nil;
    if (data) {
        theUserInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return theUserInfo;
}

- (UserInfo*)lastLoginedUserInfo
{
    UserInfo *theUserInfo = [self userInfoWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"lastLoginedUserId"]];
    return theUserInfo;
}

- (void)setCurrentUserInfo:(UserInfo *)currentUserInfo
{
    NSMutableDictionary *userInfos = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfos"]];
    if (userInfos==nil) {
        userInfos=[[NSMutableDictionary alloc] initWithCapacity:1];
    }
    [userInfos setObject:[NSKeyedArchiver archivedDataWithRootObject:currentUserInfo] forKey:currentUserInfo.uid];
    [[NSUserDefaults standardUserDefaults] setObject:userInfos forKey:@"userInfos"];
    [[NSUserDefaults standardUserDefaults] setObject:currentUserInfo.uid forKey:@"lastLoginedUserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    _currentUserInfo = currentUserInfo;
}

- (UserInfo *)currentUserInfo
{
    if (_currentUserInfo==nil) {
        _currentUserInfo = [[UserInfo alloc] init];
    }
    return _currentUserInfo;
}

- (UserSettingInfo *)currentUserSettingInfo
{
    if (![_currentUserSettingInfo.customerNo isEqualToString:_currentUserInfo.uid]) {
        _currentUserSettingInfo = nil;
        NSData *currentUserSettingInfoData = [[[NSUserDefaults standardUserDefaults] objectForKey:@"userSettingInfos"] objectForKey:_currentUserInfo.uid];
        
        if (currentUserSettingInfoData) {
            _currentUserSettingInfo = [NSKeyedUnarchiver unarchiveObjectWithData:currentUserSettingInfoData];
        }
        
        if (_currentUserSettingInfo==nil) {
            _currentUserSettingInfo = [[UserSettingInfo alloc] init];
            [_currentUserSettingInfo setCustomerNo:_currentUserInfo.uid];
        }
    }
    return _currentUserSettingInfo;
}

- (void)synchronize
{
    NSMutableDictionary *globalData = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"globalData"]];
    if (globalData==nil) {
        globalData=[[NSMutableDictionary alloc] initWithCapacity:1];
    }
    [globalData setObject:_userAccount forKey:@"userAccount"];
    [globalData setObject:_userPassword forKey:@"userPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:globalData forKey:@"globalData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
