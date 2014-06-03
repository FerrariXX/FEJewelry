//
//  JEFourthTabbarVC.m
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEFourthTabbarVC.h"
#import "JESettingUserInfoCell.h"
#import "JEUserInfoSettingViewController.h"
#import "JEMyFollowVC.h"
#import "JECollectListVC.h"
#import "JEMyPointsViewController.h"
#import "JEGoldQuotationVC.h"

@interface JEFourthTabbarVC ()

@end

@implementation JEFourthTabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回（向系统发送）分区个数,在这里有多少键就会有多少分区。
    return  3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 1;
    }
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger section = (NSUInteger) [indexPath section];
    if (section == 0) {
        static NSString *CellIdentifier = @"UserInfoCell";
        
        JESettingUserInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (infoCell == nil) {
            infoCell = [JESettingUserInfoCell settingUserInfoCell];
            infoCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            infoCell.textLabel.textColor = [UIColor blackColor];
        }
        return infoCell;
    }else{
        static NSString *CellIdentifier = @"settingCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:CellIdentifier];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.textColor = [UIColor blackColor];
        }
        NSUInteger row = (NSUInteger) [indexPath row];
        
        NSString *cellText;
        if (section == 1) {
            if (row==0) {
                cellText = @"我的收藏";
            }else if (row==1) {
                cellText = @"摇一摇抽奖";
            }else if(row == 2){
                cellText = @"每日金价";
            }else if(row == 3){
                cellText = @"我的积分";
            }
        }else if(section == 2){
           cellText = @"关于我们";
        }
        cell.textLabel.text = cellText;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return [JESettingUserInfoCell height];
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger section = (NSUInteger) [indexPath section];
    if (section == 0) {
        JEUserInfoSettingViewController *userInfoVC = [[JEUserInfoSettingViewController alloc] init];
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }else if(section==1){
        if (indexPath.row == 0){
            JECollectListVC  *collectListVC = [[JECollectListVC alloc] init];
            [self.navigationController pushViewController:collectListVC animated:YES];
        }else if(indexPath.row == 2){
            JEGoldQuotationVC *goldVC = [[JEGoldQuotationVC alloc] init];
            [self.navigationController pushViewController:goldVC animated:YES];
        }else if (indexPath.row == 3) {
            JEMyPointsViewController *pointsVC = [[JEMyPointsViewController alloc] init];
            [self.navigationController pushViewController:pointsVC animated:YES];
        }
    }else if(section == 2){
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
