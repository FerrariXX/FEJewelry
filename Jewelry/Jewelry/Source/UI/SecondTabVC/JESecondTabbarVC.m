//
//  JESecondTabbarVC.m
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JESecondTabbarVC.h"
#import "JEJewelryCircleModel.h"
#import "JEJewelryCircleTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "FEScrollPageView.h"


@interface JESecondTabbarVC ()
@property(nonatomic, strong)JEJewelryCircleModel  *jewelryCircleModel;

@end

@implementation JESecondTabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.jewelryCircleModel = [[JEJewelryCircleModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"消息" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonPressed:)];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.jewelryCircleModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.jewelryCircleModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    
    JEJewelryCircleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [JEJewelryCircleTableViewCell jewelryCircleTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.row;
    JEJewelryCircleItem* item = [self.jewelryCircleModel contentAtIndexPath:index];
    //[cell.logoImage setImageWithURL:[NSURL URLWithString:item.logoURL] placeholderImage:nil];
    cell.titleLabel.text = item.title;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",item.price];
    cell.nameLabel.text  = item.name;
    cell.categoryLabel.text = item.category;
    cell.idLabel.text       = item.idNumber;
    cell.certificationIdLabel.text = item.certificationId;
    [cell.detailScrollImagsView setImageItems:item.imagesURL selectedBlock:^(FEImageItem *sender) {
    } isAutoPlay:NO];
    return cell;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JEJewelryCircleTableViewCell height];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}


#pragma mark - NaviBar Button
- (void)leftBarButtonPressed:(id)sender{
    //TODO:
}

@end
