//
//  JEShakeVC.h
//  Jewelry
//
//  Created by wuyj on 14-6-11.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "JEShakeModel.h"

@interface JEShakeVC : UIViewController {
    SystemSoundID soundID;
}
@property (strong, nonatomic) IBOutlet UITextView *lotteryTextView;
@property (nonatomic, strong) IBOutlet UIImageView *shakeImageView;
@property (nonatomic, strong) JEShakeModel      *shakeModel;
@end
