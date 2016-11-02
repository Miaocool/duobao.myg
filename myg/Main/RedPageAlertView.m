//
//  RedPageAlertView.m
//  myg
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "RedPageAlertView.h"

@interface RedPageAlertView ()
@property (nonatomic,strong)UIButton *closeBtn;
@property (nonatomic,strong)UIImageView *redpageIMG;
@property (nonatomic,strong)UIButton *gainRedPageBtn;
@property (nonatomic,strong)UIButton *checkRedPageBtn;
@property (nonatomic,strong)UILabel *resultLabel;
@property (nonatomic,strong)UILabel *identLabel;
@property (nonatomic,strong)UILabel *sumMoney;
@property (nonatomic,strong)UILabel *unit;
@end
@implementation RedPageAlertView

static RedPageAlertView *redPageView = nil;
+ (instancetype)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        redPageView = [[self alloc]initWithFrame:[UIScreen mainScreen].bounds];
        redPageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [redPageView setUpUI];
    });
    return redPageView;
}
- (void)setUpUI{
    
    self.redpageIMG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"redpage_big"]];
    self.redpageIMG.frame = CGRectMake(0, 0, self.redpageIMG.image.size.width, self.redpageIMG.image.size.height);
    self.redpageIMG.center = CGPointMake(redPageView.center.x, redPageView.center.y-75);
    self.redpageIMG.alpha = 1;
    [redPageView addSubview:self.redpageIMG];

    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setImage:[UIImage imageNamed:@"redpage_close_btn"] forState:UIControlStateNormal];
    self.closeBtn.frame = CGRectMake(320, 140+40, self.closeBtn.currentImage.size.width, self.closeBtn.currentImage.size.height);
    [self.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [redPageView addSubview:self.closeBtn];
    
    self.resultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.resultLabel.text = @"恭喜获得新手红包";
    self.resultLabel.font = [UIFont systemFontOfSize:16];
    self.resultLabel.textColor = [UIColor colorWithHexString:@"#fafbcf"];
    [self.resultLabel sizeToFit];
    self.resultLabel.center = CGPointMake(redPageView.center.x, 180);
    [redPageView addSubview:self.resultLabel];
    
    self.checkRedPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.checkRedPageBtn setImage:[UIImage imageNamed:@"redpage_checkbtn_back"] forState:UIControlStateNormal];
    self.checkRedPageBtn.frame = CGRectMake(self.bounds.size.width*0.5-self.checkRedPageBtn.currentImage.size.width*0.5, self.redpageIMG.frame.origin.y+self.redpageIMG.frame.size.height+50, self.checkRedPageBtn.currentImage.size.width, self.checkRedPageBtn.currentImage.size.height);
    [self.checkRedPageBtn setTitle:@"领取红包" forState:UIControlStateNormal];
    [self.checkRedPageBtn setTitleColor:[UIColor colorWithHexString:@"#fe1602"] forState:UIControlStateNormal];
    self.checkRedPageBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [redPageView addSubview:self.checkRedPageBtn];
    
    self.checkRedPageBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -self.checkRedPageBtn.currentImage.size.width, 0, 0);
    self.checkRedPageBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -self.checkRedPageBtn.titleLabel.bounds.size.width);
    self.checkRedPageBtn.adjustsImageWhenHighlighted = NO;
    
    [self.checkRedPageBtn addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.identLabel = [[UILabel alloc]init];
    self.identLabel.text = @"红包共计";
    self.identLabel.font = [UIFont systemFontOfSize:15];
    [self.identLabel sizeToFit];
    self.identLabel.frame = CGRectMake(0, self.redpageIMG.frame.size.height-130, self.identLabel.frame.size.width, self.identLabel.frame.size.height);
    self.identLabel.textColor = [UIColor whiteColor];
    CGPoint point1 = self.identLabel.center;
    point1.x = self.checkRedPageBtn.center.x-20;
    self.identLabel.center = point1;
//    [self.redpageIMG addSubview:self.identLabel];
//    NSLog(@"%f",self.redpageIMG.frame.size.height);;
    self.sumMoney = [[UILabel alloc]init];
    self.sumMoney.text = @"26";
    [self.sumMoney sizeToFit];
    self.sumMoney.frame = CGRectMake(0, self.redpageIMG.frame.size.height-90, self.sumMoney.frame.size.width, self.sumMoney.frame.size.height);
    CGPoint point2 = self.sumMoney.center;
    point2.x = self.checkRedPageBtn.center.x-20;
    self.sumMoney.center = point2;
    self.sumMoney.textColor = [UIColor yellowColor];
    self.sumMoney.font = [UIFont systemFontOfSize:33];
    self.sumMoney.textAlignment = NSTextAlignmentCenter;
//    [self.redpageIMG addSubview:self.sumMoney];
    
    self.unit = [[UILabel alloc]init];
    self.unit.text = @"元";
    [self.unit sizeToFit];
    self.unit.frame = CGRectMake(self.sumMoney.frame.origin.x+self.sumMoney.frame.size.width, self.sumMoney.frame.origin.y+self.sumMoney.frame.size.height-self.unit.frame.size.height-10, self.unit.frame.size.width, self.unit.frame.size.height);
//    [self.redpageIMG addSubview:self.unit];
    self.unit.textColor = [UIColor whiteColor];
}
- (void)showWithState:(BOOL)state checkTitle:(NSString *)title imageName:(NSString *)imageName{
    redPageView.resultLabel.hidden = state;
    redPageView.redpageIMG.image = [UIImage imageNamed:imageName];
    [redPageView.checkRedPageBtn setTitle:title forState:UIControlStateNormal];

    [[UIApplication sharedApplication].keyWindow addSubview:redPageView];
}
- (void)reinstall{
    redPageView.sumMoney.text = @"";
    [redPageView.sumMoney sizeToFit];
    redPageView.sumMoney.frame = CGRectMake(0, self.redpageIMG.frame.size.height-90, self.sumMoney.frame.size.width, self.sumMoney.frame.size.height);
    redPageView.identLabel.text = @"";
    [redPageView.identLabel sizeToFit];
    redPageView.identLabel.frame = CGRectMake(0, self.redpageIMG.frame.size.height-130, self.identLabel.frame.size.width, self.identLabel.frame.size.height);
    CGPoint point2 = self.sumMoney.center;
    point2.x = self.checkRedPageBtn.center.x-20;
    redPageView.sumMoney.center = point2;
    CGPoint point1 = self.identLabel.center;
    point1.x = self.checkRedPageBtn.center.x-20;
    redPageView.identLabel.center = point1;
    
    redPageView.unit.frame = CGRectMake(self.sumMoney.frame.origin.x+self.sumMoney.frame.size.width, self.sumMoney.frame.origin.y+self.sumMoney.frame.size.height-self.unit.frame.size.height-5, self.unit.frame.size.width, self.unit.frame.size.height);
}
- (void)dismiss{
    [redPageView removeFromSuperview];
}
- (void)closeAction{
    [self dismiss];
    self.closeBlock();
}
- (void)checkAction:(UIButton *)sender{
    self.checkBlock(sender.titleLabel.text);
}
- (void)dealloc{
    self.delegate = nil;
}

@end
