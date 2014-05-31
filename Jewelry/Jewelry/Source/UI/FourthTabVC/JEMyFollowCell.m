//
//  JEMyFollowCell.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEMyFollowCell.h"

@implementation JEMyFollowCell

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

+ (JEMyFollowCell*)myFollowCell{
    
    id obj =  [self instanceWithNibName:@"JESettingUserInfoCell" bundle:nil owner:nil index:2];
    if ([obj isKindOfClass:[JEMyFollowCell class]]) {
        JEMyFollowCell *cell = obj;
        cell.portraitImageView.layer.cornerRadius  = cell.portraitImageView.frame.size.width/2.0;
        cell.portraitImageView.layer.masksToBounds = YES;
        cell.portraitImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hzw"]];
        cell.nameLable.text = [NSString stringWithFormat:@"千足金绿玉吊坠"];
        cell.dateLable.text = [NSString stringWithFormat:@"5分钟前"];
        cell.coverImageView.image = [UIImage imageNamed:@"cover"];
        return cell;
    }
    return nil;
}


@end
