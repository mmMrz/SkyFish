//
//  NSString+Regex.h
//  SmartPay
//
//  Created by Zhang on 14-8-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum PasswordStrengthLevel {
    PasswordStrengthLevelLow = 1,
    PasswordStrengthLevelMid = 2,
    PasswordStrengthLevelHigh = 3
}PasswordStrengthLevel;

@interface NSString (Regex)

- (PasswordStrengthLevel)regexWithLoginPasswordRule;

- (BOOL)isMobileNumber;

- (BOOL)isIDCardNumber;

- (BOOL)isNumber;

- (BOOL)isAmout;

- (NSString *)trimSpace;

- (NSString *)FormatDecimalCurrency;

- (NSString *)FormatStrFormDecimalCurrency;

@end
