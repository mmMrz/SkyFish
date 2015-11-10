//
//  FishLocationCommentViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/11/9.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "FishLocationCommentViewController.h"
#import "FishLocationCommentCell.h"

#define countPerPage @"20"

@interface FishLocationCommentViewController (){
    int page;
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray *commentAry;
    
    NSInteger clickedRow;
}

@end

@implementation FishLocationCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    page = 0;
    commentAry = [[NSMutableArray alloc] initWithCapacity:20];
    [self loadData];
}

- (void)loadData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:_fishLocationInfo[@"id"] forKey:@"id"];
    [parameters setObject:[NSString stringWithFormat:@"%d",page] forKey:@"page"];
    [parameters setObject:countPerPage forKey:@"count"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",PLACE_SCORELIST] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue]==0) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showError:responseDic[@"info"]];
        }
        NSLog(@"%@",responseDic);
        commentAry = responseDic[@"data"];
        [_tableView reloadData];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return commentAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(FishLocationCommentCell*)[tableView dequeueReusableCellWithIdentifier:@"FishLocationCommentCellIdentifier"] cellHeightWithFishLocationCommentInfo:commentAry[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *FishLocationCommentCellIdentifier = @"FishLocationCommentCellIdentifier";
    FishLocationCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:FishLocationCommentCellIdentifier];
    [cell setupViewWithFishLocationCommentInfo:commentAry[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    clickedRow = indexPath.row;
    [self performSegueWithIdentifier:@"toFishLocationCommentDetail" sender:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toFishLocationCommentDetail"]) {
        [segue.destinationViewController setValue:commentAry[clickedRow] forKey:@"fishLocationCommentInfo"];
    }
}

@end
