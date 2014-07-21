//
//  FERegisterViewController.m
//  xxx
//
//  Copyright (c) 2014 XXXXX. All rights reserved.
//

#import "FERegisterViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "FEToastView.h"


#define kSeprateSpace	10
#define kCellHiehgt		50
#define kFontSize		22
#define kCheckBoxWith	27


#define kBackgroundColor		[UIColor colorWithRed:214.0/255 green:220.0/255 blue:225.0/255 alpha:1.0]
#define kNaviCtlColor			[UIColor colorWithRed:39.0/255 green:160.0/255 blue:218.0/255 alpha:1.0]

enum
{
	kAccountTextField,
	kPassWordTextField,
	kAuthorizedTextField,
	kRegisterNowButton,
}PKRegisterCell;

@interface FERegisterViewController ()
{
	NSArray*		cellArr_;
	UIImageView*	backgroundView_;
	UITextField*	accountTextField_;
	UITextField*	passWordTextField_;
	UITextField*    authorizeTextField_;
	UIButton*		registerNowButton_;
	UIImage*		normalImage_;
	UIImage*		selectedImage_;
	BOOL			isConfirmProtocol_;
	
	UIAlertView*		alertView_;
}
@property(nonatomic,retain)NSArray* cellArr;
- (void)registerNowButtonPressed:(id)sender;

@end

