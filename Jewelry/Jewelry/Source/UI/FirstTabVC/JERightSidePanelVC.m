//
//  JERightSidePanelVC.m
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JERightSidePanelVC.h"
#import "JEHomePageManager.h"
#import "JEFilterType.h"
#import "FESidePanelController.h"


@interface JERightSidePanelVC ()
@property(nonatomic, strong)JEFilterType *filterType;

@end

@implementation JERightSidePanelVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _filterType = [[JEHomePageManager sharedHomePageManager] jewelryFilterType];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"筛选";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonPressed:)];

    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak __typeof(self) weakSelf = self;
    [self.filterType  loadFilterTypeWithCompletionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [weakSelf.tableView reloadData];
        }else {
            [FEToastView showWithTitle:@"  加载出错，请稍候再试。  " animation:YES interval:2.0];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.filterType numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.filterType numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	cell.textLabel.text = [self.filterType contentAtIndexPath:indexPath];
	cell.accessoryType  = UITableViewCellAccessoryNone;
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.filterType didSelectRowAtIndexPath:indexPath];
    //[self.sidePanelController showCenterPanelAnimated:YES];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
- (void)leftBarButtonPressed:(id)sender{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

@end
