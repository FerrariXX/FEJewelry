//
//  JEConst.h
//
//  Created by xxx on 3/3/12.
//  Copyright 2012 XXXXX. All rights reserved.
//


#define kBaseURLString                  @"http://60.191.108.245:33681/brosapiservice.svc/"

#define kDeviceType						2  //iphone
#define kScreenWith					   ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight				   ([[UIScreen mainScreen] bounds].size.height)
#define kStatusHeight					20

#define kTimeoutInterval                6.0
typedef void(^JECompletionBlock)(BOOL isSuccess);

#define TBShowErrorToast     [FEToastView showWithTitle:@"出错了，请稍后再试。" animation:YES interval:2.0];


