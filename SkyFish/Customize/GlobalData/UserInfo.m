//
//  UserInfo.m
//  SmartPay
//
//  Created by admin on 14-8-18.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UserInfo.h"
#import <objc/runtime.h>

@implementation UserInfo


- (id)init
{
    self = [super init];
    if(self)
    {
        self.token = nil;
        self.uid = nil;
    }
    return self;
}

- (void)setUserInfoWithDic:(NSDictionary*)theUserInfoDic
{
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if ([[theUserInfoDic allKeys] containsObject:propertyName]) {
            if ([theUserInfoDic objectForKey:propertyName]!=[NSNull null]) {
                [self setValue:[theUserInfoDic objectForKey:propertyName] forKey:propertyName];
            }
        }
    }
    [self synchronize];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [aCoder encodeObject:[self valueForKey:propertyName] forKey:propertyName];
    }
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName];
    }
    return self;
}

- (NSString *)description
{
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableString *descriptionStr = [[NSMutableString alloc] initWithCapacity:outCount*10];
    NSString *cutLine = @"----------";
    for (int i=0; i<outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [descriptionStr appendString:[NSString stringWithFormat:@"%@:%@%@",propertyName,[self valueForKey:propertyName],cutLine]];
    }
    if ([descriptionStr hasSuffix:cutLine]) {
        [descriptionStr substringToIndex:descriptionStr.length-cutLine.length];
    }
    return descriptionStr;
}

- (void)synchronize
{
    NSMutableDictionary *userInfos = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfos"]];
    if (userInfos==nil) {
        userInfos=[[NSMutableDictionary alloc] initWithCapacity:1];
    }
    [userInfos setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:self.uid];
    [[NSUserDefaults standardUserDefaults] setObject:userInfos forKey:@"userInfos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
