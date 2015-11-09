//
//  UserSettingInfo.m
//  SmartPay
//
//  Created by Zhang on 14-9-18.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UserSettingInfo.h"
#import <objc/runtime.h>

@implementation UserSettingInfo

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
    NSString *cutLine = @",";
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
    NSMutableDictionary *userSettingInfos = [[NSMutableDictionary alloc] initWithDictionary:[[NSUserDefaults standardUserDefaults] objectForKey:@"userSettingInfos"]];
    if (userSettingInfos==nil) {
        userSettingInfos=[[NSMutableDictionary alloc] initWithCapacity:1];
    }
    [userSettingInfos setObject:[NSKeyedArchiver archivedDataWithRootObject:self] forKey:_customerNo];
    [[NSUserDefaults standardUserDefaults] setObject:userSettingInfos forKey:@"userSettingInfos"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
