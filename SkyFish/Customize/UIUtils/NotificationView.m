//
//  NotificationView.m
//  SmartPay
//
//  Created by Zhang on 14-8-19.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "NotificationView.h"

@implementation NotificationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

static NotificationView *instance = nil;

+ (NotificationView *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NotificationView alloc] init];
    });
    
    return instance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        notifiedBG = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"noPic"];
        [notifiedBG setImage:image];
        [notifiedBG setBackgroundColor:[UIColor colorWithRed:.38 green:.47 blue:.57 alpha:1]];
        
        [self addSubview:notifiedBG];
        
        notifiedLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 240, SCREEN_WIDTH-80, 20)];
        [notifiedLabel setAdjustsFontSizeToFitWidth:YES];
        [notifiedLabel setBackgroundColor:[UIColor clearColor]];
        [notifiedLabel setFont:[UIFont systemFontOfSize:14.0]];
        [notifiedLabel setTextColor:[UIColor whiteColor]];
        [notifiedLabel setTextAlignment:NSTextAlignmentCenter];

        [self addSubview:notifiedLabel];
        
        [notifiedLabel setCenter:CGPointMake(SCREEN_WIDTH/2, -15)];
        [notifiedBG setFrame:CGRectMake(0, -30, [UIScreen mainScreen].bounds.size.width, 30)];
    }
    return self;
}


- (void)showNotificationWithString:(NSString *)notifiedStr autoHidden:(BOOL)autoHidden
{
    if (showing) {
        return;
    }
    [self showNotificationWithString:notifiedStr];
    if (autoHidden) {
        [self performSelector:@selector(endNotification) withObject:nil afterDelay:2];
    }
}

- (void)showNotificationWithString:(NSString *)notifiedStr
{
    [shouldShowInView addSubview:self];
    if (showing) {
        return;
    }
    showing = YES;
    [self setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    
    [notifiedLabel setText:notifiedStr];
    [notifiedLabel sizeToFit];
    
    [notifiedLabel setCenter:CGPointMake(SCREEN_WIDTH/2, -15)];
    
    [UIView animateWithDuration:0.3 animations:^{
        [notifiedLabel setCenter:CGPointMake(SCREEN_WIDTH/2, 15)];
        [notifiedBG setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    }];
}

- (void)showInView:(UIView*)view WithString:(NSString *)notifiedStr
{
    shouldShowInView = view;
    [self showNotificationWithString:notifiedStr autoHidden:YES];
}

+ (void)showInView:(UIView*)view WithString:(NSString *)notifiedStr
{
    [[NotificationView sharedInstance] showInView:view WithString:notifiedStr];
}

- (void)endNotification
{
    [UIView animateWithDuration:0.3 animations:^{
        [notifiedLabel setCenter:CGPointMake(SCREEN_WIDTH/2, -15)];
        [notifiedBG setFrame:CGRectMake(0, -30, [UIScreen mainScreen].bounds.size.width, 30)];
    }completion:^(BOOL finished) {
        showing = NO;
    }];
}

@end
