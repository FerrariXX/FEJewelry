//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEDiamondModel.h"
#import "FEScrollPageView.h"

@implementation JEDiamondListItem
- (instancetype)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.shopName     = [dict objectForKey:@"shopName"];
            self.certificationID       = [dict objectForKey:@"certificationID"];
            self.weight         = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"weight"] floatValue]];
            self.neatness     = [dict objectForKey:@"neatness"];
            self.color  =  [dict objectForKey:@"color"];
            self.price     = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"price"] floatValue]];
            self.detailURL        = [dict objectForKey:@"detailURL"];
        }
    }
    return self;
}

@end


@interface JEDiamondModel()
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, strong)NSString  *deviceID;
@end

@implementation JEDiamondModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _diamondList = [[NSMutableArray alloc] initWithCapacity:1];
        _isHaveMore = YES;
    }
    return self;
}

- (void)loadDiamondList:(NSString*)pageNumber neatness:(NSString*)neatness color:(NSString*)color
               weightID:(NSString*)weightID priceID:(NSString*)priceID completion:(JECompletionBlock)block {
    // http://60.191.108.245:33681/brosapiservice.svc/GetDiamonds/{neatness}/{color}/{weightID}/{priceID}/{pageNumber}
//    NSString * deviceID = [self deviceID];
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@GetDiamonds/%@/%@/%@/%@/%@", kBaseURLString,neatness,color,weightID,priceID,pageNumber];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *jsonArray = (NSArray*)JSON;
        if (jsonArray.count == 0) {
            _isHaveMore = NO;
        }else{
            for (NSDictionary * diamondItem  in jsonArray) {
                JEDiamondListItem * listItem = [[JEDiamondListItem alloc] initWithDictionary:diamondItem];
                [weakSelf.diamondList addObject:listItem];
            }
        }
        if (block) {
            block(YES);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (block) {
            block(NO);
        }
    }];
    [operation start];
}

#pragma mark - Private Method

- (NSString*)deviceID{
    if (_deviceID == nil) {
        CFUUIDRef deviceId = CFUUIDCreate (NULL);
        CFStringRef deviceIdStringRef = CFUUIDCreateString(NULL,deviceId);
        CFRelease(deviceId);
        _deviceID = (NSString *)CFBridgingRelease(deviceIdStringRef);
    }
    return _deviceID;
}

- (NSString*)getStringWithObject:(id)object{
    return nil;
}
@end
