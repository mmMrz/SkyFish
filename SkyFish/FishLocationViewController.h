//
//  FishLocationViewController.h
//  SkyFish
//
//  Created by 张燕枭 on 15/10/20.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

@interface FishLocationViewController : UIViewController<MAMapViewDelegate,UITableViewDataSource,UITableViewDelegate>{
    MAMapView *_mapView;
    __weak IBOutlet UIView *mainView;
    CLLocationCoordinate2D oldCoordinate;
    NSDate *lastUpdate;
    NSMutableArray *fishLocationAry;
    IBOutlet UITableView *_tableView;
    NSInteger clickedRow;
}

@end
