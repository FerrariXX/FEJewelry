//
//  FELogInViewController.m
//  xxx
//
//  Copyright (c) 2014 XXXXX. All rights reserved.
//

#import "FELogInViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FERegisterViewController.h"
#import "FEToastView.h"
#import "FEMacroDefine.h"


#define kSeprateSpace	10
#define kCellHiehgt		50
#define kFontSize		22
#define kCheckBoxWith	27
enum
{
	kAccountTextField,
	kPassWordTextField,
	kLogInButton,
}PKLogInCell;

@interface FELogInViewController ()
{
	NSArray*		cellArr_;
	UITextField*	accountTextField_;
	UITextField*	passWordTextField_;
	UIButton*		logInButton_;
	UIImage*		normalImage_;
	UIImage*		selectedImage_;
}


@property(nonatomic,retain)NSArray* cellArr;
- (void)layoutAllSubViews;
- (void)logInButtonPressed:(id)sender;
- (void)registerAccount;

- (void)logIn;
@end

@implementation FELogInViewController
@synthesize cellArr = cellArr_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
	{
		accountTextField_	= [[UITextField alloc] initWithFrame:CGRectZero];
		passWordTextField_	= [[UITextField alloc] initWithFrame:CGRectZero];
		accountTextField_.placeholder   = NSLocalizedString(@"kAccountTextFieldPlaceHolder", nil);
		passWordTextField_.placeholder  = NSLocalizedString(@"kPasswordTextFieldPlaceHolder", nil);
		accountTextField_.contentVerticalAlignment   = UIControlContentVerticalAlignmentCenter;
		passWordTextField_.contentVerticalAlignment  = UIControlContentVerticalAlignmentCenter;
		accountTextField_.borderStyle   = UITextBorderStyleRoundedRect;
		passWordTextField_.borderStyle  = UITextBorderStyleRoundedRect;
		accountTextField_.font   = [UIFont systemFontOfSize:kFontSize];
		passWordTextField_.font  = [UIFont systemFontOfSize:kFontSize];
		//accountTextField_.keyboardType = UIKeyboardTypeNumberPad;
		passWordTextField_.keyboardType = UIKeyboardTypeASCIICapable;
		passWordTextField_.secureTextEntry = YES;
		
		logInButton_  = [UIButton buttonWithType:UIButtonTypeCustom];
		UIImage* norImage = [UIImage imageNamed:@"login_button_normal.png"];
		norImage = [norImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		UIImage* highLightImage = [UIImage imageNamed:@"login_button_pressed.png"];
		highLightImage = [highLightImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		normalImage_   = [UIImage imageNamed:@"ico_checkbox.png"];
		selectedImage_ = [UIImage imageNamed:@"ico_choose.png"];
		[logInButton_ setBackgroundImage:norImage   forState:UIControlStateNormal];
		[logInButton_ setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
		[logInButton_  setTitle:NSLocalizedString(@"kOK", nil) forState:UIControlStateNormal];

		[logInButton_  addTarget:self action:@selector(logInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
	}
	return self;
}

- (void)dealloc
{

}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = NO;
	self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:39.0/255 green:160.0/255 blue:218.0/255 alpha:1.0];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = NSLocalizedString(@"kUserLogin", nil);
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//do not work when group style
	self.tableView.separatorColor = [UIColor clearColor];
	self.view.backgroundColor = [UIColor whiteColor];//kBackgroundColor;
	self.cellArr = [NSArray arrayWithObjects:
					[NSNumber numberWithInteger:kAccountTextField],
					[NSNumber numberWithInteger:kPassWordTextField],
					[NSNumber numberWithInteger:kLogInButton],nil];
	UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
	self.tableView.backgroundView = view;
    //self.tableView.backgroundColor = [UIColor lightGrayColor];
	UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"注册账号" style:UIBarButtonItemStyleBordered target:self action:@selector(registerAccount)];
	self.navigationItem.rightBarButtonItem = rightButton;
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [cellArr_ count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSArray* tmpCellIdentifier = [NSArray arrayWithObjects:@"account",@"password",@"authorize",@"protocol",@"register", nil];
	UITableViewCell *cell = nil;	
	NSString* identifier = [tmpCellIdentifier objectAtIndex:indexPath.row];
	cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
	if (cell==nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	}
	switch (indexPath.row) 
	{
		case kAccountTextField:
			[cell.contentView   addSubview:accountTextField_];
			[accountTextField_	setFrame:CGRectMake(20,kSeprateSpace/2,280, kCellHiehgt-kSeprateSpace)];
			break;
		case kPassWordTextField:
			[cell.contentView addSubview:passWordTextField_];
			[passWordTextField_	setFrame:CGRectMake(20,kSeprateSpace/2,280, kCellHiehgt-kSeprateSpace)];
			passWordTextField_.secureTextEntry = YES;
			break;
        case kLogInButton:
			[cell.contentView addSubview:logInButton_];
			[logInButton_ setFrame:CGRectMake(20,kSeprateSpace/2,280, kCellHiehgt-kSeprateSpace)];
			break;
        default:
			break;
	}
	cell.backgroundColor = [UIColor clearColor];
	cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return kCellHiehgt;
}

#pragma mark UIButton Action Event
- (void)logInButtonPressed:(id)sender
{
	[self logIn];
}


- (void)registerAccount
{
	[accountTextField_  resignFirstResponder];
	[passWordTextField_	resignFirstResponder];
	FERegisterViewController* registerViewController = [[FERegisterViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:registerViewController animated:YES];
}


#pragma mark - Private Method

- (void)layoutAllSubViews
{
	[accountTextField_ setFrame:CGRectMake(2*kSeprateSpace, 2*kSeprateSpace, 320-4*kSeprateSpace, kCellHiehgt)];
	[passWordTextField_ setFrame:CGRectMake(2*kSeprateSpace, 2*kSeprateSpace+kCellHiehgt, 320-4*kSeprateSpace, kCellHiehgt)];
	[logInButton_      setFrame:CGRectMake(2*kSeprateSpace, 2*kSeprateSpace+3*kCellHiehgt, 320-4*kSeprateSpace, kCellHiehgt)];
}


- (void)logIn
{
	NSString* userNameStr = accountTextField_.text;
	NSString* passwordStr = passWordTextField_.text;
	[accountTextField_	resignFirstResponder];
	[passWordTextField_ resignFirstResponder];
	userNameStr = [userNameStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] ;
	
    if (userNameStr==nil || [userNameStr length]==0)
	{
		FEALERTVIEW(nil, NSLocalizedString(@"kAccountCannotEmpty", nil), nil,NSLocalizedString(@"kOK", nil) ,nil,nil);
        return;
	} 
	else if (passwordStr==nil || [passwordStr length]==0) 
	{
		FEALERTVIEW(nil, NSLocalizedString(@"kPassWordCannotEmpty", nil), nil,NSLocalizedString(@"kOK", nil) ,nil,nil);
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    [[FEAccountManager shareInstance] logInWithAccount:userNameStr password:passwordStr completionBlock:^(BOOL isSuccess, id info) {
        if (!isSuccess) {
            FEALERTVIEW(@"登录出错", nil , nil,NSLocalizedString(@"kOK", nil) ,nil,nil);
        }
        if (weakSelf.completionBlock) {
            weakSelf.completionBlock(isSuccess,info);
        }
    }];
}

@end
