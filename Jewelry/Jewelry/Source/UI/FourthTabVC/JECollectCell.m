//
//  JECollectCell.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JECollectCell.h"

@implementation JECollectCell

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

+ (JECollectCell*)collectCell {
    id obj =  [self instanceWithNibName:@"JESettingUserInfoCell" bundle:nil owner:nil index:3];
    if ([obj isKindOfClass:[JECollectCell class]]) {
        JECollectCell *cell = obj;
        cell.coverImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hzw"]];
        cell.nameLabel.text = [NSString stringWithFormat:@"千足金绿玉吊坠"];
        cell.productNO.text = [NSString stringWithFormat:@"编号：180811066954"];
        return cell;
    }
    return nil;

}

@end
