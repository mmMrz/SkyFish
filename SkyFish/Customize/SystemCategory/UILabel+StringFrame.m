//
//  UILabel+StringFrame.m
//  LayoutDemo
//
//  Created by linan on 15-1-31.
//  Copyright (c) 2015年 linan. All rights reserved.
//

#import "UILabel+StringFrame.h"

@implementation UILabel (StringFrame)
-(CGSize)getUILabelHigehtAccordingToSize:(CGSize)size{
    NSDictionary *attribute = @{NSFontAttributeName:self.font};
    CGSize rectSize = [self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return rectSize;

}
@end
