//
//  JEShakeVC.h
//  Jewelry
//
//  Created by wuyj on 14-6-11.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface JEShakeVC : UIViewController {
    SystemSoundID soundID;
}
@property (strong, nonatomic) IBOutlet UIImageView *shakeImageView;
- (IBAction)shakeAction:(id)sender;
@end
