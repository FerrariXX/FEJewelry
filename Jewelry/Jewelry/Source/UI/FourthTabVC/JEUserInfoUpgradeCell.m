//
//  JEUserInfoUpgradeCell.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEUserInfoUpgradeCell.h"
#import "UIImageView+WebCache.h"

@implementation JEUserInfoUpgradeCell

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

- (void)refreshCell:(NSString*)avatarURL {
    [_portraitImageView setImageWithURL:[NSURL URLWithString:avatarURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (JEUserInfoUpgradeCell*)userInfoUpgradeCell{
    
    id obj =  [self instanceWithNibName:@"JESettingUserInfoCell" bundle:nil owner:nil index:1];
    if ([obj isKindOfClass:[JEUserInfoUpgradeCell class]]) {
        JEUserInfoUpgradeCell *cell = obj;
        cell.portraitImageView.layer.cornerRadius  = cell.portraitImageView.frame.size.width/2.0;
        cell.portraitImageView.layer.masksToBounds = YES;
        cell.nameLable.text = [NSString stringWithFormat:@"头像"];
        return cell;
    }
    return nil;
}

+ (CGFloat)height{
    return 80.0f;
}

@end
