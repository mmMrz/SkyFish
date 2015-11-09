//
//  KeyBoardNotification.h
//  SmartPay
//
//  Created by Zhang on 14-10-11.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyBoardNotification : NSObject{
    UIViewController *_viewController;
}

+ (KeyBoardNotification *)sharedInstance;
- (void)setupWithViewController:(UIViewController*)viewController;

@end
