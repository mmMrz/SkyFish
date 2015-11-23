//
//  MyWeiboCell.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWeiboCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headView;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *locationAndDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLbl;

@end
