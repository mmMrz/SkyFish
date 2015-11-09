//
//  SNServicesViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/21.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "SNServicesViewController.h"
#import "SNServicesTableViewController.h"

@implementation SNServicesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    
    [self.navigationController loadTheme];
    [self.navigationItem addTitleViewWithTitle:@"热闹"];
    [self.navigationItem addLeftBarButtonItem:[UIBarButtonItem themedLeftMenuButtonWithTarget:self andSelector:@selector(showLeftMenu:)]];
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [self.view addSubview:view];
}

- (void)showLeftMenu:(id)sender
{
    NSLog(@"显示左侧菜单");
    [self.baseController showHideLeftMenu];
}

- (void)setupView
{
    addBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-90, SCREEN_HEIGHT-NAV_HEIGHT-90, 60, 60)];
    [addBtn setBackgroundColor:[UIColor orangeColor]];
    addBtn.layer.cornerRadius = 30;
    addBtn.layer.masksToBounds = YES;
    [addBtn setTitle:@"+" forState:UIControlStateNormal];
    [addBtn.titleLabel setFont:[UIFont systemFontOfSize:50.0]];
    [addBtn setContentEdgeInsets:UIEdgeInsetsMake( -5, 0, 5, 0)];
    [addBtn addTarget:self action:@selector(toPublishDynamic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: addBtn];
    
    SegmentView *segmentView = [[SegmentView alloc] initWithBtns:[NSArray arrayWithObjects:@"渔获广场",@"附近渔获",@"朋友圈", nil] andBtnWidth:84];
    [segmentView setDelegate:self];
    [self setDelegate:segmentView];
    [self.view addSubview:segmentView];
    
    [mainScroll setContentSize:CGSizeMake(SCREEN_WIDTH*3, SCREEN_HEIGHT-64)];
    
    SNServicesTableViewController *allDynamic = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SNServicesTableViewController"];
    [allDynamic.view setFrame:CGRectMake(0, segmentView.height, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-segmentView.height)];
    [mainScroll addSubview:allDynamic.view];
    SNServicesTableViewController *nearByDynamic = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SNServicesTableViewController"];
    [nearByDynamic.view setFrame:CGRectMake(SCREEN_WIDTH, segmentView.height, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-segmentView.height)];
    [mainScroll addSubview:nearByDynamic.view];
    SNServicesTableViewController *friendsDynamic = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SNServicesTableViewController"];
    [friendsDynamic.view setFrame:CGRectMake(SCREEN_WIDTH*2, segmentView.height, SCREEN_WIDTH, SCREEN_HEIGHT-NAV_HEIGHT-segmentView.height)];
    [mainScroll addSubview:friendsDynamic.view];
    
    [self addChildViewController:allDynamic];
    [self addChildViewController:nearByDynamic];
    [self addChildViewController:friendsDynamic];
}

- (void)toPublishDynamic:(UIButton *)sender
{
    [self performSegueWithIdentifier:@"toPublishDynamic" sender:self];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double percent = scrollView.contentOffset.x/scrollView.contentSize.width;
    [_delegate moveViewWithPercent:percent];
}

- (void)segmentClickBtnAtIndex:(NSInteger)index
{
    [UIView animateWithDuration:0.25 animations:^{
        [mainScroll setContentOffset:CGPointMake(index*SCREEN_WIDTH, 0)];
    }];
}

@end
