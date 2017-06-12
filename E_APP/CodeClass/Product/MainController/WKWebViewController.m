//
//  WKWebViewController.m
//  Faith in life
//
//  Created by 王聪 on 16/4/27.
//  Copyright © 2016年 allan. All rights reserved.
//

#import "WKWebViewController.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import <WebKit/WebKit.h>
#import <MessageUI/MessageUI.h>
#import "LinkCenter.h"
#import "XUri.h"
#import "WebViewUtil.h"
#import "JSBridge.h"

#define WebViewNav_TintColor ([UIColor orangeColor])

@interface WKWebViewController () <WKScriptMessageHandler, WKUIDelegate, WKNavigationDelegate,EventListener,MFMessageComposeViewControllerDelegate>

@property (weak, nonatomic) WKWebView *webView;

// toobar按钮
@property (weak, nonatomic) UIButton *goBackItem;
@property (weak, nonatomic) UIButton *goForwardItem;
@property (weak, nonatomic) UIButton *goRefreshItem;

@property (weak, nonatomic) UIView *toolBar;

@property (weak, nonatomic) UIProgressView *progressView;

@property (weak, nonatomic) UIActivityIndicatorView *activityView;

@property (strong, nonatomic) WKWebViewConfiguration *configuretion;


@property (nonatomic, strong) NSURLRequest *request;

@property (nonatomic, strong) JSBridge* jsb;


@property (assign, nonatomic) NSUInteger loadCount;


@property (nonatomic, assign) CGFloat progressY;//进度条的动态高度

@end

@implementation WKWebViewController


- (instancetype)initWithUrlStr:(NSString *)urlStr
{
    if (self  = [super init])
    {
        self.url = [WebViewUtil handleUrlStrWithUrl:urlStr];
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.jsb = [[JSBridge alloc] init];
    [self.jsb attach:nil wk:self.webView view:self];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if( self.jsb != nil)
    {
        [self.jsb deattach];
        self.jsb = nil;
    }
    [EventCenter Event_Remove:self];
}

-(void)handlerEvent:(NSNotification *)  event
{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 加载请求
    [self loadRequest];
    
    [self setTitleAndToolBar];

}

- (void) setTitleAndToolBar
{
    self.toolBar.hidden = !self.showToolBar;
}

- (void)setup
{
    // 0.创建配置
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preferences = [[WKPreferences alloc] init];
    preferences.minimumFontSize = 10;
    preferences.javaScriptEnabled = YES;
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    configuration.preferences = preferences;
    
    configuration.userContentController = [[WKUserContentController alloc] init];    
    
    
    // 1.设置webView
    WKWebView *webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:configuration];
    webView.backgroundColor = APP_PAGE_COLOR;
    webView.allowsBackForwardNavigationGestures = YES;
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView = webView;
    [self.view addSubview:webView];
    // 添加下拉刷新控件
    self.webView.scrollView.mj_header = [XDRefreshGifHeader headerWithRefreshingBlock:^{
        [self goRefresh:nil];
    }];
    
    WS(weakSelf)
    self.progressY = 0;
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(0);
    }];
    //存在headerView
    if (self.wkHeaderView && self.wkHeaderView.height) {
        
        [self.view addSubview:self.wkHeaderView];
        self.progressY = self.wkHeaderView.height;
        [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.wkHeaderView.height+64);
        }];
    }
    //存在footerView
    if (self.wkFooterView && self.wkFooterView.height)
    {
        [self.view addSubview:self.wkFooterView];
        [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).offset( -self.wkFooterView.height);
        }];
    }
    
    // 2.设置进度条
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64+self.progressY, kWindowWidth, 3)];
    progressView.progress = 0.0;
    progressView.tintColor = WebViewNav_TintColor;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    
    // 3.加载圆圈
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] init];
    activityView.color = [UIColor blackColor];
    self.activityView = activityView;
    [self.view addSubview:activityView];
    
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    // 4.下方工具条
    UIView *toolBar = [[UIView alloc] init];
    self.toolBar = toolBar;
    toolBar.backgroundColor = [UIColor grayColor];
    [self.view addSubview:toolBar];
    
    [toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(40);
    }];
    
    // 5.工具条按钮
    UIButton *goBackItem = [UIButton buttonWithType:UIButtonTypeCustom];
    goBackItem.backgroundColor = [UIColor redColor];
    [goBackItem setTitle:@"后退" forState:UIControlStateNormal];
    [goBackItem setTintColor:[UIColor whiteColor]];
    self.goBackItem = goBackItem;
    
    [goBackItem addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.toolBar addSubview:goBackItem];
    
    [goBackItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.toolBar).offset(10);
        make.top.bottom.mas_equalTo(self.toolBar);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *goForwardItem = [UIButton buttonWithType:UIButtonTypeCustom];
    goForwardItem.backgroundColor = [UIColor greenColor];
    self.goForwardItem = goForwardItem;
    [goForwardItem setTitle:@"前进" forState:UIControlStateNormal];
    [goForwardItem setTintColor:[UIColor whiteColor]];
    [goForwardItem addTarget:self action:@selector(goForward:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:goForwardItem];
    [goForwardItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(goBackItem.mas_right).mas_offset(10);
        make.top.bottom.mas_equalTo(self.toolBar);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *goRefreshItem = [UIButton buttonWithType:UIButtonTypeCustom];
    goRefreshItem.backgroundColor = [UIColor blueColor];
    self.goRefreshItem = goRefreshItem;
    [goRefreshItem setTitle:@"刷新" forState:UIControlStateNormal];
    [goRefreshItem setTintColor:[UIColor whiteColor]];
    [goRefreshItem addTarget:self action:@selector(goRefresh:) forControlEvents:UIControlEventTouchUpInside];
    [toolBar addSubview:goRefreshItem];
    [goRefreshItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.toolBar);
        make.width.mas_equalTo(50);
        make.right.mas_equalTo(-10);
    }];
    
}


