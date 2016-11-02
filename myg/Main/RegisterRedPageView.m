//
//  RegisterRedPageView.m
//  myg
//
//  Created by 李艳楠 on 16/10/17.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "RegisterRedPageView.h"

@implementation RegisterRedPageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    
    self.backgroundColor = [UIColor colorWithHexString:@"#fde9c9"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redpage_s"]];
    imageView.frame = CGRectMake(33, 38*0.5-imageView.image.size.height*0.5, imageView.image.size.width, imageView.image.size.height);
    [self addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.size.width+imageView.frame.origin.x+10, 0, self.frame.size.width-100, 38)];
    label.text = @"注册送大红包,力助夺宝！";
//    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithHexString:@"#955012"];
    label.font = [UIFont systemFontOfSize:14];
    [self addSubview:label];
    
    
    
    
    
    
}

@end
