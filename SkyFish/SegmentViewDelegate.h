//
//  SegmentViewDelegate.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#ifndef SegmentViewDelegate_h
#define SegmentViewDelegate_h

@protocol SegmentViewDelegate <NSObject>

@optional
- (void)segmentClickBtnAtIndex:(NSInteger)index;
- (void)moveViewWithPercent:(double)percent;

@end

#endif /* SegmentViewDelegate_h */
