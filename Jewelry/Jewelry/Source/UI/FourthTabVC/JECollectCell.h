//
//  JECollectCell.h
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JECollectionModel.h"

@interface JECollectCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *productNO;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
+ (JECollectCell*)collectCell;
- (void)refreshCollectionCell:(JECollectionItem*)collectionItem;
@end
