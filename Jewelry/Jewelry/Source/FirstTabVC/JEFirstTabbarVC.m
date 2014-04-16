//
//  JEFirstTabbarVC.m
//  Jewelry
//
//  Created by lv on 14-4-15.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEFirstTabbarVC.h"
#import "FESidePanelController.h"

@interface JEFirstTabbarVC ()

@end

@implementation JEFirstTabbarVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonPressed:)];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NaviBar Button 
- (void)leftBarButtonPressed:(id)sender{
    NSLog(@">>>xxx1");
    [self.sidePanelController showLeftPanelAnimated:YES];

}

- (void)rightBarButtonPressed:(id)sender{
    [self.sidePanelController showRightPanelAnimated:YES];

}

@end
