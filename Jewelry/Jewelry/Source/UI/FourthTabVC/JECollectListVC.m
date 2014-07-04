//
//  JECollectListVC.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JECollectListVC.h"
#import "JECollectCell.h"
#import "JEDetailModel.h"
#import "JEDetailVC.h"

@interface JECollectListVC ()

@end

@implementation JECollectListVC

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
    self.title = @"我的收藏";
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    _collectionModel = [[JECollectionModel alloc] init];
    __weak __typeof(self) weakSelf = self;
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    [weakSelf.collectionModel loadCollectionList:[[FEAccountManager shareInstance] account] completion:^(BOOL isSuccess) {
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
    return _collectionModel.collectionList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"collectCell";
    
    JECollectCell *infoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (infoCell == nil) {
        infoCell = [JECollectCell collectCell];
        infoCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        infoCell.textLabel.textColor = [UIColor blackColor];
    }
    [infoCell refreshCollectionCell:[_collectionModel.collectionList objectAtIndex:indexPath.row]];
    return infoCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JECollectionItem *collectionItem = [_collectionModel.collectionList objectAtIndex:indexPath.row];
    JEDetailModel *model = [[JEDetailModel alloc] initWithId:collectionItem.styleID];
    JEDetailVC *detailVC = [[JEDetailVC alloc] initWithNibName:@"JEDetailVC" bundle:nil];
    [detailVC setModel:model];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
