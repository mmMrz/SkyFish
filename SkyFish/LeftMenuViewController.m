//
//  LeftMenuViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/20.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "LoginViewController.h"

@interface LeftMenuViewController ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *leftMenuAry;
    __weak IBOutlet UIButton *toLoginBtn;
    
    __weak IBOutlet UIImageView *head_ImgView;
    __weak IBOutlet UILabel *name_lbl;
    __weak IBOutlet UILabel *sign_lbl;
    
    
}

@property (nonatomic, retain) IBOutlet UITableView* menuTableView;

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 列表
//    self.menuTableView = [[UITableView alloc] initWithFrame:self.contentView.bounds];
    [self.menuTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.menuTableView setFrame:self.contentView.bounds];
    [self.contentView addSubview:self.menuTableView];
//    [self.menuTableView removeFromSuperview];
    
    
    leftMenuAry = [[NSArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"钓点",@"name",@"tab钓点-未选中",@"icon", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"热闹",@"name",@"tab热闹-未选中",@"icon", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"消息",@"name",@"tab消息-未选中",@"icon", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"个人",@"name",@"tab个人-未选中",@"icon", nil], nil],[[NSArray alloc] initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"设置",@"name",@"tab设置-未选中",@"icon", nil],[NSDictionary dictionaryWithObjectsAndKeys:@"注销",@"name",@"tab注销-未选中",@"icon", nil], nil], nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupView];
}

- (void)setupView
{
    if ([CheckData isEmpty:[GlobalData sharedInstance].currentUserInfo.uid]) {
        [toLoginBtn setHidden:NO];
        [sign_lbl setText:@"未登录，点击登录"];
        return;
    }
    [toLoginBtn setHidden:YES];
    [sign_lbl setText:[GlobalData sharedInstance].currentUserInfo.sign];
    [name_lbl setText:[GlobalData sharedInstance].currentUserInfo.name];
    
    NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)[GlobalData sharedInstance].currentUserInfo.avatar, nil, nil, kCFStringEncodingUTF8));
    UIImage *image = [UIImage imageNamed:@"未登录头像"];
    [head_ImgView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
    }];
}

- (IBAction)toLogin:(UIButton *)sender {
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    LoginViewController *loginVC = [story instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.baseController presentViewController:loginVC animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 0.5;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 0.5)];
        [separatorLine setBackgroundColor:[UIColor lightGrayColor]];
        return separatorLine;
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return leftMenuAry.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [leftMenuAry[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *sidebarMenuCellIdentifier = @"MenuTableCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sidebarMenuCellIdentifier];
    
    [(UIImageView*)[cell.contentView viewWithTag:1] setImage:[UIImage imageNamed:leftMenuAry[indexPath.section][indexPath.row][@"icon"]]];
    [(UILabel*)[cell.contentView viewWithTag:2] setText:leftMenuAry[indexPath.section][indexPath.row][@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [_delegate toViewControllerAtIndex:indexPath.row];
    
    [self showHideSidebar];
    
}

@end
