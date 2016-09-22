//
//  WebViewController.m
//  XYLoveFreshBeen
//
//  Created by 闫世超 on 16/9/21.
//  Copyright © 2016年 闫世超. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>

@property (nonatomic ,strong) Activity *activity;
@property (nonatomic ,strong) UIWebView *webView;

@end

@implementation WebViewController

-(instancetype)initWithActivity:(Activity *)activity{
    self = [super init];
    self.activity = activity;
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.activity.name;
    self.webView = [[UIWebView alloc]init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://m.beequick.cn/show/active?id=%@&locationHash=dd89f1dQaciSSWjOXvfrV0V7EqgKmdGLU0/YJceSpQ5LLiEVS8oMovWAQ&zchtid=5624&location_time=1458523110&cityid=2&hide_cart=0&show_reload=1&activitygroup=%@&bigids=%@&__v=ios4.13",self.activity.aid,self.activity.ext_params.activitygroup,self.activity.ext_params.bigids];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]]];
    
    // Do any additional setup after loading the view.
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(nonnull NSError *)error{
    NSLog(@"---%@",error);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
