//
//  XDRefreshGifHeader.h
//  Faith in life
//
//  Created by kingcong on 16/6/7.
//  Copyright © 2016年 Xinnuo. All rights reserved.
//

#import <MJRefresh/MJRefresh.h>

@interface XDRefreshGifHeader : MJRefreshGifHeader
{
    __unsafe_unretained UIImageView *_gifView;
}
/** 所有状态对应的动画图片 */
@property (strong, nonatomic) NSMutableDictionary *stateImages;
/** 所有状态对应的动画时间 */
@property (strong, nonatomic) NSMutableDictionary *stateDurations;

@property (weak, nonatomic, readonly) UIImageView *gifView;

/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;

@end
