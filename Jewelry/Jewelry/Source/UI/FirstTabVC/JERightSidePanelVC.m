//
//  JERightSidePanelVC.m
//  Jewelry
//
//  Created by lv on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JERightSidePanelVC.h"
#import "JEHomePageManager.h"
#import "JEPriceRange.h"
#import "FESidePanelController.h"


@interface JERightSidePanelVC ()
@property(nonatomic, strong)JEPriceRange *priceRange;

@end

@implementation JERightSidePanelVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _priceRange = [[JEHomePageManager sharedHomePageManager] jewelryPriceRange];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"筛选";
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
    return [self.priceRange numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.priceRange numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	cell.textLabel.text = [self.priceRange contentAtIndexPath:indexPath];
	cell.accessoryType  = UITableViewCellAccessoryNone;
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.priceRange didSelectRowAtIndexPath:indexPath];
    [self.sidePanelController showCenterPanelAnimated:YES];

}



@end
