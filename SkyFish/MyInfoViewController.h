//
//  MyInfoViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInfoViewController : UIViewController{
    
    __weak IBOutlet UIImageView *headView;
    __weak IBOutlet UILabel *nameLbl;
    __weak IBOutlet UILabel *signLbl;
    __weak IBOutlet UILabel *weiboCount;
    __weak IBOutlet UILabel *attentionCount;
    __weak IBOutlet UILabel *fansCount;
    __weak IBOutlet UILabel *versionLbl;
    
}

@end
