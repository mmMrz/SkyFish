//
//  UINavigationController+Theme.m
//  SmartPay
//
//  Created by admin on 14-8-13.
//  Copyright (c) 2014年 admin. All rights reserved.
//

#import "UINavigationController+Theme.h"

@implementation UINavigationController (Theme)

- (void)loadTheme {

    UINavigationBar *navBar = self.navigationBar;
    
    //修改标题颜色
    NSMutableDictionary *titleTextAttributes = [[navBar titleTextAttributes] mutableCopy];
    if (!titleTextAttributes) {
        titleTextAttributes = [NSMutableDictionary dictionary];
    }
    [titleTextAttributes setValue:[UIFont systemFontOfSize:19.0f]
                           forKey:NSFontAttributeName];
    [titleTextAttributes setValue:[UIColor whiteColor]
                           forKey:NSForegroundColorAttributeName];
    NSShadow *shadow = [[NSShadow alloc] init];
    [shadow setShadowOffset:CGSizeMake(0, 0)];
    [shadow setShadowColor:[UIColor clearColor]];
    [titleTextAttributes setValue:shadow forKey:NSShadowAttributeName];
    [navBar setTitleTextAttributes:titleTextAttributes];
    
    /*
     [navBar setBackgroundImage:[UIImage imageNamed:@"bg_navigator_ios7"]
     forBarMetrics:UIBarMetricsDefault & UIBarMetricsLandscapePhone];
     */
    //        [navBar setBackgroundImage:[UIImage imageNamed:@"bg_navigator_ios7"]
    //                    forBarPosition:UIBarPositionTopAttached
    //                        barMetrics:UIBarMetricsDefault & UIBarMetricsLandscapePhone];
    [navBar setBarTintColor:[UIColor colorWithRed:0/255.0 green:188.0/255.0 blue:212.0/255.0 alpha:1]];
    //        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"home_logo"] forBarMetrics:UIBarMetricsDefault];
    navBar.opaque = YES;
    navBar.translucent = NO;
    
    [navBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[[UIImage alloc] init]];
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    
    id gestureRecognizerTargets = [_targets firstObject];
    id navigationInteractiveTransition = [gestureRecognizerTargets valueForKey:@"_target"];
    
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:navigationInteractiveTransition action:handleTransition];
    [popRecognizer setDelegate:self];
    [gestureView addGestureRecognizer:popRecognizer];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count != 1&& ![[self valueForKey:@"_isTransitioning"] boolValue];
}

@end
