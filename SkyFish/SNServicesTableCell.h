//
//  SNServicesTableCell.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNServicesTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *head_ImgView;
@property (weak, nonatomic) IBOutlet UILabel *name_lbl;
@property (weak, nonatomic) IBOutlet UILabel *time_lbl;
@property (weak, nonatomic) IBOutlet UILabel *content_lbl;
@property (weak, nonatomic) IBOutlet UILabel *address_lbl;
@property (weak, nonatomic) IBOutlet UILabel *praiseCount_lbl;
@property (weak, nonatomic) IBOutlet UILabel *commentCount_lbl;
@property (weak, nonatomic) IBOutlet UIView *bottom_view;

- (void)setupViewWithDynamicInfo:(NSDictionary *)dynamicInfo;
- (float)cellHeightWithDynamicInfo:(NSDictionary *)dynamicInfo;

@end
