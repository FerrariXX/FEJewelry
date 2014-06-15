//
//  JEJewelryCircleTableViewCell.m
//  Jewelry
//
//  Created by xxx on 14-5-24.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEJewelryCircleTableViewCell.h"
#import "NSObject+FENib.h"

@class FEScrollPageView;
@interface JEJewelryCircleTableViewCell()

@end

@implementation JEJewelryCircleTableViewCell

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
+ (JEJewelryCircleTableViewCell*)jewelryCircleTableViewCell{
    
    id obj =  [self instanceWithNibName:@"JEJewelryCircleTableViewCell" bundle:nil owner:nil];
    if ([obj isKindOfClass:[JEJewelryCircleTableViewCell class]]) {
        JEJewelryCircleTableViewCell *cell = obj;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        //cell.contentView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        cell.logoImage.backgroundColor = [UIColor clearColor];
        cell.seperateLine.backgroundColor = [UIColor grayColor];
        cell.seperateLine.frame = CGRectMake(0, cell.bounds.size.height-1, cell.bounds.size.width, 0.5);
        CGRect  rect = cell.topSeperateLine.frame;
        rect.size.height = 0.5;
        cell.topSeperateLine.frame =  rect;
        cell.topSeperateLine.backgroundColor = [UIColor grayColor];
        cell.topSeperateLine.hidden = YES;
        return cell;
    }
    return nil;
}

+ (CGFloat)height{
    return [[self jewelryCircleTableViewCell] frame].size.height;
}

@end
