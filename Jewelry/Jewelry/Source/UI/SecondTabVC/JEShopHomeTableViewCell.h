//
//  JEShopHomeTableViewCell.h
//  Jewelry
//
//  Created by xxx on 14-5-25.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEShopHomeTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *itemImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIView  *seperateLineView;

+ (JEShopHomeTableViewCell*)shopHomeTableViewCell;
+ (CGFloat)height;
@end
