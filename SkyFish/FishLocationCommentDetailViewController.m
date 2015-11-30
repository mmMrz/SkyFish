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
#import "PersonPage.h"

@interface FishLocationCommentDetailViewController (){
    __weak IBOutlet UIView *reply_view;
    __weak IBOutlet UITextField *reply_tf;
    __weak IBOutlet NSLayoutConstraint *relyView_bttom;
    
    NSString *fid;
    
    float keyBoardHeight;
}

@end

@implementation FishLocationCommentDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
        _fishLocationCommentInfo = [[NSMutableDictionary alloc] initWithDictionary:responseDic[@"data"]];
        [self sortChildCommentForComment];
        [self setupView];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

//序列化动态的评论数组
- (void)sortChildCommentForComment
{
    NSMutableArray *commentAry = [[NSMutableArray alloc] initWithArray:_fishLocationCommentInfo[@"comment"]];
    for (int i=0;i<[commentAry count];i++) {
        NSMutableDictionary *commentInfo = [[NSMutableDictionary alloc] initWithDictionary:_fishLocationCommentInfo[@"comment"][i]];
        NSMutableArray *childCommentAry = [[NSMutableArray alloc] initWithCapacity:10];
        [self recursionForCommentChild:commentInfo andChildCommentAry:childCommentAry];
        [commentInfo setObject:childCommentAry forKey:@"child"];
        [commentAry replaceObjectAtIndex:i withObject:commentInfo];
    }
    [_fishLocationCommentInfo setObject:commentAry forKey:@"comment"];
}

//递归得到所有的子回复
- (void)recursionForCommentChild:(NSDictionary *)commentInfo andChildCommentAry:(NSMutableArray *)childCommentAry
{
    for (NSDictionary *subCommentInfo in commentInfo[@"child"]) {
        [childCommentAry addObject:subCommentInfo];
        if ([subCommentInfo[@"child"] count]>0) {
            [self recursionForCommentChild:subCommentInfo andChildCommentAry:childCommentAry];
        }
    }
}

- (void)setupView
{
    [name_lbl setText:_fishLocationCommentInfo[@"authorName"]];
    for (NSLayoutConstraint *constraint in grade_view.constraints) {
        if (constraint.firstItem==grade_view&&constraint.firstAttribute==NSLayoutAttributeWidth) {
            constraint.constant = 150*[_fishLocationCommentInfo[@"score"] floatValue]/5;
        }
    }
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
    for (NSLayoutConstraint *constraint in content_lbl.constraints) {
        if (constraint.firstItem==content_lbl&&constraint.firstAttribute==NSLayoutAttributeHeight) {
            constraint.constant = textSize.height;
        }
    }
    
    CGRect tableHeaderBottomViewFrame = tableHeaderBottom_view.frame;
    
    //清空原始数据
    for (id view in [tableHeader_view subviews]) {
        if ([view isKindOfClass:[UIImageView class]]&&[view tag]==1) {
            [view removeFromSuperview];
        }
    }
    
    //加载帖子图片
    NSArray *images = _fishLocationCommentInfo[@"images"];
    float imageWidth = (SCREEN_WIDTH-16-6)/3;
    for (int i=0; i<images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(8+(i%3)*(imageWidth+2), content_lbl.origin.y+content_lbl.height+2+(imageWidth+2)*(i/3), imageWidth, imageWidth)];
        [imageView setTag:1];
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
    [_tableView setTableHeaderView:tableHeader_view];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dynamicInfo = [_fishLocationCommentInfo[@"comment"] objectAtIndex:indexPath.section];
    NSString *uid=@"0",*uname=@"匿名";
    if (indexPath.row==0) {
        uid = dynamicInfo[@"id"];
        uname = dynamicInfo[@"authorName"];
    }else{
        uid = dynamicInfo[@"child"][indexPath.row-1][@"id"];
        uname = dynamicInfo[@"child"][indexPath.row-1][@"authorName"];
    }
    [self replyUserWithId:uid andName:uname];
}

- (IBAction)comment:(UIButton*)sender
{
    [reply_tf setPlaceholder:[NSString stringWithFormat:@"说点什么吧"]];
    fid = @"";
    [reply_tf becomeFirstResponder];
}


#pragma mark - 键盘出现
- (void)keyboardWillShow:(NSNotification*)notification
{
    NSDictionary *userInfo = [notification userInfo];
    
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    CGFloat keyboardTop = keyboardRect.origin.y;
    
    //    CGFloat textFieldBottom = textFieldFrame.origin.y+type_view.frame.size.height;
    CGFloat textFieldBottom = SCREEN_HEIGHT - 39;
    
    
    CGFloat shouldMove = 0;
    if (textFieldBottom>keyboardTop) {
        shouldMove = textFieldBottom-keyboardTop;
        
    }
    CGRect newViewFrame = reply_view.frame;
    newViewFrame.origin.y-=shouldMove;
    
    //    [UIView animateWithDuration:0.35 animations:^{
    //        reply_view.frame = newViewFrame;
    //    }];
    keyBoardHeight = keyboardRect.size.height;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [relyView_bttom setConstant:keyboardRect.size.height];
        [self.view layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
}
#pragma mark - 键盘即将改变尺寸
- (void)keyboardWillChangeFrame:(NSNotification*)notification
{
    //固定键盘时这里不需要操作
}
#pragma mark - 键盘即将消失
- (void)keyboardWillHide:(NSNotification*)notification
{
    //    CGRect newViewFrame = reply_view.frame;
    //    newViewFrame.origin.y=self.view.frame.size.height-type_view.frame.size.height;
    //    newViewFrame.origin.y=self.view.frame.size.height-60;
    
    //    reply_view.frame = newViewFrame;
#pragma mark - 键盘回收的时候 处理一下选择图片组件按钮的状态 因为如果当前是打开的情况下 直接可以编辑输入框 这时候键盘如果回收 那么 按钮与打开与否的情况不一致
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [relyView_bttom setConstant:0];
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
    keyBoardHeight = 0;
}

- (IBAction)sendComment:(UIButton *)sender {
    [reply_tf resignFirstResponder];
    if ([reply_tf.text isEqualToString:@""]) {
        return;
    }
    //评论
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_fishLocationCommentInfo[@"id"] forKey:@"sid"];
    [parameters setObject:fid forKey:@"fid"];
    [parameters setObject:reply_tf.text forKey:@"content"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",PLACE_COMMENT] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"info"]];
        }
        //刷新
        [ProgressHUD showSuccess:@"回复成功"];
        [self loadData];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendComment:nil];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [reply_tf resignFirstResponder];
}

- (void)replyUserWithId:(NSString *)uid andName:(NSString *)uname
{
    [reply_tf setPlaceholder:[NSString stringWithFormat:@"回复给:%@",uname]];
    fid = uid;
    [reply_tf becomeFirstResponder];
}

- (IBAction)toUserProfile:(UIButton *)sender {
    [self toUserProfileWithUserId:_fishLocationCommentInfo[@"authorId"]];
}

- (void)toUserProfileWithUserId:(NSString *)uid
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    PersonPage *personPage = [story instantiateViewControllerWithIdentifier:@"PersonPage"];
    [personPage setUid:uid];
    [self.navigationController pushViewController:personPage animated:YES];
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
