//
//  BaseWebviewController.m
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/8.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import "BaseWebviewController.h"
#import "XLJSHandler.h"
#import <BaseUIManager/CommonFile.h>

@interface BaseWebviewController () <WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic,strong) XLJSHandler * jsHandler;
@property (nonatomic,assign) double lastProgress;//上次进度条位置

@end

@implementation BaseWebviewController

-(instancetype)initWithUrl:(NSString *)url
{
    self = [super init];
    if (self)
    {
        self.url = url;
        _progressViewColor = rgb(249, 104, 87);
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    if (_url != url) {
        _url = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
    //适配iOS11
    if (@available(iOS 11.0, *)){
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark 初始化webview
-(void)initWKWebView
{
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    configuration.preferences.javaScriptEnabled = YES;//打开js交互
    [configuration.userContentController addScriptMessageHandler:self name:@"click"];
    [configuration.userContentController addScriptMessageHandler:self name:@"callAndroid"];
    
    _webConfiguration = configuration;
    _jsHandler = [[XLJSHandler alloc]initWithViewController:self configuration:configuration];
    
    CGRect f = self.view.bounds;
    if (self.navigationController && self.shouldHiddenNavigationBar == NO) {
        f = CGRectMake(0, 0, self.view.bounds.size.width, yScreenHeight - kNavigationHeight);
    }
    
    self.webView = [[WKWebView alloc]initWithFrame:f configuration:configuration];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.allowsBackForwardNavigationGestures =YES;//打开网页间的 滑动返回
    self.webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    //监控进度
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:self.webView];
    
    //进度条
    _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.tintColor = _progressViewColor;
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3.0);
    [self.webView addSubview:_progressView];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.webView loadRequest:request];
}

-(void)backButtonClicked
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
    else
    {
        [super baseControllerClickLeftButton:nil];
    }
}

#pragma mark --进度条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self updateProgress:self.webView.estimatedProgress];
}

#pragma mark -  更新进度条
-(void)updateProgress:(double)progress{
    self.progressView.alpha = 1;
    if(progress > _lastProgress){
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    }else{
        [self.progressView setProgress:self.webView.estimatedProgress];
    }
    _lastProgress = progress;
    
    if (progress >= 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.alpha = 0;
            [self.progressView setProgress:0];
            _lastProgress = 0;
        });
    }
}

#pragma mark --navigation delegate
//加载完毕
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    if (self.jsEvalutionJson.length > 0)
    {
//        MTWeakBlock(self)
//        [self.webView evaluateJavaScript:self.jsEvalutionJson completionHandler:^(id _Nullable data, NSError * _Nullable error) {
//            weakself.jsEvalutionJson = @"";
//        }];
    }
    
    [self updateProgress:webView.estimatedProgress];
    
    [self updateNavigationItems];
    
    [self webviewDidLoadFinished];
}

-(void)updateNavigationItems{
    
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    
    //更新返回按钮
    [self updateNavigationItems];

    NSURL * url = webView.URL;
    //打开wkwebview禁用了电话和跳转appstore 通过这个方法打开
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.scheme isEqualToString:@"tel"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.absoluteString containsString:@"itunes.apple.com"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}

- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{

    if (!navigationAction.targetFrame.isMainFrame) {
        
        [webView loadRequest:navigationAction.request];
    }
    
    return nil;
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    [self.progressView setProgress:0.0f animated:NO];
     NSLog(@"加载失败%@", error.userInfo);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;
{
    
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;
{
    
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;
{
    
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{

}

-(void)backBtnClicked{
    [self.webView stopLoading];
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
    else
    {
        [super baseControllerClickLeftButton:nil];
    }
}

- (void)webviewDidLoadFinished
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_jsHandler cancelHandler];
    self.webView.navigationDelegate = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
