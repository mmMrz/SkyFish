//
//  PublishDynamicViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/26.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublishDynamicViewController : UIViewController<UITextViewDelegate>{
    __weak IBOutlet UITextView *text_content;
    __weak IBOutlet UICollectionView *imageCollectionView;
}

@end
