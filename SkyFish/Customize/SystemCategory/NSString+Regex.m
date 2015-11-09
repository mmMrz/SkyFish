//
//  NSString+Regex.m
//  SmartPay
//
//  Created by Zhang on 14-8-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)

- (PasswordStrengthLevel)regexWithLoginPasswordRule
{
    PasswordStrengthLevel result = PasswordStrengthLevelLow;
    
    NSString *midRegex = @"^(?![0-9]*$)(?![a-zA-Z]*$)[a-zA-Z0-9]{6,16}$";
    NSString *highRegex = @"^(?![0-9]*$)(?![a-zA-Z]*$)(?![\\W]*$)[a-zA-Z0-9\\W]{6,16}$";
    
    NSPredicate *midPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",midRegex];
    BOOL isMidMatch = [midPred evaluateWithObject:self];
    
    NSPredicate *highPred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",highRegex];
    BOOL isHighMatch = [highPred evaluateWithObject:self];
    
    
    if (isMidMatch) {
        result = PasswordStrengthLevelMid;
    }else{
        if (isHighMatch) {
            result = PasswordStrengthLevelHigh;
        }else{
            result = PasswordStrengthLevelLow;
        }
    }
    
    return result;
}

- (BOOL)isMobileNumber
{
    NSString *regex = @"^1[0-9]{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isIDCardNumber
{
    NSString *regex = @"(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)";
//    if (self.length==15) {
//        regex = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
//    }else{
//        regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{4}$";
//    }
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isNumber
{
    NSString *regex = @"^[0-9]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (BOOL)isAmout
{
    NSString *regex = @"^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

- (NSString *)trimSpace
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    trimmedString = [trimmedString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return trimmedString;
}

//格式化字符串为金融表示法字符串   如：1234.54  变为： 1,234.56
- (NSString *)FormatDecimalCurrency
{
    NSString *str1 = [self FormatStrFormDecimalCurrency];
    
    NSNumberFormatter *numFormat = [[NSNumberFormatter alloc]init];
    [numFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
    NSNumber *num = [NSNumber numberWithDouble:[str1 doubleValue]];
    NSString *numstr = [numFormat stringFromNumber:num];
    
    return [numstr substringFromIndex:1];  //去掉货币符号
}

//去掉金额字符串中的逗号
- (NSString *)FormatStrFormDecimalCurrency
{
    NSMutableString *str = [NSMutableString stringWithString:self];
    [str replaceOccurrencesOfString:@"," withString:@"" options:NSLiteralSearch range:NSMakeRange(0, str.length)];
    return str;
}


@end
