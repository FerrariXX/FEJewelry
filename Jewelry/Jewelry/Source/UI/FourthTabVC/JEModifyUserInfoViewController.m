//
//  JEModifyUserInfoViewController.m
//  Jewelry
//
//  Created by wuyj on 14-7-1.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEModifyUserInfoViewController.h"
#import "JEUserInfoModifyModel.h"

@interface JEModifyUserInfoViewController ()
@property (nonatomic, strong)UITextField     *textField;
@end

@implementation JEModifyUserInfoViewController

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
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _modifyModel = [[JEUserInfoModifyModel alloc] init];
    
    if (_type == 1) {
        self.titleLable.text = @"修改昵称";
    }else {
        self.titleLable.text = @"修改微信号";
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //返回（向系统发送）分区个数,在这里有多少键就会有多少分区。
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"modifyFieldCell";
    
    UITableViewCell *filedCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (filedCell == nil) {
        filedCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
    _textField.delegate = self;
    _textField.text = _modifyText;
    _textField.borderStyle =  UITextBorderStyleNone;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _textField.returnKeyType = UIReturnKeyDone;
    [filedCell.contentView addSubview:_textField];
    return filedCell;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self updateAction:nil];
    return YES;
}

//- (void)textFieldDidEndEditing:(UITextField *)textField {
//    _modifyText = textField.text;
//}

- (IBAction)backAction:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)updateAction:(id)sender {
    __weak __typeof(self) weakSelf = self;
    if (_type == 1) {
        [_modifyModel updateNikeName:weakSelf.textField.text completion:^(BOOL isSuccess) {
            if (isSuccess) {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:weakSelf.modifyModel.userInfoItem forKey:@"userInfoItem"];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfoNoti" object:nil userInfo:userInfo];
                
                [weakSelf dismissModalViewControllerAnimated:YES];
            }
        }];
    }else if(_type == 2){
        [_modifyModel updateMicroMessageID:weakSelf.textField.text completion:^(BOOL isSuccess) {
            if (isSuccess) {
                NSDictionary *userInfo = [NSDictionary dictionaryWithObject:weakSelf.modifyModel.userInfoItem forKey:@"userInfoItem"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUserInfoNoti" object:nil userInfo:userInfo];
                [weakSelf dismissModalViewControllerAnimated:YES];
            }
        }];
    }
}
@end
