//
//  STCWebViewController.m
//  STCRouter
//
//  Created by chenxiancai on 03/12/2017.
//  Copyright © 2017 stevchen. All rights reserved.
//

#import "STCWebViewController.h"
#import <WebKit/WebKit.h>

@interface STCWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation STCWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (nil == self.url) self.url = @"";
    NSString *urlStr = [self.url stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
}

#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}

// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    
    NSLog(@"%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    
    NSLog(@"%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

@end
