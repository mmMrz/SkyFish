//
//  CSFishLocationCallOut.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/6.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FishLocationCallOut : UIView

@property (nonatomic, strong) UIImageView *preview;
@property (nonatomic, copy) UILabel *titleLbl;
@property (nonatomic, copy) UILabel *subtitleLbl;
@property (nonatomic, copy) UILabel *gradeLbl;
@property (nonatomic, copy) UIView *gradeView_base;
@property (nonatomic, copy) UIView *gradeView;

- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;
- (void)setGrade:(NSString *)grade;
- (void)setCost:(NSString *)cost;

@end
