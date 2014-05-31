//
//  PKConst.h
//  Pumpkin
//
//  Created by xxx on 3/3/12.
//  Copyright 2012 XXXXX. All rights reserved.
//


#define kDeviceType						2  //iphone
#define kScreenWith					   ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight				   ([[UIScreen mainScreen] bounds].size.height)
#define kStatusHeight					20


#define TBHD_SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define TBHD_SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define TBHD_SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define TBHD_SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define TBHD_SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)