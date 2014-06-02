//
//  JEWebViewController.m
//  Jewelry
//
//  Created by xxxx on 14-6-2.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "JEWebViewController.h"

@interface JEWebViewController ()
@property(nonatomic, strong)UIWebView *webView;
@property(nonatomic, strong)NSString  *urlStr;
@end

@implementation JEWebViewController

- (instancetype)initWithURL:(NSString*)urlStr{
    self = [super init];
    if (self) {
        self.webView = [[UIWebView alloc] init];
        self.urlStr  = urlStr;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlStr]];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
