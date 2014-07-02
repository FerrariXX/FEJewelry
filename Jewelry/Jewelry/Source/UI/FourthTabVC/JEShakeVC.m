//
//  JEShakeVC.m
//  Jewelry
//
//  Created by wuyj on 14-6-11.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEShakeVC.h"
#import <QuartzCore/QuartzCore.h>

@interface JEShakeVC ()
@end

@implementation JEShakeVC

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
    self.title = @"摇一摇";
    // Do any additional setup after loading the view from its nib.
    NSString *path = [[NSBundle mainBundle] pathForResource:@"shake" ofType:@"wav"];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundID);
    
    _shakeModel = [[JEShakeModel alloc] init];

}

-(void)addAnimations
{
    CABasicAnimation *translation = [CABasicAnimation animationWithKeyPath:@"transform"];
    translation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    translation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(-M_PI_4, 0, 0, 100)];
    
    
    
    translation.duration = 0.2;
    translation.repeatCount = 2;
    translation.autoreverses = YES;
    
    [_shakeImageView.layer addAnimation:translation forKey:@"translation"];
    
    [self performSelector:@selector(shakeOffRequest) withObject:nil afterDelay:2.0];
}


- (void)shakeOffRequest {
     __weak __typeof(self) weakSelf = self;
    [_shakeModel shakeOffAction:@"0001" completion:^(BOOL isSuccess) {
        if (isSuccess) {
            [FEToastView showWithTitle:weakSelf.shakeModel.shakeItem.isLottery animation:YES interval:3.];
            if ([weakSelf.shakeModel.shakeItem.isLottery isEqualToString:@"中奖"] &&
                weakSelf.shakeModel.shakeItem.lotteryMessage) {
                [weakSelf.lotteryTextView setHidden:NO];
                [weakSelf.lotteryTextView setText:_shakeModel.shakeItem.lotteryMessage];
            }else{
                 [weakSelf.lotteryTextView setHidden:YES];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}

-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if(motion==UIEventSubtypeMotionShake)
    {
        [self addAnimations];
        AudioServicesPlaySystemSound (soundID);
        
    }
    
}

- (IBAction)shakeAction:(id)sender {
    [self addAnimations];
    AudioServicesPlaySystemSound (soundID);
}
@end
