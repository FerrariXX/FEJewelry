//
//  JECollectCell.m
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JECollectCell.h"
#import "UIImageView+WebCache.h"

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

- (void)refreshCollectionCell:(JECollectionItem*)collectionItem {
    _nameLabel.text = collectionItem.styleName;
    _productNO.text = collectionItem.styleID;
    _priceLabel.text = collectionItem.price;
    [_coverImageView setImageWithURL:[NSURL URLWithString:collectionItem.imageArray] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
    }];
}
+ (JECollectCell*)collectCell {
    id obj =  [self instanceWithNibName:@"JESettingUserInfoCell" bundle:nil owner:nil index:3];
    if ([obj isKindOfClass:[JECollectCell class]]) {
        JECollectCell *cell = obj;
        cell.nameLabel.text = [NSString stringWithFormat:@"千足金绿玉吊坠"];
        cell.productNO.text = [NSString stringWithFormat:@"编号：180811066954"];
        return cell;
    }
    return nil;

}

@end
