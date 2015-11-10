//
//  FishLocationCommentCell.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/9.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationCommentCell.h"

@implementation FishLocationCommentCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupViewWithFishLocationCommentInfo:(NSDictionary *)commentInfo
{
    //清空原始数据
    
    for (id view in [self.contentView subviews]) {
        NSLog(@"%@",view);
        if ([view isKindOfClass:[UIImageView class]]&&[view tag]==1) {
            [view removeFromSuperview];
        }
    }
    
    [self.name_lbl setText:commentInfo[@"authorName"]];
    [self.grade_view setWidth:75*[commentInfo[@"score"] floatValue]/5];
    [self.content_lbl setText:commentInfo[@"content"]];
    [self.commentCount_lbl setText:[NSString stringWithFormat:@"%@",commentInfo[@"commentCount"]]];
    
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)commentInfo[@"authorAvatar"], nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"未登录头像"];
    [self.head_ImgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
    }];
    
    
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [_content_lbl sizeThatFits:textMaxSize];
    if ([commentInfo[@"content"] isEqualToString:@""]||commentInfo[@"content"]==nil) {
        textSize.height=0;
    }
    CGRect textFrame = _content_lbl.frame;
    textFrame.size.height = textSize.height;
    [_content_lbl setFrame:textFrame];
    
    CGRect _bottom_viewFrame = _bottom_view.frame;
    
    //加载帖子图片
    NSArray *images = commentInfo[@"images"];
    if ([images isKindOfClass:[NSNull null].class]) {
        images = nil;
    }
    float imageWidth = (SCREEN_WIDTH-16-6)/3;
    for (int i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8+i*(imageWidth+2), _content_lbl.origin.y+_content_lbl.height+2+(imageWidth+2)*(i/3), imageWidth, imageWidth)];
        [imageView setTag:1];
        NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)images[i], nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"testJPG"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
            
            [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
        }];
        [self.contentView addSubview:imageView];
        _bottom_viewFrame.origin.y = imageView.origin.y+imageView.height+2;
    }
    [_bottom_view setFrame:_bottom_viewFrame];
    
}

- (float)cellHeightWithFishLocationCommentInfo:(NSDictionary *)commentInfo
{
    [self.content_lbl setText:commentInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [_content_lbl sizeThatFits:textMaxSize];
    if ([commentInfo[@"content"] isEqualToString:@""]||commentInfo[@"content"]==nil) {
        textSize.height=0;
    }
    
    //加载帖子图片
    NSArray *images = commentInfo[@"images"];
    if ([images isKindOfClass:[NSNull null].class]) {
        images = nil;
    }
    float imageWidth = (SCREEN_WIDTH-16-6)/3;
    
    return _content_lbl.origin.y+textSize.height+2+ceil(images.count/3.0)*(imageWidth+2)+2+_bottom_view.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
