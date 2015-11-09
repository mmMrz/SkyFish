//
//  SegmentView.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/21.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "SegmentView.h"

@implementation SegmentView

- (SegmentView*)initWithBtns:(NSArray *)btns andBtnWidth:(float)theBtnWidth
{
    self = [super init];
    if (self) {
        btnWidth = theBtnWidth;
        btnCount = btns.count;
        [self setBackgroundColor:[UIColor colorWithRed:0/255.0 green:188.0/255.0 blue:212.0/255.0 alpha:1]];
        [self setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 36)];
        UIView *orbitLine = [[UIView alloc] initWithFrame:CGRectMake(0, 34, SCREEN_WIDTH, 2)];
        [orbitLine setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:175.0/255.0 blue:197.0/255.0 alpha:1]];
        [self addSubview:orbitLine];
        slideLine = [[UIView alloc] initWithFrame:CGRectMake(0, 34, theBtnWidth, 2)];
        [slideLine setBackgroundColor:[UIColor colorWithRed:253.0/255.0 green:167.0/255.0 blue:109.0/255.0 alpha:1]];
        [self addSubview:slideLine];
        for (int i=0; i<btns.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(i*theBtnWidth, 0, theBtnWidth, 36)];
            [btn.titleLabel setTextColor:[UIColor whiteColor]];
            [btn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
            [btn setTitle:btns[i] forState:UIControlStateNormal];
            [btn setTag:i];
            [btn addTarget:self action:@selector(clickBtnAtIndex:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
    return self;
}

- (void)moveViewWithPercent:(double)percent
{
    [slideLine setFrame:CGRectMake(btnWidth*btnCount*percent, slideLine.origin.y, slideLine.width, slideLine.height)];
}

- (void)clickBtnAtIndex:(UIButton*)sender
{
    NSInteger index = sender.tag;
    [UIView animateWithDuration:0.25 animations:^{
        [slideLine setFrame:CGRectMake(btnWidth*index, slideLine.origin.y, slideLine.width, slideLine.height)];
    }];
    [_delegate segmentClickBtnAtIndex:index];
}

@end
