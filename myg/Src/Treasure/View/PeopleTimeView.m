//
//  PeopleTimeView.m
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "PeopleTimeView.h"
#import "SVProgressHUD.h"
@interface PeopleTimeView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UITextField *sumText;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *firstTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *secendTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *tailTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *settleBtn;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (nonatomic,assign)CGFloat lowValue;

@end

@implementation PeopleTimeView
- (IBAction)firstTimeAction:(UIButton *)sender {
    [self createLayerBoardLineWith:sender];
    [self createNormalBoardLineWith:self.secendTimeBtn];
    [self createNormalBoardLineWith:self.thirdTimeBtn];
    [self createNormalBoardLineWith:self.tailTimeBtn];
    [self setUpTimeTextFieldAndRateLabelWith:sender];
}
- (IBAction)secendTimeAction:(UIButton *)sender {
    [self createLayerBoardLineWith:sender];
    [self createNormalBoardLineWith:self.firstTimeBtn];
    [self createNormalBoardLineWith:self.thirdTimeBtn];
    [self createNormalBoardLineWith:self.tailTimeBtn];
    [self setUpTimeTextFieldAndRateLabelWith:sender];
}

- (IBAction)thirdTimeAction:(UIButton *)sender {
    [self createLayerBoardLineWith:sender];
    [self createNormalBoardLineWith:self.secendTimeBtn];
    [self createNormalBoardLineWith:self.firstTimeBtn];
    [self createNormalBoardLineWith:self.tailTimeBtn];
    [self setUpTimeTextFieldAndRateLabelWith:sender];
}
- (IBAction)tailTimeAction:(UIButton *)sender {
    [self createLayerBoardLineWith:sender];
    [self createNormalBoardLineWith:self.secendTimeBtn];
    [self createNormalBoardLineWith:self.thirdTimeBtn];
    [self createNormalBoardLineWith:self.firstTimeBtn];
    [self setUpTimeTextFieldAndRateLabelWith:sender];
}
- (IBAction)subAction:(UIButton *)sender {
    [self setUpAllTimeBtnNormalColorAndBoardLine];
//#warning 人次达到按钮数量 未处理
    NSInteger currentTime = [self.sumText.text integerValue];
    currentTime--;
    if (currentTime == 0) {
        [SVProgressHUD showErrorWithStatus:@"不能低于最小人次!"];
        self.sumText.text = @"1";
    }else{
       self.sumText.text = [NSString stringWithFormat:@"%zd",currentTime];
        
        if ([self.sumText.text isEqualToString:self.firstTimeBtn.titleLabel.text]) {
            [self createLayerBoardLineWith:self.firstTimeBtn];
        }else{
            [self createNormalBoardLineWith:self.firstTimeBtn];
        }
        if ([self.sumText.text isEqualToString:self.secendTimeBtn.titleLabel.text]) {
            [self createLayerBoardLineWith:self.secendTimeBtn];
        }else{
            [self createNormalBoardLineWith:self.secendTimeBtn];
        }
        if ([self.sumText.text isEqualToString:self.thirdTimeBtn.titleLabel.text]) {
            [self createLayerBoardLineWith:self.thirdTimeBtn];
        }else{
            [self createNormalBoardLineWith:self.thirdTimeBtn];
        }
    }
//    self.sumText.text = [NSString stringWithFormat:@"%zd",currentTime];
    
    [self calculateRateWithText];
    
}
- (IBAction)addAction:(UIButton *)sender {
    [self setUpAllTimeBtnNormalColorAndBoardLine];
    NSInteger currentTime = [self.sumText.text integerValue];
    currentTime++;
    if (currentTime >= [[UserDataSingleton userInformation].listModel.shengyurenshu integerValue]) {
        self.sumText.text = [NSString stringWithFormat:@"%@",[UserDataSingleton userInformation].listModel.shengyurenshu];
        [self createLayerBoardLineWith:self.tailTimeBtn];
        [SVProgressHUD showSuccessWithStatus2:@"已包尾!"];
    }else{
        self.sumText.text = [NSString stringWithFormat:@"%zd",currentTime];
        if ([self.sumText.text isEqualToString:self.firstTimeBtn.titleLabel.text]) {
            [self createLayerBoardLineWith:self.firstTimeBtn];
        }else{
            [self createNormalBoardLineWith:self.firstTimeBtn];
        }
        if ([self.sumText.text isEqualToString:self.secendTimeBtn.titleLabel.text]) {
            [self createLayerBoardLineWith:self.secendTimeBtn];
        }else{
            [self createNormalBoardLineWith:self.secendTimeBtn];
        }
        if ([self.sumText.text isEqualToString:self.thirdTimeBtn.titleLabel.text]) {
            [self createLayerBoardLineWith:self.thirdTimeBtn];
        }else{
            [self createNormalBoardLineWith:self.thirdTimeBtn];
        }
    }
    [self calculateRateWithText];
}
- (void)setUpAllTimeBtnNormalColorAndBoardLine{
    
    [self createNormalBoardLineWith:self.firstTimeBtn];
    [self createNormalBoardLineWith:self.secendTimeBtn];
    [self createNormalBoardLineWith:self.thirdTimeBtn];
    [self createNormalBoardLineWith:self.tailTimeBtn];
}
- (void)setUpTimeTextFieldAndRateLabelWith:(UIButton *)sender{
    
    if ([sender.titleLabel.text isEqualToString:@"包尾"]) {
        self.sumText.text = [UserDataSingleton userInformation].listModel.shengyurenshu;
        CGFloat ratio = [self.sumText.text floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue];
//        self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
        if (ratio < 0.01) {
            self.rateLabel.text = @"中奖率低于1%";
        }else{
            self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
        }
    }else{
        
        if ([[UserDataSingleton userInformation].listModel.shengyurenshu integerValue] <= [sender.titleLabel.text integerValue]) {
            self.sumText.text = [UserDataSingleton userInformation].listModel.shengyurenshu;
            CGFloat ratio = [self.sumText.text floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue];
//            self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
            if (ratio < 0.01) {
                self.rateLabel.text = @"中奖率低于1%";
            }else{
                self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
            }
            [self createLayerBoardLineWith:self.tailTimeBtn];
            [self createNormalBoardLineWith:sender];
            [SVProgressHUD showSuccessWithStatus2:@"剩余人数不足，自动调整为包尾人次!"];
            
        }else{
            self.sumText.text = sender.titleLabel.text;
            CGFloat ratio = [self.sumText.text floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue];
//            self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
            if (ratio < 0.01) {
                self.rateLabel.text = @"中奖率低于1%";
            }else{
                self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
            }
        }
        
    }
}
- (void)calculateRateWithText{
    
    CGFloat ratio = [self.sumText.text floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue];
//    self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
    if (ratio < 0.01) {
        self.rateLabel.text = @"中奖率低于1%";
    }else{
        self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
    }
}
- (void)awakeFromNib{
    [super awakeFromNib];
    [self setUpUI];
}
/**
 初始化UI
 */
