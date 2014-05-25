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

@interface JEDetailVC ()
@property (strong, nonatomic) IBOutlet FEScrollPageView *imagesView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *salePriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *onLineLabel;
@property (strong, nonatomic) IBOutlet UILabel *otherLabel;

@property (strong, nonatomic) IBOutlet UILabel *contactLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet UIButton *modifyButton;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton;
@property (strong, nonatomic) IBOutlet UIButton *dailButton;
@property (strong, nonatomic) IBOutlet UIButton *evaluateButton;

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
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预定" style:UIBarButtonItemStylePlain target:self action:@selector(rightBarButtonPressed:)];
    self.edgesForExtendedLayout = UIRectEdgeBottom;
    [self.imagesView setImageItems:self.model.images selectedBlock:^(FEImageItem *sender) {
        //do nothing here
    } isAutoPlay:YES];
    //self.imagesView.itemWidth = 160.0;

    self.titleLabel.text = self.model.title;
    self.salePriceLabel.text = self.model.price;
    self.stateLabel.text     = self.model.status;
    self.categoryLabel.text  = self.model.category;
    self.idLabel.text     = self.model.idNumber;
    self.onLineLabel.text = self.model.onlineDate;
    self.otherLabel.text  = self.model.other;
    self.contactLabel.text= self.model.contact;
    self.phoneLabel.text  = self.model.phone;
    
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
#pragma mark - Button Event
- (IBAction)dailButtonPressed:(id)sender {
    //[[UIApplication sharedApplication] openURL:<#(NSURL *)#>]
}

- (IBAction)evaluateButtonPressed:(id)sender {
    FEMicroMsgPopoverItem *item1 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_favorite"] title:@"赞" clickedBlock:^(id sender) {
        NSLog(@">>>xxx 1");
    }];
    FEMicroMsgPopoverItem *item2 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_reply"] title:@"评论" clickedBlock:^(id sender) {
        NSLog(@">>>xxx 2");
    }];
    FEMicroMsgPopoverItem *item3 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_retweet"] title:@"收藏" clickedBlock:^(id sender) {
        NSLog(@">>>xxx 3");
    }];
    FEMicroMsgPopoverItem *item4 = [[FEMicroMsgPopoverItem alloc] initWithImage:[UIImage imageNamed:@"icon_favorite"] title:@"分享" clickedBlock:^(id sender) {
        NSLog(@">>>xxx 4");
    }];
    
    FEMicroMsgPopoverView *popoverView = [[FEMicroMsgPopoverView alloc] initWithItems:@[item1, item2, item3, item4]];
    [popoverView showAtPosition:CGPointMake(CGRectGetMinX(((UIButton*)sender).frame), CGRectGetMidY(((UIButton*)sender).frame)+44.0) ];
}

- (void)rightBarButtonPressed:(id)sender{
    
}
@end
