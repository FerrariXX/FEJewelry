//
//  JFUserInfoSettingViewController.m
//  Jewelry
//
//  Created by wuyj on 14-5-30.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEUserInfoSettingViewController.h"
#import "JEUserInfoUpgradeCell.h"
#import "JEModifyUserInfoViewController.h"


@interface JEUserInfoSettingViewController ()
@property (nonatomic, strong)UIImageView *portraitImageView;
@end

@implementation JEUserInfoSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)updateUserInfo:(NSNotification*)notification {
    if (notification.userInfo) {
        _userModel.userInfo = [notification.userInfo objectForKey:@"userInfoItem"];
//        [_tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo:) name:@"refreshUserInfoNoti" object:nil];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人信息";
    _tableView.dataSource = self;
    _tableView.delegate = self;
//    _portraitImageView = [[UIImageView alloc] initWithFrame: CGRectMake(kScreenWith - 100, 10, 60, 60)];
//    _portraitImageView.image = [UIImage imageNamed:@"hzw"];
//    _portraitImageView.layer.cornerRadius  = _portraitImageView.frame.size.width/2.0;
//    _portraitImageView.layer.masksToBounds = YES;
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回（向系统发送）分区个数,在这里有多少键就会有多少分区。
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     static NSString *upgradeCellIdentifier = @"userInfoUpgradeCell";
    if (indexPath.section == 0 && indexPath.row==0) {
        JEUserInfoUpgradeCell *userInfoCell = [tableView dequeueReusableCellWithIdentifier:upgradeCellIdentifier];
        if (userInfoCell == nil) {
            userInfoCell = [JEUserInfoUpgradeCell userInfoUpgradeCell];
            userInfoCell.textLabel.textColor = [UIColor blackColor];
        }
        return userInfoCell;
    }
    
    static NSString *CellIdentifier = @"userInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    NSUInteger section = (NSUInteger) [indexPath section];
    NSUInteger row = (NSUInteger) [indexPath row];
    UILabel *rightLable = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
    rightLable.font = [UIFont boldSystemFontOfSize:14];
    [rightLable sizeToFit];
    rightLable.backgroundColor = [UIColor clearColor];
    NSString *cellText;
    if (section == 0) {
        if(row == 1){
            cellText = @"昵称";
            rightLable.text = _userModel.userInfo.nickName;
            rightLable.tag = 1;
        }else if(row == 2){
            cellText = @"我的账号";
            rightLable.text = _userModel.userInfo.userID;
            rightLable.tag = 2;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else if(row == 3){
            cellText = @"我的微信号";
            rightLable.tag = 3;
            rightLable.text = _userModel.userInfo.microMessageID;
        }
    }
    if (rightLable.text) {
        CGSize titleSize = [rightLable.text sizeWithFont:rightLable.font];
        rightLable.frame = CGRectMake(kScreenWith - 29 - titleSize.width, 7, titleSize.width, 30);
        [cell.contentView addSubview:rightLable];
    }
    cell.textLabel.text = cellText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && [indexPath row] == 0) {
        return 80;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JEModifyUserInfoViewController *modifyVC = [JEModifyUserInfoViewController alloc];
    if (indexPath.row == 1) {
        modifyVC.type = 1;
        modifyVC.modifyText = _userModel.userInfo.nickName;
    }else{
        modifyVC.type = 2;
        modifyVC.modifyText = _userModel.userInfo.microMessageID;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController presentModalViewController:modifyVC animated:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshUserInfoNoti" object:nil];
}

@end
