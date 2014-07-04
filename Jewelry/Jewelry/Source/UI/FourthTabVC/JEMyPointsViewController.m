//
//  JEMyPointsViewController.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEMyPointsViewController.h"
#import "JEMyPointsCell.h"

@interface JEMyPointsViewController ()

@end

@implementation JEMyPointsViewController

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
    self.title = @"我的积分";
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _myPointsModel = [[JEMyPointsModel alloc] init];
    // Do any additional setup after loading the view from its nib.
    __weak __typeof(self) weakSelf = self;
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    [_myPointsModel loadMyPointList:[[FEAccountManager shareInstance] account]  completion:^(BOOL isSuccess) {
        [FEToastView dismissWithAnimation:YES];
        if (isSuccess) {
            [weakSelf.tableView reloadData];
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
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _myPointsModel.myPointList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"myPointsCell";
    
    JEMyPointsCell *infoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (infoCell == nil) {
        infoCell = [JEMyPointsCell myPointsCell];
        infoCell.accessoryType=UITableViewCellAccessoryNone;
        infoCell.textLabel.textColor = [UIColor blackColor];
    }
    
    [infoCell refreshCell:[_myPointsModel.myPointList objectAtIndex:indexPath.row]];
    
    return infoCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
