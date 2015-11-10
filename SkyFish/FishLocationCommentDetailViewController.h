//
//  FishLocationCommentDetailViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/9.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FishLocationCommentDetailViewController : UIViewController{
    __weak IBOutlet UIImageView *head_ImgView;
    __weak IBOutlet UILabel *name_lbl;
    __weak IBOutlet UILabel *time_lbl;
    __weak IBOutlet UILabel *content_lbl;
    __weak IBOutlet UILabel *commentCount_lbl;
    __weak IBOutlet UIView *tableHeader_view;
    __weak IBOutlet UIView *tableHeaderBottom_view;
    __weak IBOutlet UITableView *_tableView;
    __weak IBOutlet UIView *grade_view;
}

@property (nonatomic, strong) NSDictionary *fishLocationCommentInfo;

@end
