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

#define JE_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define JE_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define JE_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define JE_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define JE_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


