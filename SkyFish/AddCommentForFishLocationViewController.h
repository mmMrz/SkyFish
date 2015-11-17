//
//  AddCommentForFishLocationViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/11.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCommentForFishLocationViewController : UIViewController<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSDictionary *fishLocationInfo;

@end
