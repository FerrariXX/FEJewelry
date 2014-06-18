//
//  JEThirdTabbarVC.h
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"
#import "JEDiamondModel.h"

typedef NS_OPTIONS (NSUInteger, JEDiamondSearchNeatness) {
    JEDiamondSearchNeatnessFL = 1,
    JEDiamondSearchNeatnessIF = 2,
    JEDiamondSearchNeatnessVVS1 = 3,
    JEDiamondSearchNeatnessVVS2 = 4,
    JEDiamondSearchNeatnessVS1 = 5,
    JEDiamondSearchNeatnessVS2 = 6,
    JEDiamondSearchNeatnessSI1 = 7,
    JEDiamondSearchNeatnessSI2 = 8
};

typedef NS_OPTIONS (NSUInteger, JEDiamondSearchColor) {
    JEDiamondSearchColorD = 1,
    JEDiamondSearchColorE = 2,
    JEDiamondSearchColorF = 3,
    JEDiamondSearchColorH = 4,
    JEDiamondSearchColorG = 5,
    JEDiamondSearchColorI = 6,
    JEDiamondSearchColorJ = 7,
    JEDiamondSearchColorK = 8
};


@interface JEThirdTabbarVC : UIViewController <MKHorizMenuDataSource, MKHorizMenuDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) JEDiamondModel *model;
@property (strong, nonatomic) IBOutlet MKHorizMenu *priceMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *stoneMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *searchFieldMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *colorMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *neatnessMenu;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
