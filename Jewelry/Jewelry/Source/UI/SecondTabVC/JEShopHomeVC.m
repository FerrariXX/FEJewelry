//
//  JEShopHomeVC.m
//  Jewelry
//
//  Created by xxx on 14-5-25.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEShopHomeVC.h"
#import "UIScrollView+FECover.h"
#import "NSObject+FENib.h"
#import "JEJewelryShopModel.h"
#import "JEShopHomeTableViewCell.h"

@interface JEShopHomeVC ()
@property(nonatomic, strong)JEJewelryShopModel  *shopModel;
@property(nonatomic, strong)IBOutlet UIView  *aboveAvatarView;
@property(nonatomic, strong)IBOutlet UILabel *shopLabel;

@end

@implementation JEShopHomeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
//    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        [self setEdgesForExtendedLayout:UIRectEdgeNone];
//    }
//    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
//        [self setAutomaticallyAdjustsScrollViewInsets:NO];
//    }
    self.title = @"店铺首页";
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.aboveAvatarView.frame = CGRectMake(0, FECoverViewHeight - self.aboveAvatarView.frame.size.height, self.aboveAvatarView.frame.size.width, self.aboveAvatarView.frame.size.height);
    [self.tableView addCoverWithImage:[UIImage imageNamed:@"cover.png"] withTopView:nil aboveView:self.aboveAvatarView enableBlur:NO];
    
    //This tableHeaderView plays the placeholder role here.
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, FECoverViewHeight + 0)];

    self.shopModel = [[JEJewelryShopModel alloc] init];
    self.shopLabel.text = self.shopModel.jewelryShopTitle;
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
    return [self.shopModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.shopModel numberOfRowsInSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    JEShopHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [JEShopHomeTableViewCell shopHomeTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.row;
    JEJewelryShopItem* item = [self.shopModel contentAtIndexPath:index];
    [cell.itemImageView setImageWithURL:[NSURL URLWithString:item.imagesURL] placeholderImage:nil];
    cell.nameLabel.text  = item.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",item.price];
    cell.idLabel.text    = item.idNumber;
    cell.dateLabel.text  = item.date;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JEShopHomeTableViewCell height];
}

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

#pragma mark - Private Method
//- (UIView*)aboveAvatarView{
//    if (_aboveAvatarView == nil) {
//        _aboveAvatarView = [JEShopHomeVC instanceWithNibName:@"JEShopHomeVC" bundle:nil owner:nil index:1];
//    }
//    return _aboveAvatarView;
//}

@end
