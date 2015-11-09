//
//  DynamicDetailViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/26.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DynamicDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    __weak IBOutlet UIImageView *head_ImgView;
    __weak IBOutlet UILabel *name_lbl;
    __weak IBOutlet UILabel *time_lbl;
    __weak IBOutlet UILabel *content_lbl;
    __weak IBOutlet UILabel *address_lbl;
    __weak IBOutlet UILabel *praiseCount_lbl;
    __weak IBOutlet UILabel *commentCount_lbl;
    __weak IBOutlet UIView *praise_view;
    __weak IBOutlet UIView *tableHeader_view;
    __weak IBOutlet UIView *tableHeaderBottom_view;
    __weak IBOutlet UITableView *_tableView;
}

@property (nonatomic, strong) NSDictionary *dynamicInfo;

@end
