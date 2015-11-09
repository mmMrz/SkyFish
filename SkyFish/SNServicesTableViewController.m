//
//  SNServicesTableViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/10/23.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "SNServicesTableViewController.h"
#import "SNServicesTableCell.h"
#import "DynamicDetailViewController.h"

@interface SNServicesTableViewController () {
    NSMutableArray *dynamicAry;
    NSInteger clickedRow;
}
@end

@implementation SNServicesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dynamicAry = [[NSMutableArray alloc] initWithCapacity:20];
    
    [self loadData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadData
{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:@"0" forKey:@"page"];
    [parameters setObject:@"20" forKey:@"count"];
    [CSLoadData requestOfInfomationWithURI:[NSString stringWithFormat:@"%@",WEIBO_GETLISTGROUND] andParameters:parameters complete:^(NSDictionary *responseDic) {
        if ([CheckData isEmpty:responseDic[@"msg"]]) {
            [ProgressHUD dismiss];
        }else{
            [ProgressHUD showSuccess:responseDic[@"msg"]];
        }
        NSLog(@"%@",responseDic);
        [dynamicAry addObjectsFromArray:responseDic[@"data"]];
        [self.tableView reloadData];
    } failed:^(NSError *error) {
        [ProgressHUD showError:[error localizedDescription]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dynamicAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [(SNServicesTableCell*)[tableView dequeueReusableCellWithIdentifier:@"SNServicesTableCell"] cellHeightWithDynamicInfo:dynamicAry[indexPath.row]];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SNServicesTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SNServicesTableCell"];
    
    NSDictionary *dynamicInfo = [dynamicAry objectAtIndex:indexPath.row];
    
    [cell setupViewWithDynamicInfo:dynamicInfo];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    clickedRow = indexPath.row;
    [self performSegueWithIdentifier:@"toDynamicDetail" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"toDynamicDetail"]) {
        DynamicDetailViewController *destinationViewController = segue.destinationViewController;
        [destinationViewController setDynamicInfo:dynamicAry[clickedRow]];
        clickedRow = -1;
    }
}

@end
