//
//  UIButton+CSAddtional.m
//  CQSQ
//
//  Created by liushuang on 15-1-28.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import "UIButton+Addtional.h"
#import "CSDefine.h"

@implementation UIButton (Addtional)

+(UIButton*)DockButton:(NSString *)title image:(NSString *)image selected:(NSString *)selectedStr
{
    UIButton *button = [[UIButton alloc] init];
    button.bounds = CGRectMake(0, 0, CSDockW, CSDockH);
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedStr] forState:UIControlStateSelected];
    //    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake((CSDockH-18)/3.875,(CSDockW-19)/2,(CSDockH-18)-(CSDockH-18)/3.875, (CSDockW-19)/2)];
    
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, CSDockW, 12)];
    label.textColor =[UIColor whiteColor];
    label.text = title;
    label.font = [UIFont systemFontOfSize:10];
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    return button;
}

+(UIButton*)drawerViewButton:(NSString *)title image:(NSString *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"drawer_icon_bg"] forState:UIControlStateNormal];
     button.bounds = CGRectMake(0, 0, 70, 60);
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
//    [button setTitle:@"" forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(10, 21, 27, 21)];
    
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 70, 12)];
    label.textColor =[UIColor whiteColor];
    label.text = title;
    label.font = [UIFont systemFontOfSize:11];
    label.textAlignment = NSTextAlignmentCenter;
    [button addSubview:label];
    
    return button;
}

-(void)isSeletedImage
{
    if (self.selected) {
        self.selected = NO;
    }else
    {
        self.selected = YES;
    }
}

@end
