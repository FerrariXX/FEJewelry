//
//  JESettingUserInfoCell.m
//  Jewelry
//
//  Created by wuyj on 14-5-28.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JESettingUserInfoCell.h"

@implementation JESettingUserInfoCell

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


+ (JESettingUserInfoCell*)settingUserInfoCell{
    
    id obj =  [self instanceWithNibName:@"JESettingUserInfoCell" bundle:nil owner:nil];
    if ([obj isKindOfClass:[JESettingUserInfoCell class]]) {
        JESettingUserInfoCell *cell = obj;
        cell.portraitImageView.layer.cornerRadius  = cell.portraitImageView.frame.size.width/2.0;
        cell.portraitImageView.layer.masksToBounds = YES;
//        cell.portraitImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hzw"]];
//        cell.nameLable.text = [NSString stringWithFormat:@"大笨钟"];
        return cell;
    }
    return nil;
}

+ (CGFloat)height{
    return 80.0f;
}

@end