// 1.加载请求
- (void)loadRequest
{
    if (self.url == nil || self.url.length == 0) {
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    self.request = request;
    
    [self.webView loadRequest:request];
    
}


- (void)goRefresh:(id)sender {
    [self.webView reload];
}

- (void)goBack:(id)sender {

    [self.webView goBack];

}

- (void)goForward:(id)sender {
    [self.webView goForward];
}


-(void) hideToolBar:(BOOL) isShowToolbar
{
    self.toolBar.hidden = !isShowToolbar;
}

#pragma mark - wkWebView代理


// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

// 记得取消监听
- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
    self.activityView.hidden = NO;
    [self.activityView startAnimating];

}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
    
    [self.webView.scrollView.mj_header endRefreshing];
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        if (!self.isNotUseHtmlTitle)
        {
            self.title = (NSString *)result;
        }
    }];
    
    [self.jsb onReady];
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
    
    [self.activityView stopAnimating];
    self.activityView.hidden = YES;
    self.progressView.hidden = YES;
    
//    [USProgressHud showErrorWithStatus:OTHER_FAIL_OR_NETWORK];
}

- (void)setLeftItemWithType:(int)type
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 10, 30, 20);
    [backBtn setImage:[UIImage imageNamed:@"Home_white_back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0, 10, 30, 20);
    [closeBtn setImage:[UIImage imageNamed:@"closeWeb"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *closeBtnItem = [[UIBarButtonItem alloc] initWithCustomView:closeBtn];
    
    if (type == 1) {
        self.navigationItem.leftBarButtonItems = @[backBtnItem,closeBtnItem];
        return;
    } else if(type == 0){
        self.navigationItem.leftBarButtonItems = @[backBtnItem];
        return;
    }
}

#pragma mark - 接收到服务器请求调用的方法
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"%s",__func__);
}
//
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"%s",__func__);
    decisionHandler(WKNavigationResponsePolicyAllow);
}

