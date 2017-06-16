//
//  MarketTableViewCell.h
//  E_APP
//
//  Created by Ezra on 2017/6/16.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarketItem.h"


@interface MarketTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *channel;
@property (weak, nonatomic) IBOutlet UILabel *range;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;
@property (weak, nonatomic) IBOutlet UILabel *highest;
@property (weak, nonatomic) IBOutlet UILabel *lowest;

@property (nonatomic, strong) MarketItem *markItem;

@end
