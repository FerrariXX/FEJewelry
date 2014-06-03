//
//  JEGoldQuotationVC.m
//  Jewelry
//
//  Created by wuyj on 14-6-3.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEGoldQuotationVC.h"
#import "JEGoldQuotationCell.h"

@interface JEGoldQuotationVC ()

@end

@implementation JEGoldQuotationVC

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
    self.title = @"每日金价";
    // Do any additional setup after loading the view from its nib.
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc ] initWithFrame:CGRectZero];
//    _tableView.frame = CGRectMake(10, 0, CGRectGetWidth(_tableView.frame), 44*5);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.0f;
}

// 自定义UITableView的区段的Header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //创建一个视图（_headerView）
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 45)];
    headerView.backgroundColor = [UIColor grayColor];
    
    // 创建一个 _headerLabel 用来显示标题
    UILabel *productLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, 43, 22)];
    productLabel.backgroundColor = [UIColor clearColor];
    productLabel.textAlignment = UITextAlignmentCenter;
    productLabel.textColor = [UIColor whiteColor];
    productLabel.font = [UIFont fontWithName:@"Arial" size:14.];
    productLabel.text = @"产品";
    [headerView addSubview:productLabel];
    
    // 分割线
    UIImageView *separatorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(productLabel.frame), 0, 1, 45)];
    separatorImageView.image = [UIImage imageNamed:@"dashed"];
    [headerView addSubview:separatorImageView];
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(productLabel.frame)+1, 11, 157, 22)];
    priceLabel.backgroundColor = [UIColor clearColor];
    priceLabel.textAlignment = UITextAlignmentCenter;
    priceLabel.textColor = [UIColor whiteColor];
    priceLabel.font = [UIFont fontWithName:@"Arial" size:14.];
    priceLabel.text = @"价格";
    [headerView addSubview:priceLabel];
    
    UIImageView *separatorImageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame), 0, 1, 45)];
    separatorImageView2.image = [UIImage imageNamed:@"dashed"];
    [headerView addSubview:separatorImageView2];
    
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(priceLabel.frame)+1, 11, 90, 22)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textAlignment = UITextAlignmentCenter;
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont fontWithName:@"Arial" size:14.];
    dateLabel.text = @"日期";
    [headerView addSubview:dateLabel];
    
    return headerView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回（向系统发送）分区个数,在这里有多少键就会有多少分区。
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"goldCell";
    
    JEGoldQuotationCell *goldQuotationCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (goldQuotationCell == nil) {
        goldQuotationCell = [JEGoldQuotationCell goldQuotationCell];
    }
    return goldQuotationCell;
    
}

@end
