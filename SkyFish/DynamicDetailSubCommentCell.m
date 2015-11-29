//
//  DynamicDetailSubCommentCell.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/30.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "DynamicDetailSubCommentCell.h"

@implementation DynamicDetailSubCommentCell

- (void)setupViewWithSubCommentInfo:(NSDictionary *)subCommentInfo
{
    [name_lbl setText:[NSString stringWithFormat:@"%@:",subCommentInfo[@"authorName"]]];
    //设置内容的行高上限
    CGSize nameMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize nameSize = [name_lbl sizeThatFits:nameMaxSize];
    for (NSLayoutConstraint *constraint in name_lbl.constraints) {
        if (constraint.firstItem==name_lbl&&constraint.firstAttribute==NSLayoutAttributeWidth) {
            constraint.constant = nameSize.width;
        }
    }
    
    [content_lbl setText:subCommentInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-70-nameSize.width,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [content_lbl sizeThatFits:textMaxSize];
    if ([subCommentInfo[@"content"] isEqualToString:@""]||subCommentInfo[@"content"]==nil) {
        textSize.height=0;
    }
    for (NSLayoutConstraint *constraint in content_lbl.constraints) {
        if (constraint.firstItem==content_lbl&&constraint.firstAttribute==NSLayoutAttributeHeight) {
            constraint.constant = textSize.height;
        }
    }
//    CGRect contentLblFrame = content_lbl.frame;
//    contentLblFrame.origin.x = 62+nameSize.width;
//    contentLblFrame.size = textSize;
//    [content_lbl setFrame:contentLblFrame];
}

- (float)cellHeightWithSubCommentInfo:(NSDictionary *)subCommentInfo;
{
    [name_lbl setText:[NSString stringWithFormat:@"%@:",subCommentInfo[@"authorName"]]];
    //设置内容的行高上限
    CGSize nameMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize nameSize = [name_lbl sizeThatFits:nameMaxSize];
    
    [content_lbl setText:subCommentInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-70-nameSize.width,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [content_lbl sizeThatFits:textMaxSize];
    if ([subCommentInfo[@"content"] isEqualToString:@""]||subCommentInfo[@"content"]==nil) {
        textSize.height=0;
    }
    return content_lbl.origin.y+textSize.height+8;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
