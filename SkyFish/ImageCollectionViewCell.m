//
//  ImageCollectionViewCell.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/11.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib
{
}

- (void)prepareForReuse
{
    self.imageView.image = nil;
}

@end
