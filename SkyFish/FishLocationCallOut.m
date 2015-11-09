//
//  CSFishLocationCallOut.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/6.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationCallOut.h"

@implementation FishLocationCallOut

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews
{
    // 添加图片，即商户图
    self.preview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 100, 75)];
    
    self.preview.backgroundColor = [UIColor blackColor];
    [self addSubview:self.preview];
    
    // 添加标题，即商户名
    self.titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 120, 20)];
    self.titleLbl.font = [UIFont boldSystemFontOfSize:14];
    self.titleLbl.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLbl];
    
    // 添加副标题，即商户地址
    self.subtitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 30, 120, 20)];
    self.subtitleLbl.font = [UIFont systemFontOfSize:12];
    self.subtitleLbl.textColor = [UIColor lightGrayColor];
    [self addSubview:self.subtitleLbl];
    
    // 添加评分星星
    self.gradeView_base = [[UIView alloc] initWithFrame:CGRectMake(80, 55, 75, 20)];
    for (int i=0; i<5; i++) {
        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(i*15, 2.5, 15, 15)];
        [star setImage:[UIImage imageNamed:@"评价（暗）"]];
        [self.gradeView_base addSubview:star];
    }
    [self addSubview:self.gradeView_base];
    
    self.gradeView = [[UIView alloc] initWithFrame:CGRectMake(80, 55, 0, 20)];
    for (int i=0; i<5; i++) {
        UIImageView *star = [[UIImageView alloc] initWithFrame:CGRectMake(i*15, 2.5, 15, 15)];
        [star setImage:[UIImage imageNamed:@"评价（亮）"]];
        [self.gradeView addSubview:star];
    }
    [self addSubview:self.gradeView];
    
    // 添加评分分数
    self.gradeLbl = [[UILabel alloc] initWithFrame:CGRectMake(160, 55, 40, 20)];
    self.gradeLbl.font = [UIFont systemFontOfSize:12];
    self.gradeLbl.textColor = [UIColor lightGrayColor];
    [self addSubview:self.gradeLbl];
}

- (void)setTitle:(NSString *)title
{
    self.titleLbl.text = title;
}

- (void)setSubtitle:(NSString *)subtitle
{
    self.subtitleLbl.text = subtitle;
}

- (void)setGrade:(NSString *)grade
{
    [self.gradeView setWidth:15*[grade floatValue]/5];
    self.gradeLbl.text = grade;
}

- (void)setImage:(UIImage *)image
{
    self.preview.image = image;
}

#define kArrorHeight        10

- (void)drawRect:(CGRect)rect
{
    
    [self drawInContext:UIGraphicsGetCurrentContext()];
    
    self.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.layer.shadowOpacity = 1.0;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    
}

- (void)drawInContext:(CGContextRef)context
{
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.8].CGColor);
    
    [self getDrawPath:context];
    CGContextFillPath(context);
    
}

- (void)getDrawPath:(CGContextRef)context
{
    CGRect rrect = self.bounds;
    CGFloat radius = 6.0;
    CGFloat minx = CGRectGetMinX(rrect),
    midx = CGRectGetMidX(rrect),
    maxx = CGRectGetMaxX(rrect);
    CGFloat miny = CGRectGetMinY(rrect),
    maxy = CGRectGetMaxY(rrect)-kArrorHeight;
    
    CGContextMoveToPoint(context, midx+kArrorHeight, maxy);
    CGContextAddLineToPoint(context,midx, maxy+kArrorHeight);
    CGContextAddLineToPoint(context,midx-kArrorHeight, maxy);
    
    CGContextAddArcToPoint(context, minx, maxy, minx, miny, radius);
    CGContextAddArcToPoint(context, minx, minx, maxx, miny, radius);
    CGContextAddArcToPoint(context, maxx, miny, maxx, maxx, radius);
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius);
    CGContextClosePath(context);
}

@end
