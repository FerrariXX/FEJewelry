//
//  JEShopHomeTableViewCell.m
//  Jewelry
//
//  Created by xxx on 14-5-25.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEShopHomeTableViewCell.h"

@implementation JEShopHomeTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (JEShopHomeTableViewCell*)shopHomeTableViewCell{
    id obj =  [self instanceWithNibName:@"JEShopHomeTableViewCell" bundle:nil owner:nil];
    if ([obj isKindOfClass:[JEShopHomeTableViewCell class]]) {
        JEShopHomeTableViewCell *cell = obj;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.seperateLineView.frame = CGRectMake(cell.seperateLineView.frame.origin.x, cell.frame.size.height-1, cell.seperateLineView.frame.size.width, 0.5);
        cell.seperateLineView.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }
    return nil;

}

+ (CGFloat)height{
    return [[self shopHomeTableViewCell] frame].size.height;

}
@end
