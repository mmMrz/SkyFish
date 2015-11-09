//
//  ViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/20.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerDelegate.h"

@interface ViewController : UIViewController<ViewControllerDelegate>

+ (ViewController*)sharedInstance;
- (void)showHideLeftMenu;

@end

