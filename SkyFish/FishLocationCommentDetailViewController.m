//
//  FishLocationCommentDetailViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/9.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationCommentDetailViewController.h"
#import "DynamicDetailCommentCell.h"
#import "DynamicDetailSubCommentCell.h"

@interface FishLocationCommentDetailViewController (){
    
}

@end

@implementation FishLocationCommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_fishLocationCommentInfo[@"id"] forKey:@"id"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",PLACE_SCOREDETAIL] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"info"]];
        }
        _fishLocationCommentInfo = responseDic[@"data"];
        [self setupView];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)setupView
{
    [name_lbl setText:_fishLocationCommentInfo[@"authorName"]];
    [grade_view setWidth:75*[_fishLocationCommentInfo[@"score"] floatValue]/5];
    [commentCount_lbl setText:[NSString stringWithFormat:@"%@",_fishLocationCommentInfo[@"commentCount"]]];
    
    NSString *headUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)_fishLocationCommentInfo[@"authorAvatar"], nil, nil, kCFStringEncodingUTF8));
    UIImage *defaultHead = [UIImage imageNamed:@"未登录头像"];
    [head_ImgView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:defaultHead completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
        [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
    }];
    //加载帖子内容
    [content_lbl setText:_fishLocationCommentInfo[@"content"]];
    //设置内容的行高上限
    CGSize textMaxSize = CGSizeMake(SCREEN_WIDTH-16,MAXFLOAT);
    //计算标题实际frame大小，并将label的frame变成实际大小
    CGSize textSize = [content_lbl sizeThatFits:textMaxSize];
    if ([_fishLocationCommentInfo[@"content"] isEqualToString:@""]||_fishLocationCommentInfo[@"content"]==nil) {
        textSize.height=0;
    }
    CGRect textFrame = content_lbl.frame;
    textFrame.size.height = textSize.height;
    [content_lbl setFrame:textFrame];
    
    CGRect tableHeaderBottomViewFrame = tableHeaderBottom_view.frame;
    
    //加载帖子图片
    NSArray *images = _fishLocationCommentInfo[@"images"];
    float imageWidth = (SCREEN_WIDTH-16-6)/3;
    for (int i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8+i*(imageWidth+2), content_lbl.origin.y+content_lbl.height+2+(imageWidth+2)*(i/3), imageWidth, imageWidth)];
        NSString *imageUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)images[i], nil, nil, kCFStringEncodingUTF8));
        UIImage *image = [UIImage imageNamed:@"testJPG"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:image completed:^(UIImage *image,NSError *error,SDImageCacheType cacheType, NSURL *imageURL){
            [[GlobalData sharedInstance].currentUserInfo setAvatarImg:image];
        }];
        [content_lbl.superview addSubview:imageView];
        tableHeaderBottomViewFrame.origin.y = imageView.origin.y+imageView.height+2;
    }
    
    [tableHeaderBottom_view setFrame:tableHeaderBottomViewFrame];
    CGRect tableHeaderViewFrame = tableHeader_view.frame;
    tableHeaderViewFrame.size.height=tableHeaderBottomViewFrame.origin.y+tableHeaderBottomViewFrame.size.height;
    [tableHeader_view setFrame:tableHeaderViewFrame];
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_fishLocationCommentInfo[@"comment"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_fishLocationCommentInfo[@"comment"][section][@"child"] count]+1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        DynamicDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        return [cell cellHeightWithCommentInfo:_fishLocationCommentInfo[@"comment"][indexPath.section]];
    }else{
        DynamicDetailSubCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCommentCell"];
        return [cell cellHeightWithSubCommentInfo:_fishLocationCommentInfo[@"comment"][indexPath.section][@"child"][indexPath.row-1]];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *fishLocationCommentInfo = [_fishLocationCommentInfo[@"comment"] objectAtIndex:indexPath.section];
    if (indexPath.row==0) {
        DynamicDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        [cell setupViewWithCommentInfo:fishLocationCommentInfo];
        return cell;
    }else{
        DynamicDetailSubCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCommentCell"];
        [cell setupViewWithSubCommentInfo:fishLocationCommentInfo[@"child"][indexPath.row-1]];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
