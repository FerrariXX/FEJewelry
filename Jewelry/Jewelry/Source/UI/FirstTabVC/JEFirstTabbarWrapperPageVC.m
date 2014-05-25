//
//  JEFirstTabbarWrapperPageVC.m
//  Jewelry
//
//  Created by xxx on 14-5-18.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEFirstTabbarWrapperPageVC.h"
#import "JEFirstTabbarVC.h"
#import "JEHomePageModel.h"
#import "JEHomePageManager.h"
#import "JECategory.h"
#import "FESidePanelController.h"
#import "ViewPagerController.h"


@interface JEFirstTabbarWrapperPageVC ()<ViewPagerDataSource,ViewPagerDelegate>
@property(nonatomic, readonly)JECategory *jewelryCategory;
@property(nonatomic, assign)NSInteger currentTabIndex;
@end

@implementation JEFirstTabbarWrapperPageVC

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
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonPressed:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonPressed:)];
    
    self.dataSource = self;
    self.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSInteger index = [self.jewelryCategory currentSelectedIndex];
    if (self.currentTabIndex != index) {
        [self selectTabAtIndex:index];
        self.currentTabIndex = index;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - NaviBar Button
- (void)leftBarButtonPressed:(id)sender{
    [self.sidePanelController showLeftPanelAnimated:YES];
}

- (void)rightBarButtonPressed:(id)sender{
    [self.sidePanelController showRightPanelAnimated:YES];
}


#pragma mark - Private Method

- (JECategory *)jewelryCategory{
    return  [[JEHomePageManager sharedHomePageManager] jewelryCategory];
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return [self.jewelryCategory numberOfRowsInSection:0];
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = [NSString stringWithFormat:@"%@", [self.jewelryCategory contentAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    JEFirstTabbarVC *vc = [[JEFirstTabbarVC alloc] initWithNibName:@"JEFirstTabbarVC" bundle:nil];
    vc.homePageModel = [[JEHomePageModel alloc] init];//TODO:
    return vc;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            return 1.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            return 1.0;
            break;
        case ViewPagerOptionTabLocation:
            return 1.0;
            break;
        case ViewPagerOptionTabWidth:
            return 60;
            break;
        default:
            break;
    }
    
    return value;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        case ViewPagerTabsView:
            return [UIColor lightGrayColor];
            break;
//        case ViewPagerContent:
//            return [UIColor redColor];
//            break;
        default:
            break;
    }
    
    return color;
}

#pragma mark - ViewPagerDelegate
- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    
    // TODO: something useful
    self.currentTabIndex = index;
}

@end
