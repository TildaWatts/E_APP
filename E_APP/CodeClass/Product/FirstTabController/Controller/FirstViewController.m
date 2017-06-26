//
//  FirstViewController.m
//  E_APP
//
//  Created by Ezra on 2017/6/12.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "FirstViewController.h"
#import "MarketItem.h"
#import "MarketTableViewCell.h"
#import "KLineViewController.h"
#import "AppDelegate.h"

#define MarketCellID  @"AllPaymentID"
#define ChannelCount 3

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MarketItem *marketItem;


@property (nonatomic, strong) NSArray<MarketItem *> *itemArr;
@property (nonatomic, copy) NSMutableArray *jsonArrM;
@property (nonatomic, copy) NSMutableArray *channelNameArrM;



@property (nonatomic, assign) __block int i ;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"行情";
    [self setupUI];
}

- (void)setupUI
{
    CGFloat y = 200*kScreenHeightScale;
    CGRect rect = CGRectMake(0, y, kScreenWidth, kScreenHeight-y-49);
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    self.automaticallyAdjustsScrollViewInsets = false;
    self.tableView.separatorStyle = NO;
//    self.tableView.rowHeight = 60;
//    self.tableView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight - 200*kScreenHeightScale);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketTableViewCell class]) bundle:nil] forCellReuseIdentifier:MarketCellID];
    [self.view addSubview:self.tableView];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self openConnect];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[ESocketManager shareManager] e_close:^(NSInteger code, NSString *reason, BOOL wasClean) {
        NSLog(@"code = %zd,reason = %@",code,reason);
    }];
}
#pragma mark - tableViewDele/DataS
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MarketCellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.itemArr.count && indexPath.section == 0) {
        cell.markItem = self.itemArr[indexPath.row];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.channelNameArrM.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *currency = [[self.itemArr[indexPath.row].channel lowercaseString] stringByAppendingString:@"_cny"];
    KLineViewController *kLineVc = [[KLineViewController alloc]init];
    kLineVc.currency = currency;
    [self presentViewController:kLineVc animated:YES completion:nil];
}


#pragma mark - 组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, kScreenWidth)];
    view.backgroundColor = UIColorFromRGB(0x0A0A0A);
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = kFontWithSize(15);
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.mas_equalTo(view);
    }];
    if (section == 0) {
        titleLab.text = @"中国比特币";
    }else{
        titleLab.text = @"聚币";
    }
    
    return view;
}


#pragma mark - 发送心跳包
- (void)openConnect
{
    WS(weakSelf)
    [[ESocketManager shareManager] e_open:SocketUsuites connect:^{
        NSLog(@"成功连接");
        weakSelf.i = 0;
        
        [weakSelf sendSocketChannelName:self.channelNameArrM];
        
    } receive:^(id message, ESocketReceiveType type) {
        if (type == ESocketReceiveTypeForMessage) {
            NSLog(@"接收 类型1--%@",message);
        
            weakSelf.i++;
            NSLog(@"%d",weakSelf.i);
            
            if (weakSelf.i%self.channelNameArrM.count == 1) {
                [self.jsonArrM removeAllObjects];
            }
            
            [self.jsonArrM addObject:message];
            if (self.jsonArrM.count == self.channelNameArrM.count) {
                NSString *str = [self.jsonArrM componentsJoinedByString:@","];
                NSString *newJson = [NSString stringWithFormat:@"[%@]",str];
                weakSelf.itemArr = [NSArray yy_modelArrayWithClass:[MarketItem class] json:newJson];
                [self.tableView reloadData];
            }
        }
        else if (type == ESocketReceiveTypeForPong){
            NSLog(@"接收 类型2--%@",message);
            
        }
    } failure:^(NSError *error) {
        NSLog(@"连接失败");
//        [weakSelf showHint:error.domain];
    }];
}

- (void)sendSocketChannelName:(NSArray *)ChannelArr
{
    for (NSString *channelName in ChannelArr) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"event":@"addChannel",@"channel":channelName} options:NSJSONWritingPrettyPrinted error:nil];
        [[ESocketManager shareManager] e_send:jsonData];
    }
}

#pragma mark - lazyLoad

-(MarketItem *)marketItem
{
    if (!_marketItem) {
        _marketItem = [[MarketItem alloc]init];
    }
    return _marketItem;
}

-(NSMutableArray *)jsonArrM
{
    if (!_jsonArrM) {
        _jsonArrM = [NSMutableArray array];
    }
    return _jsonArrM;
}

-(NSMutableArray *)channelNameArrM
{
    if (!_channelNameArrM) {
        _channelNameArrM = [NSMutableArray array];
        [_channelNameArrM addObject:@"btc_cny_ticker"];
        [_channelNameArrM addObject:@"ltc_cny_ticker"];
        [_channelNameArrM addObject:@"etc_cny_ticker"];
        [_channelNameArrM addObject:@"bts_cny_ticker"];
    }
    return _channelNameArrM;
}

-(void)setItemArr:(NSArray<MarketItem *> *)itemArr
{
    if (itemArr.count) {
        
        NSMutableArray<MarketItem *> *itemArrM = [[NSMutableArray alloc]initWithCapacity:itemArr.count];
        NSMutableArray<MarketItem *> *tempArrM = [NSMutableArray array];
        
        [itemArrM addObjectsFromArray:itemArr];
        [tempArrM addObjectsFromArray:itemArr];
        
        [tempArrM enumerateObjectsUsingBlock:^(MarketItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj.channel isEqualToString:@"BTC"]) {
                [itemArrM replaceObjectAtIndex:0 withObject:obj];
            }else if ([obj.channel isEqualToString:@"LTC"]) {
                [itemArrM replaceObjectAtIndex:1 withObject:obj];
            }else if ([obj.channel isEqualToString:@"ETC"]) {
                [itemArrM replaceObjectAtIndex:2 withObject:obj];
            }else if ([obj.channel isEqualToString:@"BTS"]) {
                [itemArrM replaceObjectAtIndex:3 withObject:obj];
            }
        }];
        
        _itemArr = itemArrM;
    }
}


@end
