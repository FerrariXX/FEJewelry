//
//  FELogInOrRegisterViewController.m
//  xxx
//
//  Copyright (c) 2014 XXXXX. All rights reserved.
//

#import "FELogInOrRegisterViewController.h"
#import "FELogInViewController.h"
#import "FERegisterViewController.h"


@interface FELogInOrRegisterViewController ()
{
	UIImageView* logImageView_;
	UILabel*	 logTextLabel_;
	UIButton*	 registerButton_;
	UIButton*	 logInButton_;
    UIButton*	 cancelButton_;

}
@property(nonatomic, copy)JEAuthCompletionBlock block;
- (void)logInButtonPressed:(id)sender;
- (void)registerButtonPressed:(id)sender;
@end

@implementation FELogInOrRegisterViewController

+ (instancetype)sharedInstance{
    static FELogInOrRegisterViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[FELogInOrRegisterViewController alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isLogin{
    return [[FEAccountManager shareInstance] isLogin];
}

- (void)showLoginVCWithCompletionBlock:(JEAuthCompletionBlock)block{
    FELogInOrRegisterViewController *vc = [[FELogInOrRegisterViewController alloc] init];
    vc.block = block;
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:naviVC animated:YES];
}

- (void)dismissLoginVC{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController]  dismissModalViewControllerAnimated:YES];
}

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
		logImageView_ = [[UIImageView alloc] initWithFrame:CGRectZero];
		logImageView_.image = [UIImage imageNamed:@"login_logo.png"];
		logImageView_.contentMode = UIViewContentModeCenter;
		logTextLabel_ = [[UILabel alloc] initWithFrame:CGRectZero];
		logTextLabel_.text = NSLocalizedString(@"kLogText", nil);
		logTextLabel_.textColor = [UIColor grayColor];
		logTextLabel_.font = [UIFont  fontWithName:@"Helvetica-Oblique"  size:18];
		logTextLabel_.textAlignment = NSTextAlignmentCenter;
		logTextLabel_.backgroundColor = [UIColor clearColor];
		registerButton_ = [UIButton buttonWithType:UIButtonTypeCustom];
		logInButton_    = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton_   = [UIButton buttonWithType:UIButtonTypeCustom];

		UIImage* regNormalImage = [UIImage imageNamed:@"login_button_normal.png"];
		regNormalImage = [regNormalImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		UIImage* regHighLigtImage = [UIImage imageNamed:@"login_button_pressed.png"];
		regHighLigtImage = [regHighLigtImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		UIImage* logInNormalImage = [UIImage imageNamed:@"login_gray_normal.png"];
		logInNormalImage = [logInNormalImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		UIImage* logInHighLigtImage = [UIImage imageNamed:@"login_gray_pressed.png"];
		logInHighLigtImage = [logInHighLigtImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
		[registerButton_ setBackgroundImage:regNormalImage   forState:UIControlStateNormal];
		[registerButton_ setBackgroundImage:regHighLigtImage forState:UIControlStateHighlighted];
		[registerButton_ setTitle:NSLocalizedString(@"kNewUserRegister", nil) forState:UIControlStateNormal];
		[registerButton_ addTarget:self action:@selector(registerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[logInButton_	 setBackgroundImage:logInNormalImage forState:UIControlStateNormal];
		[logInButton_	 setBackgroundImage:logInHighLigtImage forState:UIControlStateHighlighted];
		[logInButton_	 setTitle:NSLocalizedString(@"kUserLogin", nil) forState:UIControlStateNormal];
		[logInButton_	 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[logInButton_	addTarget:self action:@selector(logInButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [cancelButton_	 setBackgroundImage:logInNormalImage forState:UIControlStateNormal];
		[cancelButton_	 setBackgroundImage:logInHighLigtImage forState:UIControlStateHighlighted];
		[cancelButton_	 setTitle:@"取消" forState:UIControlStateNormal];
		[cancelButton_	 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
		[cancelButton_	addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self; 
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = NSLocalizedString(@"kInitViewTitle", nil); 
	self.view.frame = [UIScreen mainScreen].bounds;
	self.view.backgroundColor = [UIColor colorWithRed:214.0/255 green:220.0/255 blue:225.0/255 alpha:1.0];
	[self.view addSubview:logImageView_];
	[self.view addSubview:logTextLabel_];
	[self.view addSubview:registerButton_];
	[self.view addSubview:logInButton_];
    [self.view addSubview:cancelButton_];
	[logImageView_ setFrame:self.view.bounds];
	[logTextLabel_ setFrame:CGRectMake(0, 250, 320, 40)];
	[registerButton_ setFrame:CGRectMake(30, 260, 260, 40)];
	[logInButton_	 setFrame:CGRectMake(30, 320, 260, 40)];
    [cancelButton_   setFrame:CGRectMake(30, 380, 260, 40)];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
	[logImageView_		removeFromSuperview];
	[logTextLabel_		removeFromSuperview];
	[registerButton_	removeFromSuperview];
	[logInButton_		removeFromSuperview];
    [cancelButton_      removeFromSuperview];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark - UIButton Action Event

- (void)logInButtonPressed:(id)sender
{
	FELogInViewController* logInViewController = [[FELogInViewController alloc] initWithStyle:UITableViewStyleGrouped];
    logInViewController.completionBlock = self.block;
	[self.navigationController pushViewController:logInViewController animated:YES];
}

- (void)registerButtonPressed:(id)sender
{
	FERegisterViewController* registerViewController = [[FERegisterViewController alloc] initWithStyle:UITableViewStyleGrouped];
	registerViewController.completionBlock = self.block;
    [self.navigationController pushViewController:registerViewController animated:YES];
}

- (void)cancelButtonPressed:(id)sender{
    [self dismissLoginVC];
    if (self.block) {
        self.block(NO,nil);
    }
}
@end
