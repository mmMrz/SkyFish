//
//  FishLocationCell.h
//  SkyFish
//
//  Created by 张燕枭 on 15/11/5.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FishLocationCell : UITableViewCell{
    __weak IBOutlet UIImageView *previewImageView;
    __weak IBOutlet UILabel *titleLbl;
    __weak IBOutlet UILabel *lcoationLbl;
    __weak IBOutlet UILabel *priceLbl;
    __weak IBOutlet UILabel *distanceLbl;
    __weak IBOutlet UIView *tagView;
    __weak IBOutlet UILabel *gradeLbl;
    __weak IBOutlet UIView *gradeView;
}

- (void)setupCellViewWithPlaceInfo:(NSDictionary *)placeInfo;

@end
