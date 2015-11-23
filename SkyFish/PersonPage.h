//
//  PersonPage.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonPage : UIViewController{
    __weak IBOutlet UIImageView *headView;
    __weak IBOutlet UILabel *nameLbl;
    __weak IBOutlet UILabel *weiboCount;
    __weak IBOutlet UILabel *attentionCount;
    __weak IBOutlet UILabel *fansCount;
    __weak IBOutlet UILabel *addressLbl;
    __weak IBOutlet UILabel *fishAgeLbl;
    __weak IBOutlet UILabel *skillLbl;
    __weak IBOutlet UILabel *signLbl;
    __weak IBOutlet UITableView *_tableView;
    
}

@end
