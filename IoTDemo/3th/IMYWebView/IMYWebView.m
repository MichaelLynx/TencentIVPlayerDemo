//
//  IMYWebView.m
//  IMY_ViewKit
//
//  Created by ljh on 15/7/1.
//  Copyright (c) 2015年 IMY. All rights reserved.
//

#import "IMYWebView.h"

#import "IMY_NJKWebViewProgress.h"
#import <TargetConditionals.h>
#import <dlfcn.h>
#import <WebKit/WebKit.h>

@interface IMYWebView()<UIWebViewDelegate,WKNavigationDelegate,WKUIDelegate,IMY_NJKWebViewProgressDelegate>

@property (nonatomic, assign) double estimatedProgress;
@property (nonatomic, strong) NSURLRequest *originRequest;
@property (nonatomic, strong) NSURLRequest *currentRequest;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) IMY_NJKWebViewProgress* njkWebViewProgress;
@end

@implementation IMYWebView

@synthesize realWebView = _realWebView;
@synthesize scalesPageToFit = _scalesPageToFit;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initMyself];
    }
    return self;
}
- (instancetype)init
{
    return [self initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame usingUIWebView:NO];
}
- (instancetype)initWithFrame:(CGRect)frame usingUIWebView:(BOOL)usingUIWebView
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        [self _initMyself];
    }
    return self;
}
-(void)_initMyself
{
   // Class wkWebView = NSClassFromString(@"WKWebView");
    //if(wkWebView && self.usingUIWebView == NO)
   // {
        [self initWKWebView];
        
  //  }
   // else
   // {
     //   [self initUIWebView];
       // _usingUIWebView = YES;
  //  }
    //self.scalesPageToFit = YES;
    
    [self.realWebView setFrame:self.bounds];
    [self.realWebView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self addSubview:self.realWebView];
}
-(void)initWKWebView
{
    WKWebViewConfiguration* configuration = [[NSClassFromString(@"WKWebViewConfiguration") alloc] init];
    configuration.preferences = [NSClassFromString(@"WKPreferences") new];
    configuration.userContentController = [NSClassFromString(@"WKUserContentController") new];
    
    WKWebView* webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:configuration];
    //[[NSClassFromString(@"WKWebView") alloc] initWithFrame:self.bounds configuration:configuration];
    webView.UIDelegate = self;
    webView.navigationDelegate = self;
    
    webView.backgroundColor = [UIColor clearColor];
    webView.opaque = NO;
    
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
    _realWebView = webView;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        self.estimatedProgress = [change[NSKeyValueChangeNewKey] doubleValue];
    }
    else if([keyPath isEqualToString:@"title"])
    {
        self.title = change[NSKeyValueChangeNewKey];
    }
}

#pragma mark- WKNavigationDelegate
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    BOOL resultBOOL = [self callback_webViewShouldStartLoadWithRequest:navigationAction.request navigationType:navigationAction.navigationType];
    if(resultBOOL)
    {
        self.currentRequest = navigationAction.request;
        if(navigationAction.targetFrame == nil)
        {
            [webView loadRequest:navigationAction.request];
        }
        decisionHandler(WKNavigationActionPolicyAllow);
    }
    else
    {
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    [self callback_webViewDidStartLoad];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [self callback_webViewDidFinishLoad];
}
- (void)webView:(WKWebView *) webView didFailProvisionalNavigation: (WKNavigation *) navigation withError: (NSError *) error
{
    [self callback_webViewDidFailLoadWithError:error];
}
- (void)webView: (WKWebView *)webView didFailNavigation:(WKNavigation *) navigation withError: (NSError *) error
{
    [self callback_webViewDidFailLoadWithError:error];
}
#pragma mark- WKUIDelegate
///--  还没用到
#pragma mark- CALLBACK IMYVKWebView Delegate

