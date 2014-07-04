//
//  FEAccountManager.h
//  xxx
//
//  Copyright (c) 2014 XXXXX. All rights reserved.
//

#import <UIKit/UIKit.h>

//Test2 ,123
typedef void(^JEAuthCompletionBlock)(BOOL isSuccess, id info);

@interface FEAccountManager : NSObject
@property(nonatomic,assign) BOOL        isLogin;
@property(nonatomic,retain) NSString*	account;
@property(nonatomic,retain) NSString*	passWord;

+ (instancetype)shareInstance;
- (void)registerWithAccount:(NSString*)account password:(NSString*)password referral:(NSString*)referral completionBlock:(JEAuthCompletionBlock)block;
- (void)logInWithAccount:(NSString*)account password:(NSString*)password completionBlock:(JEAuthCompletionBlock)block;

@end
