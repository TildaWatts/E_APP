//
//  FirstViewController.m
//  E_APP
//
//  Created by Ezra on 2017/6/12.
//  Copyright © 2017年 Ezra. All rights reserved.
//

#import "FirstViewController.h"
#import "MarketEngine.h"
#import "MarketItem.h"
#import "MarketTableViewCell.h"
#define MarketCellID  @"AllPaymentID"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MarketItem *marketItem;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"行情";
    [self setupUI];
    [self openConnect];
    
}

- (void)setupUI
{
    CGRect rect = CGRectMake(0, 180*kScreenHeightScale, kScreenWidth, kScreenHeight);
    self.tableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    self.tableView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    self.tableView.rowHeight = 64;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MarketTableViewCell class]) bundle:nil ] forCellReuseIdentifier:MarketCellID];
    [self.view addSubview:self.tableView];
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
    cell.markItem = self.marketItem;
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}


#pragma mark - 发送心跳包
- (void)openConnect
{
    WS(weakSelf)
    [[ESocketManager shareManager] e_open:SocketUsuites connect:^{
        NSLog(@"成功连接");
        [weakSelf sendSocket];
    } receive:^(id message, ESocketReceiveType type) {
        if (type == ESocketReceiveTypeForMessage) {
            NSLog(@"接收 类型1--%@",message);
            weakSelf.marketItem = [MarketItem yy_modelWithJSON:message];
            [self.tableView reloadData];
        }
        else if (type == ESocketReceiveTypeForPong){
            NSLog(@"接收 类型2--%@",message);
        }
    } failure:^(NSError *error) {
        NSLog(@"连接失败");
    }];
}

- (void)sendSocket
{
    NSString *ss = @"bts_cny_ticker";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:@{@"event":@"addChannel",@"channel":ss} options:NSJSONWritingPrettyPrinted error:nil];
    [[ESocketManager shareManager] e_send:jsonData];
    
//    NSString *sss = @"etc_cny_ticker";
//    NSData *jsonDatas = [NSJSONSerialization dataWithJSONObject:@{@"event":@"addChannel",@"channel":sss} options:NSJSONWritingPrettyPrinted error:nil];
//    [[ESocketManager shareManager] e_send:jsonDatas];
    
}

#pragma mark - lazyLoad

-(MarketItem *)marketItem
{
    if (!_marketItem) {
        _marketItem = [[MarketItem alloc]init];
    }
    return _marketItem;
}


@end
