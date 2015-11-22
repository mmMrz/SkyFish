//
//  NSObject+JSON.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/19.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "NSObject+JSON.h"

@implementation NSObject (JSON)

- (NSString*)JSONString
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    NSString *jsonString = [[NSString alloc] initWithData:result
                                                 encoding:NSUTF8StringEncoding];
    return jsonString;
}

@end