@implementation FERegisterViewController
@synthesize cellArr = cellArr_;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) 
	{
		backgroundView_ = [[UIImageView alloc] initWithFrame:CGRectZero];
		backgroundView_.layer.cornerRadius = 6.0;
		backgroundView_.layer.masksToBounds = YES;
		backgroundView_.backgroundColor = [UIColor lightGrayColor];
		accountTextField_	= [[UITextField alloc] initWithFrame:CGRectZero];
		passWordTextField_	= [[UITextField alloc] initWithFrame:CGRectZero];
		authorizeTextField_ = [[UITextField alloc] initWithFrame:CGRectZero];
		accountTextField_.placeholder   = NSLocalizedString(@"kAccountTextFieldPlaceHolder", nil);
		passWordTextField_.placeholder  = NSLocalizedString(@"kPasswordTextFieldPlaceHolder", nil);
		authorizeTextField_.placeholder = NSLocalizedString(@"kAuthorizedTextFieldPlaceHolder", nil);
		accountTextField_.contentVerticalAlignment   = UIControlContentVerticalAlignmentCenter;
		passWordTextField_.contentVerticalAlignment  = UIControlContentVerticalAlignmentCenter;
		authorizeTextField_.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		accountTextField_.borderStyle   = UITextBorderStyleRoundedRect;
		passWordTextField_.borderStyle  = UITextBorderStyleRoundedRect;
		authorizeTextField_.borderStyle = UITextBorderStyleRoundedRect;
		accountTextField_.font   = [UIFont systemFontOfSize:kFontSize];
		passWordTextField_.font  = [UIFont systemFontOfSize:kFontSize];
		authorizeTextField_.font = [UIFont systemFontOfSize:kFontSize];
		//accountTextField_.keyboardType  = UIKeyboardTypeNumberPad;
		passWordTextField_.keyboardType = UIKeyboardTypeASCIICapable;
		//authorizeTextField_.keyboardType= UIKeyboardTypeNumberPad;
		[passWordTextField_ setSecureTextEntry:YES];
	
		registerNowButton_   = [UIButton buttonWithType:UIButtonTypeCustom];
	
		UIImage* norImage = [UIImage imageNamed:@"login_button_normal.png"];
		norImage = [norImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		UIImage* highLightImage = [UIImage imageNamed:@"login_button_pressed.png"];
		highLightImage = [highLightImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		normalImage_   = [UIImage imageNamed:@"ico_checkbox.png"];
		selectedImage_ = [UIImage imageNamed:@"ico_choose.png"];
        //[registerNowButton_  setBackgroundImage:norImage   forState:UIControlStateNormal];
		//[registerNowButton_  setBackgroundImage:highLightImage forState:UIControlStateHighlighted];
		registerNowButton_.backgroundColor = [UIColor colorWithRed:41/255.0f green:112/255.0f blue:222/255.0f alpha:1.0];
        [registerNowButton_  setTitle:NSLocalizedString(@"kRegisterNow", nil) forState:UIControlStateNormal];
				
		[registerNowButton_ addTarget:self action:@selector(registerNowButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
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
	//self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:39.0/255 green:160.0/255 blue:218.0/255 alpha:1.0];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;//do not work when group style
	self.tableView.separatorColor = [UIColor clearColor];
	self.title = NSLocalizedString(@"kNewUserRegister", nil);
	self.view.backgroundColor = [UIColor whiteColor];//kBackgroundColor;
	self.cellArr = [NSArray arrayWithObjects:
				[NSNumber numberWithInteger:kAccountTextField],
				[NSNumber numberWithInteger:kPassWordTextField],
				[NSNumber numberWithInteger:kAuthorizedTextField],
				[NSNumber numberWithInteger:kRegisterNowButton],nil];
	UIView* view = [[UIView alloc] initWithFrame:CGRectZero];
	self.tableView.backgroundView = view;
	//[self.tableView.backgroundView addSubview:backgroundView_];
	//[backgroundView_ setFrame:CGRectMake(kSeprateSpace,kSeprateSpace, 300, 380)];
	isConfirmProtocol_ = YES;
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
	NSArray* tmpCellIdentifier = [NSArray arrayWithObjects:@"account",@"password",@"authorize",@"register", nil];
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
			break;
		case kAuthorizedTextField:
			[cell.contentView addSubview:authorizeTextField_];
			[authorizeTextField_	setFrame:CGRectMake(20,kSeprateSpace/2,280,kCellHiehgt-kSeprateSpace)];
			break;
		case kRegisterNowButton:
			[cell.contentView addSubview:registerNowButton_];
			[registerNowButton_	setFrame:CGRectMake(20,kSeprateSpace/2,280, kCellHiehgt-kSeprateSpace)];
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


#pragma mark - UIButton Action Event

- (void)registerNowButtonPressed:(id)sender
{
	NSString* userNameStr = accountTextField_.text;
	NSString* passwordStr = passWordTextField_.text;
	NSString* authCode    = authorizeTextField_.text;
	[accountTextField_		resignFirstResponder];
	[passWordTextField_		resignFirstResponder];
	[authorizeTextField_	resignFirstResponder];
	userNameStr = [userNameStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] ;
    
    if (userNameStr==nil || [userNameStr length]==0)
	{
		FEALERTVIEW(nil, NSLocalizedString(@"kAccountCannotEmpty", nil) , nil,NSLocalizedString(@"kOK", nil) ,nil,nil);
        return;
    }
	else if (passwordStr==nil || [passwordStr length]==0) 
	{
		FEALERTVIEW(nil, NSLocalizedString(@"kPassWordCannotEmpty", nil) , nil,NSLocalizedString(@"kOK", nil) ,nil,nil);
        return;
    }
//	else if (authCode==nil || [authCode length]==0) 
//	{
//		FEALERTVIEW(nil, NSLocalizedString(@"kAuthCodeError", nil) , nil,NSLocalizedString(@"kOK", nil) ,nil,nil);
//        return;
//	}

    
    __weak __typeof(self) weakSelf = self;
    [[FEAccountManager shareInstance] registerWithAccount:userNameStr password:passwordStr referral:authCode completionBlock:^(BOOL isSuccess, id info) {
        if (!isSuccess) {
            FEALERTVIEW(@"注册出错", info , nil,NSLocalizedString(@"kOK", nil) ,nil,nil);
        } else {
            [FEToastView showWithTitle:@"  注册成功  " animation:YES interval:1.0];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popToRootViewControllerAnimated:NO];
                [[[[UIApplication sharedApplication] keyWindow] rootViewController]  dismissModalViewControllerAnimated:YES];
            
            });
          }
        if (weakSelf.completionBlock) {
            weakSelf.completionBlock(isSuccess,info);
        }
    }];

}


@end
