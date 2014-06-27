//
//  JEMyPointsCell.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEMyPointsCell.h"

@implementation JEMyPointsCell


- (NSDateFormatter*)sharedDateFormatter {
    static NSDateFormatter * sharedDateFormatterInstance = nil;
    static dispatch_once_t        onceToken;
    dispatch_once(&onceToken, ^{
        sharedDateFormatterInstance = [[NSDateFormatter alloc] init];
    });
    return sharedDateFormatterInstance;
}

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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCell:(JEMyPointItem*)myPointItem {
    _categoryLabel.text = [NSString stringWithFormat:@"类别:%@",myPointItem.category];
    _pointLabel.text = [NSString stringWithFormat:@"积分值:+%@",myPointItem.value];
    _sourceLabel.text = [NSString stringWithFormat:@"来源:%@",myPointItem.sourceID];
    _dateLabel.text = [NSString stringWithFormat:@"%@",myPointItem.time];
}

+ (JEMyPointsCell*)myPointsCell {
    id obj =  [self instanceWithNibName:@"JESettingUserInfoCell" bundle:nil owner:nil index:4];
    if ([obj isKindOfClass:[JEMyPointsCell class]]) {
        JEMyPointsCell *cell = obj;
        return cell;
    }
    return nil;
    
}
@end
