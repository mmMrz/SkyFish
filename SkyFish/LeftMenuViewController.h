//
//  LeftMenuViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/20.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "LLBlurSidebar.h"
#import "ViewControllerDelegate.h"

@interface LeftMenuViewController : LLBlurSidebar

@property (nonatomic, strong) id<ViewControllerDelegate> delegate;

@property (nonatomic, strong) ViewController *baseController;


@end
