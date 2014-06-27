//
//  JEGoldQuotationCell.m
//  Jewelry
//
//  Created by wuyj on 14-6-3.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEGoldQuotationCell.h"

@interface JEGoldQuotationCell ();
@property (nonatomic, strong) NSString  *dateStr;
@end

@implementation JEGoldQuotationCell

+ (NSDateFormatter*)sharedDateFormatter {
    static NSDateFormatter * sharedDateFormatterInstance = nil;
    static dispatch_once_t        onceToken;
    dispatch_once(&onceToken, ^{
        sharedDateFormatterInstance = [[NSDateFormatter alloc] init];
        [sharedDateFormatterInstance setDateFormat:@"yyyy-MM-dd"];
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
     _dateStr = [[JEGoldQuotationCell sharedDateFormatter] stringFromDate:[NSDate date]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)refreshCell:(JEGoalPriceItem*)priceItem {
    _productNameValue.text = priceItem.goldName;
    _priceValueLable.text = priceItem.price;
    _dateValueLable.text = _dateStr;
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
