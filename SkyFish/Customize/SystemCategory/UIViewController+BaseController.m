//
//  UIViewController+BaseController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "UIViewController+BaseController.h"

@implementation UIViewController (BaseController)

- (ViewController*)baseController
{
    id viewController = self;
    while (![viewController isKindOfClass:[ViewController class]]) {
        viewController = [viewController parentViewController];
        if (viewController==nil) {
            break;
        }
    }
    return viewController;
}

@end
