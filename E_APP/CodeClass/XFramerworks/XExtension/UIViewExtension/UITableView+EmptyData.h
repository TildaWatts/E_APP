//
//  UITableView+EmptyData.h
//  Faith in life
//
//  Created by kingcong on 16/5/28.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)

- (void)tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

- (void) tableViewDisplayView:(UIView *) displayView ifNecessaryForRowCount:(NSUInteger) rowCount;



@end
