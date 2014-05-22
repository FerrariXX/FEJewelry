//
//  JESecondTabbarVC.m
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JESecondTabbarVC.h"
#import "JEJewelryCircleModel.h"

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
    return 0;
    // Return the number of sections.
    return [self.jewelryCircleModel numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
    // Return the number of rows in the section.
    return [self.jewelryCircleModel numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    /*
    JEHomePageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [JEHomePageTableViewCell homePageTableViewCell];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSInteger index = indexPath.row *2 ;
    
    JEHomePageItem* item = [self.homePageModel contentAtIndexPath:index];
    [cell.leftItemView.imageView setImageWithURL:[NSURL URLWithString:item.imgURL] placeholderImage:nil];
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
     */
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //return [JEHomePageTableViewCell height];
    return 0.0;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[self.category setSelectedPerson:isSelected indexpath:indexPath];
}


@end
