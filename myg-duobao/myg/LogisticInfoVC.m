//
//  LogisticInfoVC.m
//  myg
//
//  Created by Apple on 16/8/25.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "LogisticInfoVC.h"


@interface LogisticInfoVC ()
@property (nonatomic,strong)UIWebView *logInfoWebView;
@end

@implementation LogisticInfoVC

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.title = @"物流信息";
    
    
    
    DebugLog(@"%@",self.commanyType);
    
    self.logInfoWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:self.logInfoWebView];
    
    NSString *str = [self encodeToPercentEscapeString:self.commanyType];
    
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.miyungou.com/api/kuaidi.php?type=%@&postid=%@#result",str,self.orderCode]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.logInfoWebView loadRequest:request];
    
    
    
    
}
- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    NSString *outputStr = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(
                                                                                       NULL, /* allocator */
                                                                                       (__bridge CFStringRef)input,
                                                                                       NULL, /* charactersToLeaveUnescaped */
                                                                                       (CFStringRef)@"!*'();:@&=+$,/?%#[]",kCFStringEncodingUTF8);
    return
    outputStr;
}

@end
