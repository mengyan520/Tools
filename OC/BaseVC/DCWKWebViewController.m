//
//  DCWKWebViewController.m
//  FYJ
//
//  Created by ma on 2018/8/31.
//  Copyright © 2018年 issuser. All rights reserved.
//

#import "DCWKWebViewController.h"
#import <WebKit/WebKit.h>
NSString *const huizhi = @"https://weixin.foyunjian.com/index.php/home/mine/custom/id/9";//慧值声明
NSString *const aboutUs = @"https://weixin.foyunjian.com/index.php/home/mine/custom/id/8";//关于我们
NSString *const buyMoney = @"https://weixin.foyunjian.com/index.php/home/mine/custom/id/7";//购币说明
@interface DCWKWebViewController ()<WKNavigationDelegate>
@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) UIActivityIndicatorView *indicatorView;
@end

@implementation DCWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-StatusBarAndNavigationBarHeight)];
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    NSURL *url = [NSURL URLWithString:[_urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0,0,50, 50)];
    _indicatorView.center = _webView.center;
    _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.view addSubview:_indicatorView];
    [_indicatorView startAnimating];
    if (!_wkTitle) {
        [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    }else {
        self.title = _wkTitle;
    }
    
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if ([navigationAction.request.URL.absoluteString isEqual:@"about:blank"]){
        
        decisionHandler(WKNavigationActionPolicyCancel);
        
        return;
    }
   
    decisionHandler(WKNavigationActionPolicyAllow);
    
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
    
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [_indicatorView stopAnimating];
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [_indicatorView stopAnimating];
}
#pragma mark - kvo获取网页标题
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView)
        {
            self.title = self.webView.title;
        }
        else {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }
}
- (void)dealloc{
    if (!_wkTitle) {
         [_webView removeObserver:self forKeyPath:@"title" context:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
