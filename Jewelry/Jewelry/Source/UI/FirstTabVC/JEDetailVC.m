//
//  JEDetailVC.m
//  Jewelry
//
//  Created by xxx on 14-5-4.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEDetailVC.h"
#import "FEScrollPageView.h"
#import "JEDetailModel.h"
#import "FEMicroMsgPopoverView.h"
#import "JEDetailVCListTableViewCell.h"

@interface JEDetailVC () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet FEScrollPageView *imagesView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *salePriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalWeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *masterWeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *slaveLabel;
@property (strong, nonatomic) IBOutlet UILabel *zanLabel;

@property (strong, nonatomic) IBOutlet UILabel *contactLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UIButton *dailButton;
@property (strong, nonatomic) IBOutlet UIButton *evaluateButton;
@property (strong, nonatomic) IBOutlet UIScrollView *contentScrollView;
@property (strong, nonatomic) IBOutlet UITableView *detailTableView;


- (IBAction)dailButtonPressed:(id)sender;
- (IBAction)evaluateButtonPressed:(id)sender;

@end

@implementation JEDetailVC

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
    // Do any additional setup after loading the view from its nib.
    self.title = @"商品详情";
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    
    self.detailTableView.dataSource = self;
    self.detailTableView.delegate   = self;
    
    self.detailTableView.tableHeaderView =  [JEDetailVCListTableViewCell detailVCListTableViewCellHeaderView];
    self.contentScrollView.scrollEnabled = YES;
    self.detailTableView.scrollEnabled   = NO;
    //self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [FEToastView showWithTitle:@"正在加载中..." animation:YES];
    __weak  JEDetailVC *weakSelf = self;
    [self.model loadWithID:self.model.idNumber goodID:self.model.goodID completion:^(BOOL isSuccess) {
        [FEToastView dismissWithAnimation:YES];
        if (isSuccess) {
            [weakSelf updateDetailData];
        }else {
            TBShowErrorToast;
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.imagesView stopAutoPlay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Method

- (void)updateDetailData{
    [self.imagesView setImageItems:self.model.images selectedBlock:^(FEImageItem *sender) {
        //do nothing here
    } isAutoPlay:YES];
    //self.imagesView.itemWidth = 160.0;
    
    self.titleLabel.text = self.model.title;
    self.salePriceLabel.text = self.model.price;
    self.categoryLabel.text  = self.model.category;
    self.idLabel.text     = self.model.idNumber;
    self.totalWeightLabel.text     = self.model.totalWeight;
    self.masterWeightLabel.text = self.model.masterWeight;
    self.slaveLabel.text  = self.model.slaveWeight;
    self.contactLabel.text= self.model.address;
    self.phoneLabel.text  = self.model.phone;
    
    [self layoutSubViews];
    
    [self.detailTableView reloadData];
}

- (void)layoutSubViews{
   CGFloat tableViewHeight = self.detailTableView.tableHeaderView.frame.size.height + [JEDetailVCListTableViewCell height] * [self.model.detailListArray count];
    CGRect rect = self.detailTableView.frame;
    rect.size.height = tableViewHeight;
    [self.detailTableView setFrame:rect];
    self.contentScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 440 + tableViewHeight);
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
    return [self.model.detailListArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    JEDetailListItem *item = FEObjectAtIndex(self.model.detailListArray,indexPath.row);
    JEDetailVCListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil){
        cell = [JEDetailVCListTableViewCell detailVCListTableViewCell];
    }
    cell.numberIDLabel.text = item.numberID;
    cell.sizeLabel.text     = item.size;
    cell.materialLabel.text = item.material;
    cell.totalWeightLabel.text = item.totalWeight;
    cell.CTWeightLabel.text    = item.CTWeight;
    cell.priceLabel.text       = item.price;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [JEDetailVCListTableViewCell height];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    JEDetailListItem *item =  FEObjectAtIndex(self.model.detailListArray, indexPath.row);
    [self.model loadWithID:item.numberID goodID:item.goodID completion:^(BOOL isSuccess) {
        
    }];
}


#pragma mark - Button Event
- (IBAction)dailButtonPressed:(id)sender {
    if ([self.phoneLabel.text length] >0) {
        NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",self.phoneLabel.text];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    }
}

- (IBAction)evaluateButtonPressed:(id)sender {
    __weak __typeof(self) weakSelf = self;
    FEMicroMsgPopoverItem *item1 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_favorite"] title:@"赞" clickedBlock:^(id sender) {
        [weakSelf.model praiseWithNumberID:weakSelf.model.idNumber];
    }];
//    FEMicroMsgPopoverItem *item2 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_reply"] title:@"评论" clickedBlock:^(id sender) {
//        NSLog(@">>>xxx 2");
//    }];
    FEMicroMsgPopoverItem *item3 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_retweet"] title:@"收藏" clickedBlock:^(id sender) {
        [weakSelf.model favoriteWithUserID:@"" numberID:weakSelf.model.idNumber];
    }];
    FEMicroMsgPopoverItem *item4 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_favorite"] title:@"分享" clickedBlock:^(id sender) {
        NSLog(@">>>xxx 4");
    }];
    
    FEMicroMsgPopoverView *popoverView = [[FEMicroMsgPopoverView alloc] initWithItems:@[item1, item3, item4]];
    [popoverView showAtPosition:CGPointMake(CGRectGetMinX(((UIButton*)sender).frame), -self.contentScrollView.contentOffset.y + CGRectGetMidY(((UIButton*)sender).frame)+44.0) ];
}




@end
