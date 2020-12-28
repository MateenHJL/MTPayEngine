//
//  BaseWebviewController.h
//  YouShuLa
//
//  Created by Teen Ma on 2018/5/8.
//  Copyright © 2018年 YouShuLa_IOS. All rights reserved.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface BaseWebviewController : BaseViewController

@property (nonatomic,strong  ) WKWebView * webView;
@property (nonatomic,strong  ) UIProgressView * progressView;
@property (nonatomic,strong  ) UIColor *progressViewColor;
@property (nonatomic,weak    ) WKWebViewConfiguration * webConfiguration;
@property (nonatomic, copy   ) NSString * url;
@property (nonatomic, copy   ) NSString * jsEvalutionJson;//与后台交互的js代码
@property (nonatomic, strong ) id       attactValue;

-(instancetype)initWithUrl:(NSString *)url;

//更新进度条
-(void)updateProgress:(double)progress;

//更新导航栏按钮，子类去实现
-(void)updateNavigationItems;

//加载完毕 子类去实现
-(void)webviewDidLoadFinished;

- (void)backBtnClicked;

@end
