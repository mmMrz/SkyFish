//
//  UINavigationItem+CorrectOffset.m
//  SmartPay
//
//  Created by admin on 14-8-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UINavigationItem+CorrectOffset.h"

@implementation UINavigationItem (CorrectOffset)

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a spacer on when running lower than iOS 7.0
        UIBarButtonItem *negativeSpacer =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                          target:nil
                                                          action:nil];
        negativeSpacer.width = -5.0f;
        [self setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil]];
//    [self setBackBarButtonItem:leftBarButtonItem];
//    }
//    else {
//        // Just set the UIBarButtonItem as you would normally
//        
//        [self setLeftBarButtonItem:leftBarButtonItem];
//    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
//    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a spacer on when running lower than iOS 7.0
        UIBarButtonItem *negativeSpacer =
            [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                          target:nil
                                                          action:nil];
        negativeSpacer.width = -5.0f;
        [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightBarButtonItem, nil]];
        
//    }
//    else {
//        // Just set the UIBarButtonItem as you would normally
//        [self setRightBarButtonItem:rightBarButtonItem];
//    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem andNegativeSpacerWidth:(float)width {
    //    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
    // Add a spacer on when running lower than iOS 7.0
    UIBarButtonItem *negativeSpacer =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                  target:nil
                                                  action:nil];
    negativeSpacer.width = 0-width;
    [self setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer,rightBarButtonItem, nil]];
    
    //    }
    //    else {
    //        // Just set the UIBarButtonItem as you would normally
    //        [self setRightBarButtonItem:rightBarButtonItem];
    //    }
}

- (void)addTitleViewWithTitle:(NSString*)title
{
    CGRect frame;
    frame = CGRectMake(0, 0, 214, 44);
    UIView *titleView = [[UIView alloc] initWithFrame:frame];
    [titleView setBackgroundColor:[UIColor clearColor]];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleView.bounds];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setFont:[UIFont systemFontOfSize:19.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    [titleLabel setText:title];
    [titleView addSubview:titleLabel];
    [self addTitleView:titleView];
}

- (void)addTitleView:(UIView *)titleView {
    // Just set the UIBarButtonItem as you would normally
    if (titleView==nil) {
        CGRect leftViewbounds = [[self.leftBarButtonItems.lastObject customView] bounds];
        CGRect rightViewbounds = [[self.rightBarButtonItems.lastObject customView] bounds];
        
        CGRect frame;
        CGFloat maxWidth = leftViewbounds.size.width > rightViewbounds.size.width ? leftViewbounds.size.width : rightViewbounds.size.width;
        maxWidth += 20;//leftview 左右都有间隙，左边是5像素，右边是8像素，加2个像素的阀值 5 ＋ 8 ＋ 2
        frame = CGRectMake(0, 0, 320, 44);
        frame.size.width = 320 - maxWidth * 2;
        
        titleView = [[UIView alloc] initWithFrame:frame];
        [titleView setBackgroundColor:[UIColor clearColor]];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width-144)/2, 8, 144, 25)];
        [imageView setImage:[UIImage imageNamed:@"home_logo"]];
        [titleView addSubview:imageView];
    }
    [self setTitleView:titleView];
}

- (void)removeTitleView
{
    [self.titleView removeFromSuperview];
    self.titleView = nil;
}

@end
