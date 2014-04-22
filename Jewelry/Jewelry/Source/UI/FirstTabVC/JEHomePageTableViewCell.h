//
//  JEHomePageTableViewCell.h
//  Jewelry
//
//  Created by lv on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface JEHomePageTableViewCellItemView : UIView
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *descrption;
@property (strong, nonatomic) IBOutlet UILabel *idLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

@end

@interface JEHomePageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *leftPlaceHolderView;
@property (strong, nonatomic) IBOutlet UIView *rightPlaceHolderView;
@property (strong, nonatomic) JEHomePageTableViewCellItemView *leftItemView;
@property (strong, nonatomic) JEHomePageTableViewCellItemView *rightItemView;
+ (JEHomePageTableViewCell*)homePageTableViewCell;
+ (CGFloat)height;
@end
