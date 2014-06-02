//
//  JEJewelryCircleTableViewCell.h
//  Jewelry
//
//  Created by xxx on 14-5-24.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FEScrollPageView;

@interface JEJewelryCircleTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *logoImage;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@property (strong, nonatomic) IBOutlet FEScrollPageView *detailScrollImagsView;

@property (strong, nonatomic) IBOutlet UIView *seperateLine;
+ (JEJewelryCircleTableViewCell*)jewelryCircleTableViewCell;
+ (CGFloat)height;

@end
