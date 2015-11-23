//
//  WordImageView.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WordImageView : UIView{
    NSString *_word;
}

- (id)initWithFrame:(CGRect)frame andWord:(NSString*)word;

@end
