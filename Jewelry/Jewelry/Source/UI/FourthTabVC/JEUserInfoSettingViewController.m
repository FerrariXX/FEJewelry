//
//  JFUserInfoSettingViewController.m
//  Jewelry
//
//  Created by wuyj on 14-5-30.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEUserInfoSettingViewController.h"
#import "JEUserInfoUpgradeCell.h"
#import "JEModifyUserInfoViewController.h"
#import "JEUserInfoModifyModel.h"

static NSString *localCacheFolder;

@interface JEUserInfoSettingViewController ()
@property (nonatomic, strong)JEUserInfoUpgradeCell *userInfoCell;
@property (nonatomic, strong)JEUserInfoModifyModel *modifyModel;
@end

@implementation JEUserInfoSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)updateUserInfo:(NSNotification*)notification {
    if (notification.userInfo) {
        _userModel.userInfo = [notification.userInfo objectForKey:@"userInfoItem"];
        [_tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _modifyModel = [[JEUserInfoModifyModel alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateUserInfo:) name:@"refreshUserInfoNoti" object:nil];
    // Do any additional setup after loading the view from its nib.
    self.title = @"个人信息";
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView reloadData];
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     static NSString *upgradeCellIdentifier = @"userInfoUpgradeCell";
    if (indexPath.section == 0 && indexPath.row==0) {
        _userInfoCell = [tableView dequeueReusableCellWithIdentifier:upgradeCellIdentifier];
        if (_userInfoCell == nil) {
            _userInfoCell = [JEUserInfoUpgradeCell userInfoUpgradeCell];
            _userInfoCell.textLabel.textColor = [UIColor blackColor];
        }
        [_userInfoCell refreshCell:_userModel.userInfo.avatarURL];
        return _userInfoCell;
    }
    
    static NSString *CellIdentifier = @"userInfoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor blackColor];
    }else{
        [[cell.contentView viewWithTag:1] removeFromSuperview];
        [[cell.contentView viewWithTag:2] removeFromSuperview];
        [[cell.contentView viewWithTag:3] removeFromSuperview];
    }
    
    NSUInteger section = (NSUInteger) [indexPath section];
    NSUInteger row = (NSUInteger) [indexPath row];
    UILabel *rightLable = [[UILabel alloc] init]; //定义一个在cell最右边显示的label
    rightLable.font = [UIFont boldSystemFontOfSize:14];
    [rightLable sizeToFit];
    rightLable.backgroundColor = [UIColor clearColor];
    NSString *cellText;
    if (section == 0) {
        if(row == 1){
            cellText = @"昵称";
            rightLable.text = _userModel.userInfo.nickName;
            rightLable.tag = 1;
        }else if(row == 2){
            cellText = @"我的账号";
            rightLable.text = _userModel.userInfo.userID;
            rightLable.tag = 2;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else if(row == 3){
            cellText = @"我的微信号";
            rightLable.tag = 3;
            rightLable.text = _userModel.userInfo.microMessageID;
        }
    }
    if (rightLable.text) {
        CGSize titleSize = [rightLable.text sizeWithFont:rightLable.font];
        rightLable.frame = CGRectMake(kScreenWith - 29 - titleSize.width, 7, titleSize.width, 30);
        [cell.contentView addSubview:rightLable];
    }
    cell.textLabel.text = cellText;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 15;
    }
    return 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && [indexPath row] == 0) {
        return 80;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self chooseImage];
    }else{
        JEModifyUserInfoViewController *modifyVC = [JEModifyUserInfoViewController alloc];
        if (indexPath.row == 1) {
            modifyVC.type = 1;
            modifyVC.modifyText = _userModel.userInfo.nickName;
        }else{
            modifyVC.type = 2;
            modifyVC.modifyText = _userModel.userInfo.microMessageID;
        }
        [self presentViewController:modifyVC animated:YES completion:^{
        }];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)chooseImage {
    
    UIActionSheet *sheet;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    }
    else {
        
        sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    }
    
    sheet.tag = 255;
    
    [sheet showInView:self.view];
    
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval = [date timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", timeInterval];//转为字符型
    NSString *imgName = [timeString stringByAppendingString:@".jpg"];
    [self saveImage:image withName:imgName];
//
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imgName];
    [_modifyModel updateAvatarURL:fullPath completion:^(BOOL isSuccess) {
        
    }];
//
//    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    
//    isFullScreen = NO;
//    [self.imageView setImage:savedImage];
//    
//    self.imageView.tag = 100;
    
      
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                    
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];

    }
}

//+ (NSString *)localCacheFolder
//{
//    if(localCacheFolder==nil)
//    {
//        NSString *TempDirectory = NSTemporaryDirectory();
//        TempDirectory = [TempDirectory stringByAppendingString:@"/temp_images"];
//        
//        if(![[NSFileManager defaultManager]fileExistsAtPath:TempDirectory])
//        {
//            BOOL r = [[NSFileManager defaultManager]createDirectoryAtPath:TempDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//            if(r==NO)
//            {
//                NSLog(@"创建图片临时存放目录失败: %@", TempDirectory);
//            }
//        }
//        localCacheFolder = TempDirectory;
//    }
//    return localCacheFolder;
//}
//
//+ (void)clearLocalImages
//{
//    NSArray *files = [[NSFileManager defaultManager]contentsOfDirectoryAtPath:[self localCacheFolder] error:nil];
//    for(NSString *fileName in files){
//        NSString  *path = [[JEUserInfoSettingViewController localCacheFolder] stringByAppendingPathComponent:fileName];
//        [[NSFileManager defaultManager]removeItemAtPath:path error:nil];
//    }
//}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshUserInfoNoti" object:nil];
//    [JEUserInfoSettingViewController clearLocalImages];
}

@end
