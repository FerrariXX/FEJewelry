//
//  JEFirstTabbarVC.m
//  Jewelry
//
//  Created by xxx on 14-4-15.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEFirstTabbarVC.h"
#import "FESidePanelController.h"
#import "JEHomePageModel.h"
#import "JEHomePageTableViewCell.h"
#import "JEDetailVC.h"
#import "FETabBarViewController.h"
#import "JEDetailModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+FETouchBlocks.h"
#import "JEHomePageManager.h"
#import "JECategory.h"
#import "JEPriceRange.h"
#import "JEConst.h"

@interface JEFirstTabbarVC ()
@property(nonatomic, strong)JEHomePageModel  *homePageModel;

@end

@implementation JEFirstTabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.homePageModel = [[JEHomePageManager sharedHomePageManager] homePageModel];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonPressed:)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonPressed:)];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CGFloat height = [[[UIDevice currentDevice] systemVersion] floatValue] <7.0 ? kScreenHeight- 88 - 50 : kScreenHeight - 20 - 88 - 50;
    self.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, height);
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Do any additional setup after loading the view from its nib.
    
    //NSString  *currentCategory  = [[[JEHomePageManager sharedHomePageManager] jewelryCategory] currentSelectedCategory];
    //NSString  *currentPriceRange= [[[JEHomePageManager sharedHomePageManager] jewelryPriceRange] currentSelectedPriceRange];
    //[self.homePageModel loadDataWithCategory:currentCategory priceRange:currentPriceRange];
    
    //InfiniteScrolling
    self.tableView.infiniteScrollingView.backgroundColor = [UIColor orangeColor];
    __weak __typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if ([weakSelf.homePageModel isHaveMore]) {
            [weakSelf.homePageModel loadMoreDataWithCategoryID:weakSelf.categoryID completionBlock:^(BOOL isSuccess) {
                [weakSelf.tableView.infiniteScrollingView stopAnimating];
                if (isSuccess) {
                    [weakSelf.tableView reloadData];
                } else {
                    TBShowErrorToast;
                }
            }];
        }else {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf.tableView setShowsInfiniteScrolling:NO];
            [FEToastView showWithTitle:@" 没有更多了 " animation:YES interval:2.0];
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
//#pragma mark - NaviBar Button 
//- (void)leftBarButtonPressed:(id)sender{
//    [self.sidePanelController showLeftPanelAnimated:YES];
//}
//
//- (void)rightBarButtonPressed:(id)sender{
//    [self.sidePanelController showRightPanelAnimated:YES];
//}

#pragma mark - Public  Method
- (void)reloadData{
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.homePageModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.homePageModel numberOfRowsInSection:section] / 2 + [self.homePageModel numberOfRowsInSection:section] % 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    JEHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [JEHomePageTableViewCell homePageTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.row *2 ;
    
    JEHomePageItem* item = [self.homePageModel contentAtIndexPath:index];
//    [cell.leftItemView.imageView setImageWithURL:[NSURL URLWithString:item.imgURL] placeholderImage:nil];
    cell.leftItemView.descrption.text = item.desInfo;
    cell.leftItemView.idLabel.text    = item.idNumber;
    cell.leftItemView.priceLabel.text = item.price;
    [cell.leftPlaceHolderView touchEndedBlock:^(NSSet *touches, UIEvent *event) {
        cell.leftPlaceHolderView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.leftPlaceHolderView.backgroundColor = [UIColor clearColor];
        });
        NSLog(@">>>left id = %@", item.idNumber);
        [self didSelectedWithId:item.idNumber];
    }];
    
    item = [self.homePageModel contentAtIndexPath:index +1];
    [cell.rightItemView.imageView setImageWithURL:[NSURL URLWithString:item.imgURL] placeholderImage:nil];
    cell.rightItemView.descrption.text = item.desInfo;
    cell.rightItemView.idLabel.text    = item.idNumber;
    cell.rightItemView.priceLabel.text = item.price;
    [cell.rightPlaceHolderView touchEndedBlock:^(NSSet *touches, UIEvent *event) {
        cell.rightPlaceHolderView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cell.rightPlaceHolderView.backgroundColor = [UIColor clearColor];
        });
        NSLog(@">>>right id = %@", item.idNumber);
        [self didSelectedWithId:item.idNumber];

    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JEHomePageTableViewCell height];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //indexPath.row * 2 > [self.homePageModel numberOfRowsInSection:section]
    //[self.homePageModel numberOfRowsInSection:section] / 2 + [self.homePageModel numberOfRowsInSection:section] % 2;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[self.category setSelectedPerson:isSelected indexpath:indexPath];
}

#pragma mark - Private Method
- (void)didSelectedWithId:(NSString*)idString{
    JEDetailModel *model = [[JEDetailModel alloc] initWithId:idString];
    JEDetailVC *detailVC = [[JEDetailVC alloc] initWithNibName:@"JEDetailVC" bundle:nil];
    [detailVC setModel:model];
    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
