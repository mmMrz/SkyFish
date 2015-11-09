//
//  DynamicDetailSubCommentCell.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/30.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicDetailSubCommentCell : UITableViewCell
{
    __weak IBOutlet UILabel *name_lbl;
    __weak IBOutlet UILabel *content_lbl;
}

- (void)setupViewWithSubCommentInfo:(NSDictionary *)subCommentInfo;
- (float)cellHeightWithSubCommentInfo:(NSDictionary *)subCommentInfo;

@end