- (void)setUpUI{
    self.sumText.returnKeyType = UIReturnKeyDone;
    self.sumText.keyboardType = UIKeyboardTypeNumberPad;
    self.sumText.textAlignment = NSTextAlignmentCenter;
    self.sumText.delegate = self;
    
    self.rateLabel.textColor = [UIColor colorWithHexString:@"#de2f50"];
    
    [self setUpRateWithRequestData];
    
    [self calculateDegaultValue];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(followAction) name:@"followBuyNotification" object:nil];

}
- (void)followAction{
    
    DebugLog(@"--follow---");
    
    
    [self setUpAllTimeBtnNormalColorAndBoardLine];
    
    if ([[UserDataSingleton userInformation].oldPtime integerValue] >= [[UserDataSingleton userInformation].listModel.shengyurenshu integerValue]) {//包尾
        self.sumText.text = [UserDataSingleton userInformation].listModel.shengyurenshu;
        self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%@",[UserDataSingleton userInformation].oldRate];
        [self createLayerBoardLineWith:self.tailTimeBtn];
    }else{
        self.sumText.text = [UserDataSingleton userInformation].oldPtime;
        self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%@",[UserDataSingleton userInformation].oldRate];
        if ([[UserDataSingleton userInformation].oldPtime isEqualToString:self.firstTimeBtn.titleLabel.text] ) {
            [self createLayerBoardLineWith:self.firstTimeBtn];
        }
        if ([[UserDataSingleton userInformation].oldPtime isEqualToString:self.secendTimeBtn.titleLabel.text] ) {
            [self createLayerBoardLineWith:self.secendTimeBtn];
        }
        if ([[UserDataSingleton userInformation].oldPtime isEqualToString:self.thirdTimeBtn.titleLabel.text] ) {
            [self createLayerBoardLineWith:self.thirdTimeBtn];
        }
    }
}
- (void)setUpRateWithRequestData{
    NSInteger prize = [[UserDataSingleton userInformation].listModel.zongrenshu integerValue];
    if (prize > 1 && prize <= 99 ) {
        [self.firstTimeBtn setTitle:@"5" forState:UIControlStateNormal];
        [self.secendTimeBtn setTitle:@"10" forState:UIControlStateNormal];
        [self.thirdTimeBtn setTitle:@"20" forState:UIControlStateNormal];
    }else if (prize > 99 && prize <= 999){
        [self.firstTimeBtn setTitle:@"50" forState:UIControlStateNormal];
        [self.secendTimeBtn setTitle:@"100" forState:UIControlStateNormal];
        [self.thirdTimeBtn setTitle:@"200" forState:UIControlStateNormal];
    }else if (prize >= 1000){
        [self.firstTimeBtn setTitle:@"100" forState:UIControlStateNormal];
        [self.secendTimeBtn setTitle:@"200" forState:UIControlStateNormal];
        [self.thirdTimeBtn setTitle:@"500" forState:UIControlStateNormal];
    }
    
    if ([[UserDataSingleton userInformation].listModel.shengyurenshu integerValue] < [self.firstTimeBtn.titleLabel.text integerValue]) {
        self.firstTimeBtn.enabled = NO;
        [self noEnabledWith:self.firstTimeBtn];
    }
    if ([[UserDataSingleton userInformation].listModel.shengyurenshu integerValue] < [self.firstTimeBtn.titleLabel.text integerValue]) {
        self.secendTimeBtn.enabled = NO;
        [self noEnabledWith:self.secendTimeBtn];
    }
    if ([[UserDataSingleton userInformation].listModel.shengyurenshu integerValue] < [self.firstTimeBtn.titleLabel.text integerValue]) {
        self.thirdTimeBtn.enabled = NO;
        [self noEnabledWith:self.thirdTimeBtn];
    }
}
- (void)noEnabledWith:(UIButton *)sender{
    sender.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    sender.layer.borderWidth = 1;
    [sender setTitleColor:[UIColor colorWithHexString:@"#939393"] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
}

/**
 计算默认值
 */
- (void)calculateDegaultValue{
    NSInteger surplus = [[UserDataSingleton userInformation].listModel.shengyurenshu integerValue];
    
    if (surplus <= [self.firstTimeBtn.titleLabel.text integerValue]) {
        self.sumText.text = @"1";
        
        CGFloat ratio = [self.sumText.text floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue];
//        NSInteger endRatio = ratio * 100;
//        self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
//        self.rateLabel.text = @"中奖率低于1%";
        if (ratio < 0.01) {
            self.rateLabel.text = @"中奖率低于1%";
        }else{
            self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
        }
    }else{
        self.sumText.text = self.firstTimeBtn.titleLabel.text;
        
        CGFloat ratio = [self.sumText.text floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue];
//        NSInteger endRatio = ratio * 100;
        self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
    }
}
/**
 截取字符串，并转化成小数

 @param string
 */
- (CGFloat)transformWithString:(NSString *)string{
    NSString *newString = [string substringToIndex:2];
    CGFloat number = [newString integerValue] * 0.01;
    return number;
}
- (IBAction)settleAction:(id)sender {
    DebugLog(@"-----结算-----");
    DebugLog(@"-----结算-----");
    ShoppingModel *model = [UserDataSingleton userInformation].shopModel;
    model.num = [self.sumText.text integerValue];
    [UserDataSingleton userInformation].shopModel = model;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(peopleTimeView:good:)]) {
        [self.delegate peopleTimeView:self good:[UserDataSingleton userInformation].shopModel];
    }    
}
#pragma mark <UITextFieldDelegate>
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.sumText resignFirstResponder];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    DebugLog(@"-----停止输入-%@-----",textField.text);
    NSInteger endValue = [textField.text integerValue];
    if (endValue == 0) {
        textField.text  = @"1";
    }else{
        if (endValue >= [[UserDataSingleton userInformation].listModel.shengyurenshu integerValue]){
            textField.text  = [NSString stringWithFormat:@"%@",[UserDataSingleton userInformation].listModel.shengyurenshu];
            [self createLayerBoardLineWith:self.tailTimeBtn];
        }else{
            if ([textField.text isEqualToString:self.firstTimeBtn.titleLabel.text]) {
                [self createLayerBoardLineWith:self.firstTimeBtn];
            }else{
                [self createNormalBoardLineWith:self.firstTimeBtn];
            }
            if ([textField.text isEqualToString:self.secendTimeBtn.titleLabel.text]) {
                [self createLayerBoardLineWith:self.secendTimeBtn];
            }else{
                [self createNormalBoardLineWith:self.secendTimeBtn];
            }
            if ([textField.text isEqualToString:self.thirdTimeBtn.titleLabel.text]) {
                [self createLayerBoardLineWith:self.thirdTimeBtn];
            }else{
                [self createNormalBoardLineWith:self.thirdTimeBtn];
            }
        }
    }
    CGFloat ratio = [textField.text floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue];
//    NSInteger endRatio = ratio * 100;
    if (ratio < 0.01) {
        self.rateLabel.text = @"中奖率低于1%";
    }else{
        self.rateLabel.text = [NSString stringWithFormat:@"中奖率高于%.2f%%",ratio * 100];
    }
    
    
    
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    DebugLog(@"----开始编辑----");
    [self setUpAllTimeBtnNormalColorAndBoardLine];
}
- (void)createLayerBoardLineWith:(UIButton *)view{
    [view setTitleColor:[UIColor colorWithHexString:@"#de2f50"] forState:UIControlStateNormal];
    view.layer.borderColor = [UIColor colorWithHexString:@"#de2f50"].CGColor;
    view.layer.borderWidth = 1;
}
- (void)createNormalBoardLineWith:(UIButton *)view{
    [view setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    view.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    view.layer.borderWidth = 1;
    
}




@end
