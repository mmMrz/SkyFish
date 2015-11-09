//
//  SNServicesViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/21.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentView.h"

@interface SNServicesViewController : UIViewController<SegmentViewDelegate,UIScrollViewDelegate>{
    
    __weak IBOutlet UIScrollView *mainScroll;
    
    UIButton *addBtn;
}

@property (nonatomic, strong) id<SegmentViewDelegate> delegate;

@end
