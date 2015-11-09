//
//  FishLocationCell.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/5.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationCell.h"
#define GRADEVIEW_WIDTH 75

@implementation FishLocationCell

- (void)setupCellViewWithPlaceInfo:(NSDictionary *)placeInfo
{
    //清空原始数据
    for (id view in [self.contentView subviews]) {
        if ([view isKindOfClass:[UIImageView class]]&&[view tag]==1) {
            [view removeFromSuperview];
        }
    }
    
    [titleLbl setText:placeInfo[@"name"]];
    [lcoationLbl setText:placeInfo[@"briefAddr"]];
    [gradeLbl setText:[NSString stringWithFormat:@"%0.1f",[placeInfo[@"score"] floatValue]]];
    [gradeView setWidth:GRADEVIEW_WIDTH*[placeInfo[@"score"] floatValue]/5];
    [priceLbl setText:[placeInfo[@"cost"] floatValue]==0?@"免费":[NSString stringWithFormat:@"人均¥%@",placeInfo[@"cost"]]];
    
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)placeInfo[@"preview"], nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"testJPG"];
    [previewImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
    }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
