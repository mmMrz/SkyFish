//
//  SelectSkillViewController.m
//  SkyFish
//
//  Created by 张燕枭 on 15/12/3.
//  Copyright © 2015年 CQSQ. All rights reserved.
//

#import "SelectSkillViewController.h"

@interface SelectSkillViewController (){
    __weak IBOutlet UITableView *_tableView;
    NSMutableArray *skillAry;
}

@end

@implementation SelectSkillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return skillAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *SkillCellIdentifier = @"SkillCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SkillCellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:SkillCellIdentifier];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
