//
//  FishLocationViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/20.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationViewController.h"
#import "FishLocationCell.h"
#import "FishLocationAnnotation.h"

@implementation FishLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    fishLocationAry = [[NSMutableArray alloc] initWithCapacity:20];
    
    [self.navigationController loadTheme];
    [self setTitle:@"热闹"];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedLeftMenuButtonWithTarget:self andSelector:@selector(showLeftMenu:)]];
    
    UIButton *addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, SCREEN_HEIGHT-NAV_HEIGHT-90, 60, 60)];
    [addBtn setBackgroundColor:[UIColor orangeColor]];
    addBtn.layer.cornerRadius = 30;
    addBtn.layer.masksToBounds = YES;
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:50.0]];
    [addBtn setContentEdgeInsets:UIEdgeInsetsMake( -5, 0, 5, 0)];
    [addBtn addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: addBtn];
    
    [self loadData];
    
    
    [self mapInit];
}

- (void)setupPointAnnotation
{
    NSMutableArray *annotations = [[NSMutableArray alloc] initWithCapacity:fishLocationAry.count];
    for (NSDictionary *fishLocationInfo in fishLocationAry) {
        CLLocationDegrees lat = [fishLocationInfo[@"lat"] doubleValue];
        CLLocationDegrees lon = [fishLocationInfo[@"lng"] doubleValue];
        FishLocationAnnotation *pointAnnotation = [[FishLocationAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(lat, lon);
        pointAnnotation.costType = fishLocationInfo[@"costType"];
        [annotations addObject:pointAnnotation];
    }
    [_mapView addAnnotations:annotations];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAAnnotationView class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView*annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        if ([[(FishLocationAnnotation*)annotation costType] integerValue]==0) {
            annotationView.image = [UIImage imageNamed:@"免费钓点"];
        }else{
            annotationView.image = [UIImage imageNamed:@"收费钓点"];
        }
        [annotationView setCenterOffset:CGPointMake(0, -16)];
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

- (void)loadData
{
    static NSString *lastUpdateTime = @"";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:lastUpdateTime forKey:@"time"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",PLACE_GETPLACE] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showError:responseDic[@"info"]];
        }
        NSLog(@"%@",responseDic);
        [fishLocationAry addObjectsFromArray:responseDic[@"data"]];
        [_tableView reloadData];
        [self setupPointAnnotation];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)showLeftMenu:(id)sender
{
    NSLog(@"显示左侧菜单");
    [self.baseController showHideLeftMenu];
}

- (void)changeView:(UIButton*)sender
{
    if (sender.tag==0) {
        [mainView bringSubviewToFront:_tableView];
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            [_tableView setFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        } completion:^(BOOL finished) {}];
        sender.tag=1;
    }else{
        [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [_tableView setFrame:CGRectMake(0, -self.view.height, self.view.width, self.view.height)];
        } completion:^(BOOL finished) {}];
        sender.tag=0;
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)mapInit
{
    [[MAMapServices sharedServices] setApiKey:@"ab28bcb36f40100dba5b408e64e0521f"];
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [_mapView setDelegate:self];
    [mainView addSubview:_mapView];
    _mapView.showsUserLocation = YES;
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES];
    
    _mapView.distanceFilter = kCLLocationAccuracyNearestTenMeters;
    _mapView.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
        [self updateUserLocationToServers:userLocation.coordinate];
    }
}

- (void)updateUserLocationToServers:(CLLocationCoordinate2D)coordinate
{
    [GlobalData sharedInstance].lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
    [GlobalData sharedInstance].lng = [NSString stringWithFormat:@"%f",coordinate.longitude];
    if (fabs(coordinate.latitude-oldCoordinate.latitude)>0.00005||fabs(coordinate.longitude-oldCoordinate.longitude)>0.00005) {
        
        NSDate *now = [NSDate date];
        NSTimeInterval timeInterval = [now timeIntervalSinceDate:lastUpdate];
        if (timeInterval > 20||lastUpdate==nil) {
            NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
            [parameters setObject:[NSString stringWithFormat:@"%f",coordinate.latitude] forKey:@"lat"];
            [parameters setObject:[NSString stringWithFormat:@"%f",coordinate.longitude] forKey:@"lng"];
            [parameters setObject:@"重庆社区公司头" forKey:@"location"];
            [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",USER_UPDATEADDR] andParameters:parameters complete:^(NSDictionary *responseDic) {
                if ([responseDic[@"status"] integerValue]==0) {
                    NSLog(@"用户地址更新成功");
                    oldCoordinate = coordinate;
                }else{
                    NSLog(@"用户地址更新出错:%@",responseDic[@"info"]);
                }
            } failed:^(NSError *error) {
                NSLog(@"用户地址更新出错:%@",[error localizedDescription]);
            }];
            lastUpdate = now;
        }else{
//            NSLog(@"时间小于10秒，不更新地址，差距:%f",timeInterval);
        }
    }else{
//        NSLog(@"距离太近，不更新地址，差距:\nold:%f,%f\nnew:%f,%f",oldCoordinate.latitude,oldCoordinate.longitude,coordinate.latitude,coordinate.longitude);
    }
}

#pragma mark - UITableView代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return fishLocationAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FishLocationCellIdentifier = @"FishLocationCell";
    FishLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:FishLocationCellIdentifier];
    [cell setupCellViewWithPlaceInfo:fishLocationAry[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    clickedRow = indexPath.row;
    [self performSegueWithIdentifier:@"toFishLocationDetail" sender:self];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toFishLocationDetail"]) {
        NSLog(@"进入钓点详情");
        [segue.destinationViewController setValue:fishLocationAry[clickedRow] forKey:@"fishLocationInfo"];
    }
}

@end
