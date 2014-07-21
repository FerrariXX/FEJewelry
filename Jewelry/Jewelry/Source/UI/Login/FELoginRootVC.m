//
//  FELoginRootVC.m
//  Jewelry
//
//  Created by admin on 14-7-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "FELoginRootVC.h"
#import "FERegisterViewController.h"

@interface FELoginRootVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property(nonatomic, copy)JEAuthCompletionBlock completionBlock;

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)registerButtonPressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;

@end

@implementation FELoginRootVC


#pragma mark - Public 

+ (BOOL)isLogin{
    return [[FEAccountManager shareInstance] isLogin];
}

+ (void)showLoginVCWithCompletionBlock:(JEAuthCompletionBlock)block{
    FELoginRootVC *vc = [[FELoginRootVC alloc] init];
    vc.completionBlock = block;
    vc.modalPresentationStyle = UIModalPresentationCurrentContext;
    
    UINavigationController *naviVC = [[UINavigationController alloc] initWithRootViewController:vc];
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentModalViewController:naviVC animated:YES];
}

+ (void)dismissLoginVC{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController]  dismissModalViewControllerAnimated:YES];
}

#pragma mark -
//////////////////////////////////////////////////////////
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
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    
    self.view.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    // Do any additional setup after loading the view from its nib.
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(leftBarButtonPressed:)];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftBarButtonPressed:(id)sender{
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)loginButtonPressed:(id)sender {
    NSString* userNameStr = self.accountTextField.text;
	NSString* passwordStr = self.passWordTextField.text;
	[self.accountTextField	resignFirstResponder];
	[self.passWordTextField resignFirstResponder];
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

- (IBAction)registerButtonPressed:(id)sender {
    [self.accountTextField  resignFirstResponder];
	[self.passWordTextField	resignFirstResponder];
	FERegisterViewController* registerViewController = [[FERegisterViewController alloc] initWithStyle:UITableViewStyleGrouped];
	[self.navigationController pushViewController:registerViewController animated:YES];
}

- (IBAction)cancelPressed:(id)sender {
    [self leftBarButtonPressed:nil];
}
@end
