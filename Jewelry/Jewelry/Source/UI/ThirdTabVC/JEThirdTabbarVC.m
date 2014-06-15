//
//  JEThirdTabbarVC.m
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEThirdTabbarVC.h"
#import "JEDiamondListCell.h"

@interface JEThirdTabbarVC ()
@property (nonatomic, strong) NSMutableArray *neatness;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *stones;
@property (nonatomic, strong) NSMutableArray *prices;
@property (nonatomic, assign) NSInteger pageNumber;
@end

@implementation JEThirdTabbarVC

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

    _pageNumber = 1;
    _model = [[JEDiamondModel alloc] init];
    // Do any additional setup after loading the view from its nib.
    _neatness = [NSMutableArray arrayWithObjects:@"FL",@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2", nil];
    _colors = [NSMutableArray arrayWithObjects:@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K", nil];
    _stones = [NSMutableArray arrayWithObjects:@"30-40ct",@"40-50ct",@"50-60ct",@"60-80ct",@"80-100ct",@"100ct", nil];
    _prices = [NSMutableArray arrayWithObjects:@"0~5000",@"5000~8000",@"8000~12000",@"12000~20000",@" 20000~30000",@"30000~50000",@"50000以上",nil];
    
    [_neatnessMenu reloadData];
    [_colorMenu reloadData];
    [_stoneMenu reloadData];
    [_priceMenu reloadData];
    
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    self.tableView.tableHeaderView =  [JEDiamondListCell diamondListCellHeaderView];
//    self.tableView.scrollEnabled   = NO;
    
    
    self.tableView.infiniteScrollingView.backgroundColor = [UIColor orangeColor];
    __weak __typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if ([weakSelf.model isHaveMore]) {
            weakSelf.pageNumber++;
            [weakSelf.model loadDiamondList:[NSString stringWithFormat:@"%d",weakSelf.pageNumber] neatness:@"" color:@"" weightID:@"" priceID:@"" completion:^(BOOL isSuccess) {
                [FEToastView dismissWithAnimation:YES];
                if (isSuccess) {
                    [weakSelf.tableView.infiniteScrollingView stopAnimating];
                    [weakSelf.tableView reloadData];
                }else {
                    TBShowErrorToast;
                }
            }];
        }else {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            [weakSelf.tableView setShowsInfiniteScrolling:NO];
            [FEToastView showWithTitle:@" 没有更多了 " animation:YES interval:2.0];
        }
    }];
    
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    [weakSelf.model loadDiamondList:@"1" neatness:@"" color:@"" weightID:@"" priceID:@"" completion:^(BOOL isSuccess) {
        [FEToastView dismissWithAnimation:YES];
        if (isSuccess) {
            [weakSelf.tableView reloadData];
        }else {
            TBShowErrorToast;
        }
    }];


}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark HorizMenu Data Source
- (UIImage*) selectedItemImageForMenu:(MKHorizMenu*) tabMenu
{
    return [[UIImage imageNamed:@"ButtonSelected"] stretchableImageWithLeftCapWidth:16 topCapHeight:0];
}

- (UIColor*) backgroundColorForMenu:(MKHorizMenu *)tabView
{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"MenuBar"]];
}

- (int) numberOfItemsForMenu:(MKHorizMenu *)tabView
{
    if (tabView.tag == 11) {
        return [self.neatness count];
    }else if(tabView.tag == 21) {
        return [self.stones count];
    }else if(tabView.tag == 31){
        return [self.prices count];
    }else if(tabView.tag == 41){
        return [self.colors count];
    }
    return 0;
}

- (NSString*) horizMenu:(MKHorizMenu *)horizMenu titleForItemAtIndex:(NSUInteger)index
{
    if (horizMenu.tag == 11) {
        return [self.neatness objectAtIndex:index];
    }else if(horizMenu.tag == 21) {
        return [self.stones objectAtIndex:index];
    }else if(horizMenu.tag == 31) {
        return [self.prices objectAtIndex:index];
    }else if(horizMenu.tag == 41) {
        return [self.colors objectAtIndex:index];
    }
    return @"";
}

#pragma mark -
#pragma mark HorizMenu Delegate
-(void) horizMenu:(MKHorizMenu *)horizMenu itemSelectedAtIndex:(NSUInteger)index
{
    if (horizMenu.tag == 11) {
//        self.selectionItemLabel.text = [self.items objectAtIndex:index];
    }else if(horizMenu.tag == 21) {
//        self.selectionItemLabel.text = [self.stones objectAtIndex:index];
    }else if(horizMenu.tag == 31) {
//        self.selectionItemLabel.text = [self.prices objectAtIndex:index];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.model.diamondList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    JEDiamondListItem *diamondItem = FEObjectAtIndex(self.model.diamondList,indexPath.row);
    JEDiamondListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [JEDiamondListCell diamondListCellCell];
    }
    
    cell.shopNameLabel.text = diamondItem.shopName;
    cell.certificateLabel.text     = diamondItem.certificationID;
    cell.stoneWeightLabel.text = diamondItem.weight;
    cell.cleanlinessLabel.text = diamondItem.neatness;
    cell.colorLabel.text    = diamondItem.color;
    cell.priceLabel.text       = diamondItem.price;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JEDiamondListCell height];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
