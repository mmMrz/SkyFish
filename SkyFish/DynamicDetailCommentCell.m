//
//  DynamicDetailCommentCell.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/30.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "DynamicDetailCommentCell.h"

@implementation DynamicDetailCommentCell

- (void)setupViewWithCommentInfo:(NSDictionary *)commentInfo
{
    uid = commentInfo[@"uid"];
    [name_lbl setText:commentInfo[@"authorName"]];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[commentInfo[@"time"] longLongValue]];
    [time_lbl setText:[date toDisplyString]];
    [content_lbl setText:commentInfo[@"content"]];
    
    NSString *headUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)commentInfo[@"authorAvatar"], nil, nil, kCFStringEncodingUTF8));
    UIImage *defaultHead = [UIImage imageNamed:@"未登录头像"];
    [head_img sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:defaultHead completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
    }];
}

- (float)cellHeightWithCommentInfo:(NSDictionary *)commentInfo
{
    [content_lbl setText:commentInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [content_lbl sizeThatFits:textMaxSize];
    if ([commentInfo[@"content"] isEqualToString:@""]||commentInfo[@"content"]==nil) {
        textSize.height=0;
    }
    NSLog(@"返回高度%f",content_lbl.origin.y+textSize.height+8);
    return content_lbl.origin.y+textSize.height+8;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)toUserProfile:(UIButton *)sender {
    [_delegate toUserProfileWithUserId:uid];
}

@end
