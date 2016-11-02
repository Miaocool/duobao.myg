//
//  PopverPresentationController.m
//  myg
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "PopverPresentationController.h"

@interface PopverPresentationController ()
@property (nonatomic,strong)UIView *coverView;
@end


@implementation PopverPresentationController


- (instancetype)initWithPresentedViewController:(UIViewController *)presentedViewController presentingViewController:(UIViewController *)presentingViewController{
    
    if (self = [super initWithPresentedViewController:presentedViewController presentingViewController:presentingViewController]) {
        
    }
    return self;
}
- (void)containerViewWillLayoutSubviews{
    self.presentedView.frame = self.pressentRect;
    
    [self.presentedView insertSubview:self.coverView atIndex:0];    
}
- (UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
        [_coverView addGestureRecognizer:tapGR];
        
    }
    return _coverView;
}
- (void)close{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
