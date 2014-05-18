//
//  JEHomePageTableViewCell.m
//  Jewelry
//
//  Created by lv on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEHomePageTableViewCell.h"


@implementation JEHomePageTableViewCellItemView
@end


@implementation JEHomePageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - Public  Method
+ (JEHomePageTableViewCell*)homePageTableViewCell{
    
    id obj =  [self instanceWithNibName:@"JEHomePageTableViewCell" bundle:nil owner:nil];
    if ([obj isKindOfClass:[JEHomePageTableViewCell class]]) {
        JEHomePageTableViewCell *cell = obj;
        
        cell.leftItemView = [JEHomePageTableViewCell instanceWithNibName:@"JEHomePageTableViewCell" bundle:nil owner:nil index:1];
        cell.rightItemView = [JEHomePageTableViewCell instanceWithNibName:@"JEHomePageTableViewCell" bundle:nil owner:nil index:1];

        // Initialization code
        
        cell.leftItemView.frame = cell.leftPlaceHolderView.frame;
        cell.rightItemView.frame = cell.rightPlaceHolderView.frame;
        cell.leftPlaceHolderView.backgroundColor = [UIColor clearColor];
        cell.rightPlaceHolderView.backgroundColor= [UIColor clearColor];
        [cell.contentView insertSubview:cell.leftItemView belowSubview:cell.leftPlaceHolderView];
        [cell.contentView insertSubview:cell.rightItemView belowSubview:cell.rightPlaceHolderView];
        cell.contentView.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        return cell;
    }
    return nil;
}

+ (CGFloat)height{
    return 205.0f;
    //((UIView*)[self instanceWithNibName:@"JEHomePageTableViewCell" bundle:nil owner:nil]).frame.size.height;
;
}

@end