// 在发送请求之前，决定是否跳转
// 如果不添加这个，那么wkwebview跳转不了AppStore

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString* target_url = navigationAction.request.URL.absoluteString;
    
    XUri* uri = [XUri parseFromString:target_url];
    XLog(@"%s==%@",__func__,target_url);
    if ([uri.scheme isEqualToString:SCHEME_HTTPS] || [uri.scheme isEqualToString:SCHEME_HTTP]) // 是HTML5页面跳转
    {
        if (![target_url isEqualToString:self.url])
        {
            if( self.jumpToOtherWebView )
            {
                [LinkCenter centerForJumpLink:self action:target_url otherObj:@"正在加载"];
                decisionHandler(WKNavigationActionPolicyCancel);
            }
            else
            {
                [WebViewUtil handleUrlStrWithUrl:target_url];
                decisionHandler(WKNavigationActionPolicyAllow);
            }
        }
        else
            decisionHandler(WKNavigationActionPolicyAllow);
    }
    else if ([uri.scheme isEqualToString:SCHEME_XINNUO])// APP页面
    {
//        self.autoClearFromNavigator = YES;
        
        [LinkCenter centerForJumpLink:self action:target_url otherObj:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else if ([uri.scheme isEqualToString:SCHEME_JSB]) // 是JSB界面
    {
        [self.jsb handlerJSB:uri];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    else
    {
//        if (![[UIApplication sharedApplication] canOpenURL:webView.URL])
//        {
//            decisionHandler(WKNavigationActionPolicyCancel);
//            return ;
//        }
//        decisionHandler(WKNavigationActionPolicyAllow);
        //  禁止跳转到其他 schme
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}

- (void)back
{
    NSLog(@"%s",__func__);
    if (self.webView.canGoBack)
    {
        [self setLeftItemWithType:1];
        [self.webView goBack];
        return;
    }
    [self close];
}

- (void)close
{
    UIViewController* wk = [self.navigationController popViewControllerAnimated:YES];
    if( wk == nil  )
    {
//        [ [AppDelegate getApp] goHomePage  ];
    }
}



/**
 *  web界面中有弹出警告框时调用
 *
 *  @param webView           实现该代理的webview
 *  @param message           警告框中的内容
 *  @param frame             主窗口
 *  @param completionHandler 警告框消失调用
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"%s",__func__);

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示框" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        completionHandler();
    }];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    NSLog(@"%s",__func__);

    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示框" message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        completionHandler(YES);
    }];

}


/**
 下面的代码不添加，通过js弹出的AlertView就不能执行

 @param webView ss
 @param configuration ss
 @param navigationAction ss
 @param windowFeatures ss
 @return ss
 */
-(WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView loadRequest:navigationAction.request];
    }
    return nil;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"%@",message);
}


// 对于HTTPS的都会触发此代理，如果不要求验证，传默认就行
// 如果需要证书验证，与使用AFN进行HTTPS证书验证是一样的
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    NSLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

#pragma mark - H5发送信息
- (void)sms:(NSMutableDictionary *)query
{
    if (query) {
        NSString *phoneNumStr = query[@"phone"];
        NSString *body = query[@"data"];
        NSArray *phoneNum = [phoneNumStr componentsSeparatedByString:@","];
        
        if (![phoneNumStr isEqualToString:@""]) {
            
            [self showMessageViewAlertPhoneNumStr:phoneNumStr phoneNum:phoneNum body:body];
        }else{
//            [self showHint:@"号码不能为空"];
        }
    }
    
}

- (void)showMessageViewAlertPhoneNumStr:(NSString *)phoneNumStr phoneNum:(NSArray *)phoneNum body:(NSString *)body
{
    NSString *message;
    
    if ( body) {
        message = [NSString stringWithFormat:@"发送短信\"%@\"到%@",body,phoneNumStr];
    }else{
        message = [NSString stringWithFormat:@"向%@发送信息",phoneNumStr];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"发送短信", nil];
    [alertView show];
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        NSNumber *i = (NSNumber *)x;
        if (i.integerValue == 0) {
            NSLog(@"0blockBtn");
        }else if (i.integerValue == 1){
        [self showMessageView:phoneNum title:@"新消息" body:body];
        }
    }];
}
-(void)showMessageView:(NSArray *)phones title:(NSString *)title body:(NSString *)body{
    
    if ([MFMessageComposeViewController canSendText]) {
        MFMessageComposeViewController *msgController = [MFMessageComposeViewController new];
        //设置接收人 内容 标题
        msgController.recipients = phones;
        msgController.body = body;
        msgController.title = title;
        //设置代理*********代理
        msgController.messageComposeDelegate = self;
        msgController.navigationBar.tintColor = [UIColor redColor];
        
        [self presentViewController:msgController animated:YES completion:nil];
    }else{
        NSLog(@"该设备不能发短信");
    }
}

//发送信息回调的代理
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultSent:
            NSLog(@"发送成功");
//            [controller showHint:@"发送成功" yOffset:-125];
            break;
        case MessageComposeResultFailed:
            NSLog(@"发送失败");
        case MessageComposeResultCancelled:
            NSLog(@"取消发送");
        default:
            break;
    }
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
