//
//  DynamicDetailViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/26.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "DynamicDetailCommentCell.h"
#import "DynamicDetailSubCommentCell.h"

#define TableBottomViewHeight 77

@interface DynamicDetailViewController (){
//    NSDictionary *dynamicInfo;
}

@end

@implementation DynamicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_dynamicInfo[@"id"] forKey:@"id"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",WEIBO_GETITEM] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"info"]];
        }
        _dynamicInfo = responseDic[@"data"];
        [self setupView];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
    
}

- (void)setupView
{
    [name_lbl setText:_dynamicInfo[@"authorName"]];
    [address_lbl setText:_dynamicInfo[@"address"]];
    [praiseCount_lbl setText:[NSString stringWithFormat:@"%@",_dynamicInfo[@"praiseCount"]]];
    [commentCount_lbl setText:[NSString stringWithFormat:@"%@",_dynamicInfo[@"commentCount"]]];
    
    NSString *headUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)_dynamicInfo[@"authorAvatar"], nil, nil, kCFStringEncodingUTF8));
    UIImage *defaultHead = [UIImage imageNamed:@"未登录头像"];
    [head_ImgView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:defaultHead completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
    }];
    //加载帖子内容
    [content_lbl setText:_dynamicInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [content_lbl sizeThatFits:textMaxSize];
    if ([_dynamicInfo[@"content"] isEqualToString:@""]||_dynamicInfo[@"content"]==nil) {
        textSize.height=0;
    }
    for (NSLayoutConstraint *constraint in content_lbl.constraints) {
        if (constraint.firstItem==content_lbl&&constraint.firstAttribute==NSLayoutAttributeHeight) {
            constraint.constant = textSize.height;
        }
    }
    
    CGRect tableHeaderBottomViewFrame = tableHeaderBottom_view.frame;
    
    //加载帖子图片
    NSArray *images = _dynamicInfo[@"images"];
    float imageWidth = (SCREEN_WIDTH-16-6)/3;
    for (int i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, imageWidth, imageWidth)];
        NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)images[i], nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"testJPG"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
            [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
        }];
        [content_lbl.superview addSubview:imageView];
        
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        NSArray *imageVConstraintAry = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[contentLbl]-%f-[imageView(%f)]",2+(imageWidth+2)*(i/3),imageWidth] options:0 metrics:nil views:@{@"contentLbl":content_lbl,@"imageView": imageView}];
        NSArray *imageHConstraintAry = [NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[imageView(%f)]",8+(i%3)*(imageWidth+2),imageWidth] options:0 metrics:nil views:@{@"imageView": imageView}];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            [NSLayoutConstraint activateConstraints:imageVConstraintAry];
            [NSLayoutConstraint activateConstraints:imageHConstraintAry];
        }else{
            [imageView addConstraints:imageVConstraintAry];
            [imageView addConstraints:imageHConstraintAry];
        }
    }
    tableHeaderBottomViewFrame.origin.y = 62+textSize.height+2+ceilf(images.count/3.0)*imageWidth+2;
    
    //加载点赞头像
    NSArray *praiseMember = _dynamicInfo[@"praiseMember"];
    if (praiseMember.count>0) {
        for (int i=0; i<praiseMember.count; i++) {
            NSDictionary *thePraiseMember = praiseMember[i];
            UIImageView *praiseAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(i*33, 3, 30, 30)];
            praiseAvatar.layer.cornerRadius = 15;
            praiseAvatar.layer.masksToBounds = YES;
            NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)thePraiseMember[@"avatar"], nil, nil, kCFStringEncodingUTF8));
            UIImage *image = [UIImage imageNamed:@"未登录头像"];
            [praiseAvatar sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
                [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
            }];
            [praise_view addSubview:praiseAvatar];
        }
    }else{
        [praise_view setHidden:YES];
        tableHeaderBottomViewFrame.size.height=TableBottomViewHeight-praise_view.height;
    }
    [tableHeaderBottom_view setFrame:tableHeaderBottomViewFrame];
    CGRect tableHeaderViewFrame = tableHeader_view.frame;
    tableHeaderViewFrame.size.height=tableHeaderBottomViewFrame.origin.y+tableHeaderBottomViewFrame.size.height;
    [tableHeader_view setFrame:tableHeaderViewFrame];
    [_tableView setTableHeaderView:tableHeader_view];
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_dynamicInfo[@"comment"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dynamicInfo[@"comment"][section][@"child"] count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        DynamicDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        return [cell cellHeightWithCommentInfo:_dynamicInfo[@"comment"][indexPath.section]];
    }else{
        DynamicDetailSubCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCommentCell"];
        return [cell cellHeightWithSubCommentInfo:_dynamicInfo[@"comment"][indexPath.section][@"child"][indexPath.row-1]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dynamicInfo = [_dynamicInfo[@"comment"] objectAtIndex:indexPath.section];
    if (indexPath.row==0) {
        DynamicDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        [cell setupViewWithCommentInfo:dynamicInfo];
        return cell;
    }else{
        DynamicDetailSubCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCommentCell"];
        [cell setupViewWithSubCommentInfo:dynamicInfo[@"child"][indexPath.row-1]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
