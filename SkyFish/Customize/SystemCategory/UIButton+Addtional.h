//
//  UIButton+CSAddtional.h
//  CQSQ
//
//  Created by liushuang on 15-1-28.
//  Copyright (c) 2015年 PayEgis Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Addtional)

+(UIButton*)drawerViewButton:(NSString *)title image:(NSString *)image;
+(UIButton*)DockButton:(NSString *)title image:(NSString *)image selected:(NSString *)selectedStr;
-(void)isSeletedImage;
@end
