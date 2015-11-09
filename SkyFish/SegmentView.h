//
//  SegmentView.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/21.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SegmentViewDelegate.h"

@interface SegmentView : UIView<SegmentViewDelegate>{
    UIView *slideLine;
    float btnWidth;
    NSInteger btnCount;
}

@property (nonatomic, strong) id<SegmentViewDelegate> delegate;

- (SegmentView*)initWithBtns:(NSArray*)btns andBtnWidth:(float)theBtnWidth;

@end
