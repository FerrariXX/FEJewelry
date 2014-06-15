//
//  JEDiamondListCell.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEDiamondListCell.h"

@implementation JEDiamondListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Public  Method
+ (JEDiamondListCell*)diamondListCellCell{
    
    id obj =  [self instanceWithNibName:@"JEDiamondListCell" bundle:nil owner:nil];
    if ([obj isKindOfClass:[JEDiamondListCell class]]) {
        JEDiamondListCell *cell = obj;
        cell.contentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        return cell;
    }
    return nil;
}

+ (CGFloat)height{
    return 44.0f;
}

+ (UIView*)diamondListCellHeaderView{
    return [self instanceWithNibName:@"JEDiamondListCell" bundle:nil owner:nil index:1];
}


@end
