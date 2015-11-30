//
//  FishLocationDetailViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/9.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationDetailViewController.h"

@interface FishLocationDetailViewController (){
    NSDictionary *fishLocationInfo;
    
    __weak IBOutlet UIScrollView *pictureScroll;
    __weak IBOutlet UIView *gradeView;
    __weak IBOutlet UILabel *gradeLbl;
    __weak IBOutlet UIButton *favoriteBtn;
    __weak IBOutlet UIView *typeView;
    __weak IBOutlet UILabel *locationLbl;
    __weak IBOutlet UIView *upOwnerView;
    __weak IBOutlet UILabel *commentCountLbl;
    __weak IBOutlet UILabel *personCostLbl;
    __weak IBOutlet UILabel *waterDeepLbl;
    __weak IBOutlet UILabel *areaLbl;
    __weak IBOutlet UILabel *otakLbl;
    __weak IBOutlet UILabel *phoneLbl;
    __weak IBOutlet UILabel *fishTypeLbl;
    __weak IBOutlet UILabel *descripeLbl;
    __weak IBOutlet UIPageControl *pictureScrollPageControl;
    
    __weak IBOutlet NSLayoutConstraint *constraintTest;
    
    
}

@end

@implementation FishLocationDetailViewController

@synthesize fishLocationInfo = _fishLocationInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:_fishLocationInfo[@"name"]];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedBackButtonWithTarget:self andSelector:@selector(navBack)]];
    [self loadData];
    
}

- (void)navBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)favorite:(UIButton *)sender {
}

- (IBAction)navigation:(UIButton *)sender {
}

- (void)loadData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_fishLocationInfo[@"id"] forKey:@"id"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",PLACE_GETITEM] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showError:responseDic[@"info"]];
        }
        NSLog(@"%@",responseDic);
        fishLocationInfo = responseDic[@"data"];
        [self setupView];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)setupView
{
//    UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, pictureScroll.width, pictureScroll.height)];
//    UIImage *defaultImage = [UIImage imageNamed:@"testJPG"];
//    [picture setImage:defaultImage];
//    [pictureScroll addSubview:picture];
    
    
    //初始化ScrollView里的图片
    for (int i=0;i<[fishLocationInfo[@"picture"] count];i++) {
        NSString *pictureUrl = fishLocationInfo[@"picture"][i];
        UIImageView *picture = [[UIImageView alloc] initWithFrame:CGRectMake(i*pictureScroll.width, 0, pictureScroll.width, pictureScroll.height)];
        NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)pictureUrl, nil, nil, kCFStringEncodingUTF8));
        UIImage *defaultImage = [UIImage imageNamed:@"testJPG"];
        [picture sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:defaultImage completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){}];
        [pictureScroll addSubview:picture];
    }
    [pictureScroll setContentSize:CGSizeMake([fishLocationInfo[@"picture"] count]*pictureScroll.width, pictureScroll.height)];
    CGPoint pictureScrollPageControlCenter = pictureScrollPageControl.center;
    [pictureScrollPageControl setNumberOfPages:[fishLocationInfo[@"picture"] count]];
    [pictureScrollPageControl setCenter:pictureScrollPageControlCenter];
    
    [gradeLbl setText:[NSString stringWithFormat:@"%0.1f",[fishLocationInfo[@"score"] floatValue]]];
    [gradeView setWidth:75*[fishLocationInfo[@"score"] floatValue]/5];
    
    [locationLbl setText:fishLocationInfo[@"address"]];
    
    [commentCountLbl setText:[NSString stringWithFormat:@"%@",fishLocationInfo[@"evaluateCount"]]];
    
    [personCostLbl setText:[NSString stringWithFormat:@"人均消费:%@元",fishLocationInfo[@"cost"]]];
    [waterDeepLbl setText:[NSString stringWithFormat:@"水深%@",fishLocationInfo[@"deep"]]];
    [areaLbl setText:[NSString stringWithFormat:@"面积%@",fishLocationInfo[@"area"]]];
    [otakLbl setText:@"可否打窝未知"];
    [phoneLbl setText:fishLocationInfo[@"tel"]!=[NSNull null]?fishLocationInfo[@"tel"]:@"未知"];
    
    [fishTypeLbl setText:fishLocationInfo[@"fishType"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toFishLocationComment"]) {
        [segue.destinationViewController setValue:_fishLocationInfo forKey:@"fishLocationInfo"];
    }
}


@end
