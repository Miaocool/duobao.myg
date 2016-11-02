//
//  BettingToolView.m
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "BettingToolView.h"

typedef enum : NSUInteger {
    NormalColorR = 4,
    NormalColorG = 4,
    NormalColorB = 4,
} NormalColor;
typedef enum : NSUInteger {
    SelectColorR = 201,
    SelectColorG = 60,
    SelectColorB = 80,
} SelectColor;

@interface BettingToolView ()
/** 经典模式 */
@property (weak, nonatomic) IBOutlet UIButton *classicsBtn;
/** 中奖参谋 */
@property (weak, nonatomic) IBOutlet UIButton *staffBtn;

@property (nonatomic,assign)NSInteger currentTag;


@property (nonatomic,assign)CGFloat lineViewX;
@property (nonatomic,assign)CGFloat lineViewW;
@end

@implementation BettingToolView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUpUI];
}
- (void)setUpUI{
    self.classicsBtn.tag = 100;
    self.staffBtn.tag = 101;
    self.heighRateBtn.tag = 102;
    _currentTag = 100;
    [self.classicsBtn setTitleColor:[UIColor colorWithHexString:@"#da264d"] forState:UIControlStateNormal];
    [self.classicsBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.staffBtn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    [self.staffBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.heighRateBtn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    [self.heighRateBtn addTarget:self action:@selector(allBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
    
    
}

- (void)allBtnAction:(UIButton *)cilck{
    if (cilck.tag == _currentTag) {
        return;
    }else{
        
        UIButton *btn = (UIButton *)[self viewWithTag:_currentTag];
        [btn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
        
        
        [cilck setTitleColor:[UIColor colorWithHexString:@"#da264d"] forState:UIControlStateNormal];
        _currentTag = cilck.tag;
        CGRect frame = _lineView.frame;
        frame.origin.x = cilck.frame.origin.x;
        frame.size.width = cilck.frame.size.width;
        [UIView animateWithDuration:0.2 animations:^{
            _lineView.frame = frame;
        }];
        
    }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(bettingToolView:index:)]) {
        [self.delegate bettingToolView:self index:_currentTag-100];
    }
}

- (void)changeSecendBtnStateWith:(NSInteger)tag{
    
    UIButton *button = [self viewWithTag:tag];
    
    [self allBtnAction:button];
}

- (void)setTitleWithSourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex progress:(CGFloat)progress{
    
    DebugLog(@"sour: %zd,----tar: %zd",sourceIndex,targetIndex);
    UIButton *sourceBtn= [self viewWithTag:sourceIndex + 100];
    UIButton *targetBtn = [self viewWithTag:targetIndex + 100];
    
    CGRect frame = self.lineView.frame;
    frame.origin.x = targetBtn.frame.origin.x;
    [UIView animateWithDuration:0.15 animations:^{
        self.lineView.frame = frame;
    }];
//    NSInteger colorR = SelectColorR - NormalColorR;
//    NSInteger colorG = SelectColorG - NormalColorG;
//    NSInteger colorB = SelectColorB - NormalColorB;
//    [sourceBtn setTitleColor:[UIColor colorWithRed:(SelectColorR - colorR*progress)/255.0 green:(SelectColorG - colorG*progress)/255.0 blue:(SelectColorB - colorB*progress)/255.0 alpha:1.0] forState:UIControlStateNormal];
//    [targetBtn setTitleColor:[UIColor colorWithRed:(NormalColorR + colorR*progress)/255.0 green:(NormalColorG + colorG*progress)/255.0 blue:(NormalColorB + colorB*progress)/255.0 alpha:1.0]
    [sourceBtn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    [targetBtn setTitleColor:[UIColor colorWithHexString:@"#da264d"] forState:UIControlStateNormal];
    _currentTag = targetIndex + 100;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    DebugLog(@"%f",self.lineView.frame.origin.x);
    
    CGRect frame = self.lineView.frame;
    frame.origin.x = self.lineViewX;
    frame.size.width = self.lineViewW;
    self.lineView.frame = frame;
    
    
}
- (void)keyboardShow{
    DebugLog(@"--show");
    
    DebugLog(@"%f",self.lineView.frame.origin.x);
    
    self.lineViewX = self.lineView.frame.origin.x;
    self.lineViewW = self.lineView.frame.size.width;
}
- (void)keyboardHide{
    DebugLog(@"--hide");
    
    self.lineViewX = self.lineView.frame.origin.x;
    self.lineViewW = self.lineView.frame.size.width;
}
@end
