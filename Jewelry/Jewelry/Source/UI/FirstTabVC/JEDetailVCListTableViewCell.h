//
//  JEDetailVCListTableViewCell.h
//  Jewelry
//
//  Created by xxxx on 14-6-2.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEDetailVCListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numberIDLabel;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;
@property (strong, nonatomic) IBOutlet UILabel *materialLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalWeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *CTWeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

+ (JEDetailVCListTableViewCell*)detailVCListTableViewCell;
+ (CGFloat)height;

+ (UIView*)detailVCListTableViewCellHeaderView;

@end
