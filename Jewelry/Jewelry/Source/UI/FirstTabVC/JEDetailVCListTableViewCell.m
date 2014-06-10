//
//  JEDetailVCListTableViewCell.m
//  Jewelry
//
//  Created by xxxx on 14-6-2.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "JEDetailVCListTableViewCell.h"

@implementation JEDetailVCListTableViewCell

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
+ (JEDetailVCListTableViewCell*)detailVCListTableViewCell{
    
    id obj =  [self instanceWithNibName:@"JEDetailVCListTableViewCell" bundle:nil owner:nil];
    if ([obj isKindOfClass:[JEDetailVCListTableViewCell class]]) {
        JEDetailVCListTableViewCell *cell = obj;
        cell.contentView.backgroundColor = [UIColor whiteColor];//[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        return cell;
    }
    return nil;
}

+ (CGFloat)height{
    return 44.0f;
}

+ (UIView*)detailVCListTableViewCellHeaderView{
    return [self instanceWithNibName:@"JEDetailVCListTableViewCell" bundle:nil owner:nil index:1];
}


@end
