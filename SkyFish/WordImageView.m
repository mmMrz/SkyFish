//
//  WordImageView.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "WordImageView.h"

@implementation WordImageView

- (id)initWithFrame:(CGRect)frame andWord:(NSString*)word
{
    WordImageView *instance = [self initWithFrame:frame];
    _word = word;
    [instance setBackgroundColor:[UIColor clearColor]];
    return instance;
}

- (void)drawRect:(CGRect)rect
{
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:@"[a-zA-Z.-]" options:0 error:NULL];
    NSString *result = [regular stringByReplacingMatchesInString:[_word MD5] options:0 range:NSMakeRange(0, [[_word MD5] length]) withTemplate:@""];
    
    
    CGFloat hue = [NSString stringWithFormat:@"0.%@",[result substringWithRange:NSMakeRange(0, 2)]].floatValue;
    CGFloat saturation = [NSString stringWithFormat:@"0.%@",[result substringWithRange:NSMakeRange(2, 2)]].floatValue;
    CGFloat brightness = [NSString stringWithFormat:@"0.%@",[result substringWithRange:NSMakeRange(4, 2)]].floatValue;
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, color.CGColor);//画笔线的颜色
    CGContextSetLineWidth(context, 1.0);//线的宽度
    CGContextAddArc(context, self.width/2, self.height/2, self.width<self.height?self.width:self.height/2-1, 0, 2*M_PI, 0); //添加一个圆
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    
    UIFont  *font = [UIFont systemFontOfSize:28];//设置
    UILabel *wordLbl = [[UILabel alloc] initWithFrame:CGRectMake((self.width-28)/2, (self.height-28)/2, 28, 28)];
    [wordLbl setTextColor:color];
    [wordLbl setTextAlignment:NSTextAlignmentCenter];
    [wordLbl setFont:font];
    [wordLbl setText:_word];
    [self addSubview:wordLbl];
    
    
}

@end
