//
//  JELeftSidePanelVC.m
//  Jewelry
//
//  Created by lv on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JELeftSidePanelVC.h"
#import "JECategory.h"
@interface JELeftSidePanelVC ()
@property(nonatomic, strong)JECategory *category;
@end

@implementation JELeftSidePanelVC

#pragma mark - Life Circle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _category = [[JECategory alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择类别";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter & Setter 
- (JECategory *)category{
    if (_category == nil) {
        _category = [[JECategory alloc] init];
    }
    return _category;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [self.category numberOfSection];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.category numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	cell.textLabel.text = [self.category contentAtIndexPath:indexPath];
	cell.accessoryType  = UITableViewCellAccessoryNone;
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//[self.category setSelectedPerson:isSelected indexpath:indexPath];
}


@end
