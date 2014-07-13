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
#import "JEShopHomeVC.h"
#import "JEWebViewController.h"

@interface JESecondTabbarVC ()
@property(nonatomic, strong)JEJewelryCircleModel  *jewelryCircleModel;
@property (strong, nonatomic) FEScrollPageView *bannerView;

@end

@implementation JESecondTabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.jewelryCircleModel = [[JEJewelryCircleModel alloc] init];
        self.bannerView = [[FEScrollPageView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 160)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.bannerView;
    
    self.title = @"珠宝圈";
//    self.bannerView.palceHoldImage = @"defaultJEwelry";//默认图片
    
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    __weak  JESecondTabbarVC *weakSelf = self;
    [self.jewelryCircleModel loadWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [FEToastView dismissWithAnimation:NO];
            [weakSelf.bannerView setImageItems:weakSelf.jewelryCircleModel.bannerImages selectedBlock:^(FEImageItem *sender) {
                //do nothing here
                if ([sender.imageURL length] >0) {
                    JEWebViewController *webVC = [[JEWebViewController alloc] initWithURL:sender.imageURL];
                    [weakSelf.navigationController pushViewController:webVC animated:YES];
                }
            } isAutoPlay:YES];
            [weakSelf.tableView reloadData];
        } else {
            TBShowErrorToast;
        }
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
    [cell.logoImage setImageWithURL:[NSURL URLWithString:item.shopImage] placeholderImage:[UIImage imageNamed:@"default_avatar"]];
    cell.nameLabel.text  = item.shopName;
    cell.idLabel.text    = item.shopID;
    CGSize fontSize = [item.shopAddress sizeWithFont:cell.addressLabel.font];
    if (fontSize.width > cell.addressLabel.frame.size.width) {
        cell.addressLabel.height = cell.addressLabel.height + 8.0;
        [cell.phoneLabel setOriginY:cell.phoneLabel.origin.y + 8.0];
        [cell.phonePromptLabel setOriginY:cell.phonePromptLabel.origin.y + 8.0];
    }
    cell.addressLabel.text = item.shopAddress;
    cell.phoneLabel.text   = item.shopPhone;
    [cell.detailScrollImagsView setImageItems:item.shopGoodsURL selectedBlock:^(FEImageItem *sender) {
    } isAutoPlay:NO];
    cell.detailScrollImagsView.itemWidth = 80.0f;
    return cell;    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JEJewelryCircleTableViewCell height];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.bannerView stopAutoPlay];
    JEShopHomeVC *vc = [[JEShopHomeVC alloc] initWithNibName:@"JEShopHomeVC" bundle:nil];
    JEJewelryCircleItem* item = [self.jewelryCircleModel contentAtIndexPath:indexPath.row];
    vc.shopID = item.shopID;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
