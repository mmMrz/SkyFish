//
//  MyWeiboCell.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "MyWeiboCell.h"
#import "WordImageView.h"

@implementation MyWeiboCell

- (void)setupViewWithDynamicInfo:(NSDictionary *)dynamicInfo
{
    //如果有图就加载图片，没有就画一个
    NSArray *images = dynamicInfo[@"images"];
    if ([images isKindOfClass:[NSNull null].class]) {
        images = nil;
    }
    if ([images count]>0) {
        NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)dynamicInfo[@"images"][0], nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"testJPG"];
        [self.headView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        }];
    }else{
        NSString *word = dynamicInfo[@"content"];
        if (![word isEqualToString:@""]) {
            word = [dynamicInfo[@"content"] substringToIndex:1];
        }
        WordImageView *wiv = [[WordImageView alloc] initWithFrame:_headView.frame andWord:word];
        [self.contentView addSubview:wiv];
    }
    
    [_contentLbl setText:dynamicInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [_contentLbl sizeThatFits:textMaxSize];
    if ([dynamicInfo[@"content"] isEqualToString:@""]||dynamicInfo[@"content"]==nil) {
        textSize.height=0;
    }
    CGRect textFrame = self.contentLbl.frame;
    textFrame.size.height = textSize.height;
    [_contentLbl setFrame:textFrame];
    
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:[dynamicInfo[@"time"] longLongValue]];
    [_locationAndDateLbl setText:[[NSString stringWithFormat:@"%@    %@",dynamicInfo[@"address"],[date toDisplyString]] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    [_commentCountLbl setText:[dynamicInfo[@"commentCount"] stringValue]];
}

//- (float)cellHeightWithDynamicInfo:(NSDictionary *)dynamicInfo
//{
//    [self.content_lbl setText:dynamicInfo[@"content"]];
//    //设置内容的行高上限
//    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
//    //计算标题实际frame大小，并将label的frame变成实际大小
//    CGSize textSize = [_content_lbl sizeThatFits:textMaxSize];
//    if ([dynamicInfo[@"content"] isEqualToString:@""]||dynamicInfo[@"content"]==nil) {
//        textSize.height=0;
//    }
//    
//    //加载帖子图片
//    NSArray *images = dynamicInfo[@"images"];
//    float imageWidth = (SCREEN_WIDTH-16-6)/3;
//    
//    return _content_lbl.origin.y+textSize.height+2+ceil(images.count/3.0)*(imageWidth+2)+2+_bottom_view.height;
//}

@end
