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
#import "JEPriceRange.h"
#import "FESidePanelController.h"
#import "FEToastView.h"

@interface JEFirstTabbarWrapperPageVC ()<FEScrollPageViewControllerDataSource,FEScrollPageViewControllerDelegate>
@property(nonatomic, readonly)JECategory *jewelryCategory;
@property(nonatomic, readonly)JEPriceRange *jewelryPriceRange;
@property(nonatomic, assign)NSInteger currentTabIndex;
@property(nonatomic, strong)NSString    *currentPriceRange;
@property(nonatomic, strong)FEToastView *toastView;
@end

@implementation JEFirstTabbarWrapperPageVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.dataSource = self;
        self.delegate   = self;
    }
    return self;
}

- (void)viewDidLoad
{
    self.tabItemWidth = 60.0;
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分类" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonPressed:)];
    //self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStyleBordered target:self action:@selector(rightBarButtonPressed:)];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [FEToastView showWithTitle:@"正在加载中..." animation:YES];
        __weak __typeof(self) weakSelf = self;
        [self.jewelryCategory loadCategoryWithCompletionBlock:^(BOOL isSuccess) {
            if (isSuccess) {
                //首次加载第一个分类的第一页
                NSString *categoryID = [weakSelf.jewelryCategory categoryIDAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                categoryID = [categoryID length] >0 ? categoryID : @"01";
                [[JEHomePageManager sharedHomePageManager].homePageModel loadFirstDataWithCategoryID:categoryID  completionBlock:^(BOOL isSuccess) {
                    if (isSuccess) {
                        [weakSelf reloadData];
                        [(JEFirstTabbarVC*)weakSelf.visibleViewController reloadData];
                        [FEToastView dismissWithAnimation:YES];
                    }
                    else {
                        [FEToastView dismissWithAnimation:NO];
                        TBShowErrorToast
                    }
                }];
            }
            else {
                    [FEToastView dismissWithAnimation:NO];
                    TBShowErrorToast
            }
        }];
    });

    NSInteger index = [self.jewelryCategory currentSelectedIndex];
    NSString *priceRange = [self.jewelryPriceRange currentSelectedPriceRange];
    if (self.currentTabIndex != index || [self.currentPriceRange isEqualToString:priceRange]) {
        //[self selectTabAtIndex:index];
        self.currentTabIndex = index;
        self.currentPriceRange = priceRange;
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

- (JEPriceRange *)jewelryPriceRange{
    return  [[JEHomePageManager sharedHomePageManager] jewelryPriceRange];
}

- (void)loadCategoryWithID:(NSString*)categoryID{
    
    [[JEHomePageManager sharedHomePageManager].homePageModel resetData];
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    [[JEHomePageManager sharedHomePageManager].homePageModel loadFirstDataWithCategoryID:categoryID  completionBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            [(JEFirstTabbarVC*)self.visibleViewController reloadData];
            [FEToastView dismissWithAnimation:YES];
        }
        else {
            [FEToastView dismissWithAnimation:NO];
            TBShowErrorToast
        }
    }];
    
}


#pragma mark - FEScrollPageViewControllerDataSource
- (NSUInteger)numberOfSections{
    return 1;
}
- (NSUInteger)numberOfTabsInSection:(NSUInteger)section{
    return [self.jewelryCategory numberOfRowsInSection:0];

}
- (UIView *)tabViewAtSection:(NSUInteger)section tabIndex:(NSUInteger)index{
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    label.text = [NSString stringWithFormat:@"%@", [self.jewelryCategory contentAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)contentViewControllerForTabAtSection:(NSUInteger)section index:(NSUInteger)index{
    JEFirstTabbarVC *vc = [[JEFirstTabbarVC alloc] initWithNibName:@"JEFirstTabbarVC" bundle:nil];
    vc.categoryID = [self.jewelryCategory categoryIDAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
    return vc;
}

#pragma mark - FEScrollPageViewControllerDelegate

- (void)viewPage:(FEScrollPageViewController *)viewPager didChangeTabToSection:(NSUInteger)section index:(NSUInteger)index contentVC:(UIViewController*)contentVC{
    
    //NSLog(@">>>didChangeTabToSection %@ ",contentVC);
    self.currentTabIndex = index;
    [self.jewelryCategory didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
    
    NSString *categoryID = [self.jewelryCategory categoryIDAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]];
    categoryID = [categoryID length] >0 ? categoryID : @"01";
    [self loadCategoryWithID:categoryID];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////
/*
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
    [self.jewelryCategory didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}
 */
////////////////////////////////////////////////////////////////////////////////////////////////////////

@end
