//
//  MarketTableViewCell.m
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "MarketTableViewCell.h"

@implementation MarketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setMarkItem:(MarketItem *)markItem
{
    _markItem = markItem;
    
    [self setData:markItem];
}
- (void)setData:(MarketItem *)item
{
    self.channel.text = item.channel;
    self.nowPrice.text = [NSString stringWithFormat:@"%.4f",[item.ticker.last floatValue]];
    self.highest.text = [NSString stringWithFormat:@"¥%.4f",[item.ticker.high floatValue]];
    self.lowest.text = [NSString stringWithFormat:@"¥%.4f",[item.ticker.low floatValue]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
