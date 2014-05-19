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
- (IBAction)dailButtonPressed:(id)sender;

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

- (void)rightBarButtonPressed:(id)sender{
    
}
@end
