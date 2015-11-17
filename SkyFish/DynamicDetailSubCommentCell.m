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
    CGRect nameLblFrame = name_lbl.frame;
    nameLblFrame.size = nameSize;
    [name_lbl setFrame:nameLblFrame];
    
    [content_lbl setText:subCommentInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-70-nameSize.width,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [content_lbl sizeThatFits:textMaxSize];
    if ([subCommentInfo[@"content"] isEqualToString:@""]||subCommentInfo[@"content"]==nil) {
        textSize.height=0;
    }
    CGRect contentLblFrame = content_lbl.frame;
    contentLblFrame.origin.x = 62+nameSize.width;
    contentLblFrame.size = textSize;
    [content_lbl setFrame:contentLblFrame];
}

- (float)cellHeightWithSubCommentInfo:(NSDictionary *)subCommentInfo;
{
    [content_lbl setText:subCommentInfo[@"content"]];
    //设置内容的行高上限q
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
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
