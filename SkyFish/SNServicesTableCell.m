//
//  SNServicesTableCell.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "SNServicesTableCell.h"

@implementation SNServicesTableCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setupViewWithDynamicInfo:(NSDictionary *)dynamicInfo
{
    //清空原始数据
    
    for (id view in [self.contentView subviews]) {
        NSLog(@"%@",view);
        if ([view isKindOfClass:[UIImageView class]]&&[view tag]==1) {
            [view removeFromSuperview];
        }
    }
    uid = dynamicInfo[@"authorId"];
    [self.name_lbl setText:dynamicInfo[@"authorName"]];
    [self.content_lbl setText:dynamicInfo[@"content"]];
    [self.address_lbl setText:dynamicInfo[@"address"]];
    [self.praiseCount_lbl setText:[NSString stringWithFormat:@"%@",dynamicInfo[@"praiseCount"]]];
    [self.commentCount_lbl setText:[NSString stringWithFormat:@"%@",dynamicInfo[@"commentCount"]]];
    
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)dynamicInfo[@"authorAvatar"], nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"未登录头像"];
    [self.head_ImgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
    }];
    
    
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [_content_lbl sizeThatFits:textMaxSize];
    if ([dynamicInfo[@"content"] isEqualToString:@""]||dynamicInfo[@"content"]==nil) {
        textSize.height=0;
    }
    for (NSLayoutConstraint *constraint in _content_lbl.constraints) {
        if (constraint.firstItem==_content_lbl&&constraint.firstAttribute==NSLayoutAttributeHeight) {
            constraint.constant = textSize.height;
        }
    }
    
    //加载帖子图片
    NSArray *images = dynamicInfo[@"images"];
    if ([images isKindOfClass:[NSNull null].class]) {
        
        images = nil;
    }
    float imageWidth = (SCREEN_WIDTH-16-6)/3;
    for (int i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, imageWidth, imageWidth)];
        [imageView setTag:1];
        NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)images[i], nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"testJPG"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
            [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
        }];
        [self.contentView addSubview:imageView];
        
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *imageVConstraintAry = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[contentLbl]-%f-[imageView(%f)]",2+(imageWidth+2)*(i/3),imageWidth] options:0 metrics:nil views:@{@"contentLbl":_content_lbl,@"imageView": imageView}];
        NSArray *imageHConstraintAry = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[imageView(%f)]",8+(i%3)*(imageWidth+2),imageWidth] options:0 metrics:nil views:@{@"imageView": imageView}];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            [NSLayoutConstraint activateConstraints:imageVConstraintAry];
            [NSLayoutConstraint activateConstraints:imageHConstraintAry];
        }else{
            [imageView addConstraints:imageVConstraintAry];
            [imageView addConstraints:imageHConstraintAry];
        }
    }
    
}

- (float)cellHeightWithDynamicInfo:(NSDictionary *)dynamicInfo
{
    [self.content_lbl setText:dynamicInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [_content_lbl sizeThatFits:textMaxSize];
    if ([dynamicInfo[@"content"] isEqualToString:@""]||dynamicInfo[@"content"]==nil) {
        textSize.height=0;
    }
    
    //加载帖子图片
    NSArray *images = dynamicInfo[@"images"];
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

- (IBAction)toUserProfile:(UIButton *)sender {
    [_delegate toUserProfileWithUserId:uid];
}

@end
