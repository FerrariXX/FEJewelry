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
#import "JEShakeVC.h"
#import "FEToastView.h"
#import "JEWebViewController.h"
#import "UIImageView+WebCache.h"
#import "UIViewController+FETabbarVC.h"

@interface JEFourthTabbarVC ()
@property (nonatomic, strong)NSString   *aboutMeUrl;
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
    self.title = @"个人信息";

    _tableView.dataSource = self;
    _tableView.delegate = self;
    _userModel = [[JEUserInfoModel alloc] init];
    __weak __typeof(self) weakSelf = self;
    _aboutMeModel = [[JEAboutMeModel alloc] init];
    [weakSelf.aboutMeModel getAboutMeH5Url:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.aboutMeUrl  = weakSelf.aboutMeModel.aboutMeUrl;
        }else {
            TBShowErrorToast;
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if ([FELoginRootVC isLogin]) {
        [self loadData];
    } else {
        __weak __typeof(self) weakSelf = self;
        [FELoginRootVC showLoginVCWithCompletionBlock:^(BOOL isSuccess, id info) {
            if (isSuccess) {
                [weakSelf loadData];
            } else {
                [weakSelf.tabbarViewController setCustomSelectedIndex:0];
            }
        }];
    }
}

- (void)loadData{
    __weak __typeof(self) weakSelf = self;
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    [weakSelf.userModel loadUserInfo:[[FEAccountManager shareInstance] account]  completion:^(BOOL isSuccess) {
        [FEToastView dismissWithAnimation:YES];
        if (isSuccess) {
            [weakSelf.tableView reloadData];
        }else {
            TBShowErrorToast;
        }
    }];
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
            [infoCell.portraitImageView setImageWithURL:[NSURL URLWithString:_userModel.userInfo.avatarURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            }];
            infoCell.nameLable.text = _userModel.userInfo.nickName;
            infoCell.orzLable.text = [NSString stringWithFormat:@"微信号:%@",_userModel.userInfo.microMessageID];
            infoCell.accountLable.text = [NSString stringWithFormat:@"我的账号:%@",_userModel.userInfo.userID];
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
        userInfoVC.userModel = self.userModel;
        [self.navigationController pushViewController:userInfoVC animated:YES];
    }else if(section==1){
        if (indexPath.row == 0){
            JECollectListVC  *collectListVC = [[JECollectListVC alloc] init];
            [self.navigationController pushViewController:collectListVC animated:YES];
        }else if (indexPath.row == 1){
            JEShakeVC  *shakeVC = [[JEShakeVC alloc] init];
            [self.navigationController pushViewController:shakeVC animated:YES];
        }else if(indexPath.row == 2){
            JEGoldQuotationVC *goldVC = [[JEGoldQuotationVC alloc] init];
            [self.navigationController pushViewController:goldVC animated:YES];
        }else if (indexPath.row == 3) {
            JEMyPointsViewController *pointsVC = [[JEMyPointsViewController alloc] init];
            [self.navigationController pushViewController:pointsVC animated:YES];
        }
    }else if(section == 2){
        if (_aboutMeUrl) {
            JEWebViewController *webVC = [[JEWebViewController alloc] initWithURL:_aboutMeUrl];
            [self.navigationController pushViewController:webVC animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
