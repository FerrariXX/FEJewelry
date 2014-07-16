//
//  JEThirdTabbarVC.m
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEThirdTabbarVC.h"
#import "JEDiamondListCell.h"
#import "JEWebViewController.h"

@interface JEThirdTabbarVC ()
@property (nonatomic, strong) NSMutableArray *neatness;
@property (nonatomic, strong) NSMutableArray *colors;
@property (nonatomic, strong) NSMutableArray *stones;
@property (nonatomic, strong) NSMutableArray *prices;
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) NSString       *neatnessStr;
@property (nonatomic, strong) NSString       *stonesStr;
@property (nonatomic, strong) NSString       *colorStr;
@property (nonatomic, strong) NSString       *priceStr;
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
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"裸钻";
    _pageNumber = 1;
    _model = [[JEDiamondModel alloc] init];
    // Do any additional setup after loading the view from its nib.
    _neatness = [NSMutableArray arrayWithObjects:@"全部",@"FL",@"IF",@"VVS1",@"VVS2",@"VS1",@"VS2",@"SI1",@"SI2", nil];
    _colors = [NSMutableArray arrayWithObjects:@"全部",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K", nil];
    _stones = [NSMutableArray arrayWithObjects:@"全部",@"0.3-0.4ct",@"0.4-0.5ct",@"0.5-0.6ct",@"0.6-0.8ct",@"0.8-1ct",@"1ct", nil];
    _prices = [NSMutableArray arrayWithObjects:@"全部",@"0~5000",@"5000~8000",@"8000~12000",@"12000~20000",@" 20000~30000",@"30000~50000",@"50000以上",nil];
    
    [_neatnessMenu reloadData];
    [_colorMenu reloadData];
    [_stoneMenu reloadData];
    [_priceMenu reloadData];
    

    if (JE_SYSTEM_VERSION_GREATER_THAN(@"7.0")) {
        _neatnessMenu.frame = CGRectMake(0., 64., 320., 41.);
    }else{
        _neatnessMenu.frame = CGRectMake(0., 0., 320., 41.);
    }
    UIView *lineDashedView0 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_neatnessMenu.frame)+1, 320, 1)];
    lineDashedView0.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line_dashed"]];
    [self.view addSubview:lineDashedView0];
    
    _colorMenu.frame = CGRectMake(0., CGRectGetMaxY(lineDashedView0.frame), 320., 41);
    UIView *lineDashedView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_colorMenu.frame)+1, 320, 1)];
    lineDashedView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line_dashed"]];
    [self.view addSubview:lineDashedView];
    _stoneMenu.frame = CGRectMake(0., CGRectGetMaxY(lineDashedView.frame), 320., 41);
    UIView *lineDashedView1 = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_stoneMenu.frame)+1, 320, 1)];
    lineDashedView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"line_dashed"]];
    [self.view addSubview:lineDashedView1];
    _priceMenu.frame = CGRectMake(0., CGRectGetMaxY(lineDashedView1.frame), 320., 41);
    
    _tableView.frame = CGRectMake(0., CGRectGetMaxY(_priceMenu.frame) + 10, 320., 403);
    _neatnessStr = @"0";
    _stonesStr = @"0";
    _colorStr = @"0";
    _priceStr = @"0";
    
    self.tableView.dataSource = self;
    self.tableView.delegate   = self;
    
    self.tableView.tableHeaderView =  [JEDiamondListCell diamondListCellHeaderView];
//    self.tableView.scrollEnabled   = NO;
    
    
    self.tableView.infiniteScrollingView.backgroundColor = [UIColor orangeColor];
    __weak __typeof(self) weakSelf = self;
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if ([weakSelf.model isHaveMore]) {
            weakSelf.pageNumber++;
            [weakSelf.model loadDiamondList:[NSString stringWithFormat:@"%d",weakSelf.pageNumber] neatness:weakSelf.neatnessStr color:weakSelf.colorStr weightID:weakSelf.stonesStr priceID:weakSelf.priceStr completion:^(BOOL isSuccess) {
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
    [weakSelf.model loadDiamondList:@"1" neatness:weakSelf.neatnessStr color:weakSelf.colorStr weightID:weakSelf.stonesStr priceID:weakSelf.priceStr completion:^(BOOL isSuccess) {
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
        _neatnessStr = [NSString stringWithFormat:@"%d", index];
    }else if(horizMenu.tag == 21) {
         _stonesStr = [NSString stringWithFormat:@"%d", index];
    }else if(horizMenu.tag == 31) {
        _colorStr = [NSString stringWithFormat:@"%d", index];
    }else if(horizMenu.tag == 41) {
        _priceStr = [NSString stringWithFormat:@"%d", index];
    }
    
    [_model.diamondList removeAllObjects];
    __weak __typeof(self) weakSelf = self;
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    [weakSelf.model loadDiamondList:@"1" neatness:_neatnessStr color:_colorStr weightID:_stonesStr priceID:_priceStr completion:^(BOOL isSuccess) {
        [FEToastView dismissWithAnimation:YES];
        if (isSuccess) {
            [weakSelf.tableView reloadData];
        }else {
            TBShowErrorToast;
        }
    }];
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
    JEDiamondListItem *diamondItem = FEObjectAtIndex(self.model.diamondList,indexPath.row);
    if ([diamondItem.detailURL length] >0) {
        JEWebViewController *webVC = [[JEWebViewController alloc] initWithURL:diamondItem.detailURL];
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

@end
