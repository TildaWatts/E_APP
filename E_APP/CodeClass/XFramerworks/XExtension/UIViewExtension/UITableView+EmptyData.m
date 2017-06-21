//
//  UITableView+EmptyData.m
//  Faith in life
//
//  Created by kingcong on 16/5/28.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import "UITableView+EmptyData.h"

@implementation UITableView (EmptyData)

- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UILabel *messageLabel = [UILabel new];
        
        messageLabel.text = message;
        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [messageLabel sizeToFit];
        
        self.backgroundView = messageLabel;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

//添加一个方法
- (void) tableViewDisplayView:(UIView *) displayView ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        self.backgroundView = displayView;
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.scrollEnabled = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}


@end
