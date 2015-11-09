//
//  NotificationView.h
//  SmartPay
//
//  Created by Zhang on 14-8-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotificationView : UIView{
    UIImageView *notifiedBG;
    UILabel *notifiedLabel;
    BOOL showing;
    UIView *shouldShowInView;
}

+ (void)showInView:(UIView*)view WithString:(NSString *)notifiedStr;
- (void)showInView:(UIView*)view WithString:(NSString *)notifiedStr;
- (void)showNotificationWithString:(NSString *)notifiedStr autoHidden:(BOOL)autoHidden;
- (void)showNotificationWithString:(NSString*)notifiedStr;
- (void)endNotification;

@end
