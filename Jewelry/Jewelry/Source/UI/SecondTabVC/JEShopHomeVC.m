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
@property(nonatomic, strong)IBOutlet UILabel *shopNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopPhoneLabel;
@property (assign, nonatomic) NSInteger listCount;
@property (assign, nonatomic) NSInteger pageNumber;
@end

@implementation JEShopHomeVC

- (JEJewelryShopModel *)shopModel{
    if (_shopModel == nil) {
        _shopModel = [[JEJewelryShopModel alloc] init];
    }
    return _shopModel;
}

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

    __weak  JEShopHomeVC *weakSelf = self;
    self.pageNumber = 0;
    [self.shopModel loadWithShopID:self.shopID completionBlock:^(BOOL isSuccess) {
        [weakSelf updateData];
    }];
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
    self.listCount = [self.shopModel numberOfRowsInSection:section];
    // Return the number of rows in the section.
    return self.listCount;
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
    [cell.itemImageView setImageWithURL:[NSURL URLWithString:item.imageURL] placeholderImage:nil];
    cell.nameLabel.text  = item.name;
    cell.priceLabel.text = [NSString stringWithFormat:@"￥%@",item.price];
    cell.idLabel.text    = item.idNumber;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JEShopHomeTableViewCell height];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak  JEShopHomeVC *weakSelf = self;
    if (indexPath.row > (self.listCount -5)) {
        [self.shopModel loadWithShopID:self.shopID pageNumber:self.pageNumber completionBlock:^(BOOL isSuccess) {
            [weakSelf updateData];
        }];
    }
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Private Method

- (void)updateData{
    self.shopNameLabel.text = self.shopModel.jewelryShopTitle;
    self.shopPhoneLabel.text = self.shopModel.jewelryShopPhone;
    [self.tableView reloadData];
}
//- (UIView*)aboveAvatarView{
//    if (_aboveAvatarView == nil) {
//        _aboveAvatarView = [JEShopHomeVC instanceWithNibName:@"JEShopHomeVC" bundle:nil owner:nil index:1];
//    }
//    return _aboveAvatarView;
//}

@end
