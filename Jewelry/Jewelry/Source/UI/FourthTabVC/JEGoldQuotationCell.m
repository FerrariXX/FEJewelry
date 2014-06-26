//
//  JEGoldQuotationCell.m
//  Jewelry
//
//  Created by wuyj on 14-6-3.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEGoldQuotationCell.h"

@implementation JEGoldQuotationCell

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

- (void)refreshCell:(JEGoalPriceItem*)priceItem {
    _productNameValue.text = priceItem.goldName;
    _priceValueLable.text = priceItem.price;
}
+ (JEGoldQuotationCell*)goldQuotationCell{
    
    id obj =  [self instanceWithNibName:@"JESettingUserInfoCell" bundle:nil owner:nil index:5];
    if ([obj isKindOfClass:[JEGoldQuotationCell class]]) {
        JEGoldQuotationCell *cell = obj;
        return cell;
    }
    return nil;
}
    
@end
