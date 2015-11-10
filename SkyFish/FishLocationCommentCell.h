//
//  FishLocationCommentCell.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/9.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FishLocationCommentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *head_ImgView;
@property (weak, nonatomic) IBOutlet UILabel *name_lbl;
@property (weak, nonatomic) IBOutlet UILabel *time_lbl;
@property (weak, nonatomic) IBOutlet UILabel *content_lbl;
@property (weak, nonatomic) IBOutlet UILabel *commentCount_lbl;
@property (weak, nonatomic) IBOutlet UIView *bottom_view;
@property (weak, nonatomic) IBOutlet UIView *grade_view;

- (void)setupViewWithFishLocationCommentInfo:(NSDictionary *)commentInfo;
- (float)cellHeightWithFishLocationCommentInfo:(NSDictionary *)commentInfo;

@end
