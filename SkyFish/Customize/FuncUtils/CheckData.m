//
//  CheckData.m
//  SmartPay
//
//  Created by admin on 14-8-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "CheckData.h"

@implementation CheckData

+(BOOL) isEmpty:(NSString *)string
{
    if([[NSNull null]isEqual:string]||nil == string || [@""isEqualToString:string] || [@"null"isEqualToString:string]|| [@"<null>" isEqualToString:string])
        return YES;
    else
        return NO;
}

@end
