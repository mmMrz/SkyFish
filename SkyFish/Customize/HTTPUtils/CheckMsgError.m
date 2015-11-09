//
//  CheckMsgError.m
//  SmartPay
//
//  Created by admin on 14-8-18.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "CheckMsgError.h"
#import "ProgressHUD.h"

@implementation CheckMsgError

+(BOOL) showError: (NSDictionary *)resultDic
{
    if(nil == self){
        [ProgressHUD showError:@"未知错误"];
        return NO;
    }
    
    bool bsuccess = [[resultDic objectForKey:@"status"] integerValue]==0;
    
//    NSString *code = [resultDic objectForKey:@"status"];
    
    NSString *msg = [resultDic objectForKey:@"msg"];
    
    if(!bsuccess)
    {
        if ([CheckData isEmpty:msg]) {
            [ProgressHUD dismiss];
        }else{
            if (![ProgressHUD isErrorShowing]){
                [ProgressHUD showError:msg];
            }
        }
        NSLog(@"%@",resultDic);
        return NO;
    }else{
        return YES;
    }
//    else {
//        if ([CheckData isEmpty:msg]) {
//            [ProgressHUD dismiss];
//        }else{
//            [ProgressHUD showSuccess:msg];
//        }
//        return YES;
//    }
}

@end