- (void)callback_webViewDidFinishLoad
{
    if([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [self.delegate webViewDidFinishLoad:self];
    }
}
- (void)callback_webViewDidStartLoad
{
    if([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [self.delegate webViewDidStartLoad:self];
    }
}
- (void)callback_webViewDidFailLoadWithError:(NSError *)error
{
    if([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [self.delegate webView:self didFailLoadWithError:error];
    }
}
-(BOOL)callback_webViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(NSInteger)navigationType
{
    BOOL resultBOOL = YES;
    if([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        if(navigationType == -1) {
            navigationType = UIWebViewNavigationTypeOther;
        }
        resultBOOL = [self.delegate webView:self shouldStartLoadWithRequest:request navigationType:navigationType];
    }
    return resultBOOL;
}

#pragma mark- 基础方法
-(UIScrollView *)scrollView
{
    return [(id)self.realWebView scrollView];
}

- (id)loadRequest:(NSURLRequest *)request
{
    self.originRequest = request;
    self.currentRequest = request;
    
  
    return [(WKWebView*)self.realWebView loadRequest:request];
    
}
- (id)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    if (string == nil) {
        string = @"";
    }
 
    return [(WKWebView*)self.realWebView loadHTMLString:string baseURL:baseURL];
    
}
-(NSURLRequest *)currentRequest
{
   
        return _currentRequest;
    
}
-(NSURL *)URL
{
   
    return [(WKWebView*)self.realWebView URL];
    
}
-(BOOL)isLoading
{
    return [self.realWebView isLoading];
}
-(BOOL)canGoBack
{
    return [self.realWebView canGoBack];
}
-(BOOL)canGoForward
{
    return [self.realWebView canGoForward];
}

- (id)goBack
{
   
    return [(WKWebView*)self.realWebView goBack];
    
}
- (id)goForward
{
    
    return [(WKWebView*)self.realWebView goForward];
    
}
- (id)reload
{
    
    return [(WKWebView*)self.realWebView reload];

}
- (id)reloadFromOrigin
{
   
    return [(WKWebView*)self.realWebView reloadFromOrigin];
    
}
- (void)stopLoading
{
    [self.realWebView stopLoading];
}

- (void)evaluateJavaScript:(NSString *)javaScriptString completionHandler:(void (^)(id, NSError *))completionHandler
{
    
    return [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:completionHandler];
    
}
-(NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)javaScriptString
{
    
        __block NSString* result = nil;
        __block BOOL isExecuted = NO;
        [(WKWebView*)self.realWebView evaluateJavaScript:javaScriptString completionHandler:^(id obj, NSError *error) {
            result = obj;
            isExecuted = YES;
        }];
        
        while (isExecuted == NO) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        return result;
    
}
-(void)setScalesPageToFit:(BOOL)scalesPageToFit
{
   
        if(_scalesPageToFit == scalesPageToFit)
        {
            return;
        }
        
        WKWebView* webView = _realWebView;
        
        NSString *jScript = @"var meta = document.createElement('meta'); \
        meta.name = 'viewport'; \
        meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no'; \
        var head = document.getElementsByTagName('head')[0];\
        head.appendChild(meta);";
        
        if(scalesPageToFit)
        {
            WKUserScript *wkUScript = [[NSClassFromString(@"WKUserScript") alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
            [webView.configuration.userContentController addUserScript:wkUScript];
        }
        else
        {
            NSMutableArray* array = [NSMutableArray arrayWithArray:webView.configuration.userContentController.userScripts];
            for (WKUserScript *wkUScript in array)
            {
                if([wkUScript.source isEqual:jScript])
                {
                    [array removeObject:wkUScript];
                    break;
                }
            }
            for (WKUserScript *wkUScript in array)
            {
                [webView.configuration.userContentController addUserScript:wkUScript];
            }
        }
    
    
    _scalesPageToFit = scalesPageToFit;
}
-(BOOL)scalesPageToFit
{
    
    return _scalesPageToFit;
    
}

/**
 *  添加js回调oc通知方式，适用于 iOS8 之后
 */
- (void)addScriptMessageHandler:(id <WKScriptMessageHandler>)scriptMessageHandler name:(NSString *)name
{
    if ([_realWebView isKindOfClass:NSClassFromString(@"WKWebView")]) {
        [[(WKWebView *)_realWebView configuration].userContentController addScriptMessageHandler:scriptMessageHandler name:name];
    }
}

/**
 *  注销 注册过的js回调oc通知方式，适用于 iOS8 之后
 */
- (void)removeScriptMessageHandlerForName:(NSString *)name
{
    if ([_realWebView isKindOfClass:NSClassFromString(@"WKWebView")]) {
        [[(WKWebView *)_realWebView configuration].userContentController removeScriptMessageHandlerForName:name];
    }
}

-(NSInteger)countOfHistory
{
   
        WKWebView* webView = self.realWebView;
        return webView.backForwardList.backList.count;
    
}
-(void)gobackWithStep:(NSInteger)step
{
    if(self.canGoBack == NO)
        return;
    
    if(step > 0)
    {
        NSInteger historyCount = self.countOfHistory;
        if(step >= historyCount)
        {
            step = historyCount - 1;
        }
        
        
            WKWebView* webView = self.realWebView;
            WKBackForwardListItem* backItem = webView.backForwardList.backList[step];
            [webView goToBackForwardListItem:backItem];
        
    }
    else
    {
        [self goBack];
    }
}
#pragma mark-  如果没有找到方法 去realWebView 中调用
-(BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL hasResponds = [super respondsToSelector:aSelector];
    if(hasResponds == NO)
    {
        hasResponds = [self.delegate respondsToSelector:aSelector];
    }
    if(hasResponds == NO)
    {
        hasResponds = [self.realWebView respondsToSelector:aSelector];
    }
    return hasResponds;
}
- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* methodSign = [super methodSignatureForSelector:selector];
    if(methodSign == nil)
    {
        if([self.realWebView respondsToSelector:selector])
        {
            methodSign = [self.realWebView methodSignatureForSelector:selector];
        }
        else
        {
            methodSign = [(id)self.delegate methodSignatureForSelector:selector];
        }
    }
    return methodSign;
}
- (void)forwardInvocation:(NSInvocation*)invocation
{
    if([self.realWebView respondsToSelector:invocation.selector])
    {
        [invocation invokeWithTarget:self.realWebView];
    }
    else
    {
        [invocation invokeWithTarget:self.delegate];
    }
}

#pragma mark- 清理
-(void)dealloc
{
   
        WKWebView* webView = _realWebView;
        webView.UIDelegate = nil;
        webView.navigationDelegate = nil;
        
        [webView removeObserver:self forKeyPath:@"estimatedProgress"];
        [webView removeObserver:self forKeyPath:@"title"];
   
    [_realWebView scrollView].delegate = nil;
    [_realWebView stopLoading];
    [(WKWebView*)_realWebView loadHTMLString:@"" baseURL:nil];
    [_realWebView stopLoading];
    [_realWebView removeFromSuperview];
    _realWebView = nil;
}
@end
