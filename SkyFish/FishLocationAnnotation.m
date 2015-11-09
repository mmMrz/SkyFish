//
//  CSPointAnnotation.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/6.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationAnnotation.h"

@implementation FishLocationAnnotation

@synthesize costType;

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[FishLocationCallOut alloc] initWithFrame:CGRectMake(0, 0, 235, 85)];
            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        
        self.calloutView.preview.image = [UIImage imageNamed:@"testJPG"];
//        self.calloutView.title = self.annotation.title;
//        self.calloutView.subtitle = self.annotation.subtitle;
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

@end
