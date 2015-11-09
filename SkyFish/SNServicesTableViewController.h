//
//  SNServicesTableViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ground,
    near,
    friend
}SNSListType;

@interface SNServicesTableViewController : UITableViewController

@property (nonatomic) SNSListType listType;

@end
