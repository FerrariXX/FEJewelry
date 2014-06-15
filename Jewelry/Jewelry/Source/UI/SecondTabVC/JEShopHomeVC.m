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
#import "JEDetailModel.h"
#import "JEDetailVC.h"

@interface JEShopHomeVC ()
@property(nonatomic, strong)JEJewelryShopModel  *shopModel;
@property(nonatomic, strong)IBOutlet UIView  *aboveAvatarView;
@property(nonatomic, strong)IBOutlet UILabel *shopNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *shopPhoneLabel;
@property (strong, nonatomic) IBOutlet UIButton *phoneButton;
@property (assign, nonatomic) NSInteger listCount;
@property (assign, nonatomic) NSInteger pageNumber;
- (IBAction)phoneButtonPressed:(id)sender;
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
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
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
        if (isSuccess) {
            [weakSelf updateData];
        } else {
            TBShowErrorToast;
        }
    }];
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if ([weakSelf.shopModel isHaveMore]) {
            [weakSelf.shopModel loadMoreWithShopID:weakSelf.shopID completionBlock:^(BOOL isSuccess) {
                [weakSelf.tableView.infiniteScrollingView stopAnimating];
                if (isSuccess) {
                    if ([weakSelf.shopModel isHaveMore]) {
                        [weakSelf.tableView reloadData];
                    } else {
                        [weakSelf.tableView setShowsInfiniteScrolling:NO];
                        //[weakSelf.tableView setContentInset:UIEdgeInsetsMake(0, 0, 50.0, 0)];
                        [FEToastView showWithTitle:@" 没有更多了 " animation:YES interval:2.0];
                    }
                } else {
                    TBShowErrorToast;
                }
            }];
        }else {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf.tableView setShowsInfiniteScrolling:NO];
            //[weakSelf.tableView setContentInset:UIEdgeInsetsMake(0, 0, 50.0, 0)];
            [FEToastView showWithTitle:@" 没有更多了 " animation:YES interval:2.0];
        }
    }];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [FEToastView dismissWithAnimation:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc{
    [self.tableView removeCoverView];
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

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    __weak  JEShopHomeVC *weakSelf = self;
//    if (indexPath.row > (self.listCount -5)) {
//        [self.shopModel loadWithShopID:self.shopID pageNumber:self.pageNumber completionBlock:^(BOOL isSuccess) {
//            [weakSelf updateData];
//        }];
//    }
//}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JEJewelryShopItem* item = [self.shopModel contentAtIndexPath:indexPath.row];
    JEDetailModel *model = [[JEDetailModel alloc] initWithId:item.idNumber];
    JEDetailVC *detailVC = [[JEDetailVC alloc] initWithNibName:@"JEDetailVC" bundle:nil];
    [detailVC setModel:model];
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - Private Method

- (void)updateData{
    self.shopNameLabel.text = self.shopModel.jewelryShopTitle;
    [self.phoneButton setTitle:self.shopModel.jewelryShopPhone forState:UIControlStateNormal];
    //self.shopPhoneLabel.text = self.shopModel.jewelryShopPhone;
    [self.tableView reloadData];
}

- (IBAction)phoneButtonPressed:(id)sender {
    if ([self.phoneButton.titleLabel.text length] >0) {
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",self.phoneButton.titleLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
    
}
@end
