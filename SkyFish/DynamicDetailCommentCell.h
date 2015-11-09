//
//  DynamicDetailCommentCell.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/30.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicDetailCommentCell : UITableViewCell{
    __weak IBOutlet UIImageView *head_img;
    __weak IBOutlet UILabel *name_lbl;
    __weak IBOutlet UILabel *time_lbl;
    __weak IBOutlet UILabel *content_lbl;
}

- (void)setupViewWithCommentInfo:(NSDictionary *)commentInfo;
- (float)cellHeightWithCommentInfo:(NSDictionary *)commentInfo;

@end

