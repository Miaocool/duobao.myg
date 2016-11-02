//
//  WinRateView.m
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "WinRateView.h"

@interface WinRateView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *subtBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *rateText;
@property (weak, nonatomic) IBOutlet UIButton *fisrtRateBtn;
@property (weak, nonatomic) IBOutlet UIButton *secendRateBtn;
@property (weak, nonatomic) IBOutlet UIButton *thirdRateBtn;
@property (weak, nonatomic) IBOutlet UIButton *tailRateBtn;
@property (weak, nonatomic) IBOutlet UILabel *sumRate;
@property (weak, nonatomic) IBOutlet UIButton *partakeRateBtn;
@property (nonatomic,assign)CGFloat lowValue;
@end

@implementation WinRateView

- (IBAction)firstRateAction:(UIButton *)sender {
    
    [self calculatePtimeWith:sender];
    
}
- (IBAction)secendRateAction:(UIButton *)sender {
    
    [self calculatePtimeWith:sender];
    
}
- (IBAction)thirdRateAction:(UIButton *)sender {
    
    [self calculatePtimeWith:sender];
    
}
- (IBAction)tailRateAction:(UIButton *)sender {
    [self calculatePtimeWith:sender];
    
}

- (IBAction)subBtnAction:(UIButton *)sender {
    
    CGFloat currentRate = [self.rateText.text floatValue];
    currentRate--;
    
    if (self.lowValue < 0.01) {
        [SVProgressHUD showErrorWithStatus:@"请到经典模式购买!"];
    }else{
        if (currentRate == 0) {
            [SVProgressHUD showErrorWithStatus:@"不能低于最小人次!"];
            self.rateText.text = @"1%";
        }else{
            if (currentRate == [self.fisrtRateBtn.titleLabel.text floatValue]) {
                [self createLayerBoardLineWith:self.fisrtRateBtn];
            }else{
                [self createNormalBoardLineWith:self.fisrtRateBtn];
            }
            if (currentRate == [self.secendRateBtn.titleLabel.text floatValue]){
                [self createLayerBoardLineWith:self.secendRateBtn];
            }else {
                [self createNormalBoardLineWith:self.secendRateBtn];
            }
            if (currentRate == [self.thirdRateBtn.titleLabel.text floatValue]){
                [self createLayerBoardLineWith:self.thirdRateBtn];
            }else{
                [self createNormalBoardLineWith:self.thirdRateBtn];
            }
            if (currentRate * 0.01 < self.lowValue) {
                [self createNormalBoardLineWith:self.tailRateBtn];
            }else{
                
            }
            
            self.rateText.text = [NSString stringWithFormat:@"%.f%%",currentRate];
        }
        
        [self calculatePtimWithRate:self.rateText.text];
        
    }
}
- (IBAction)addBtnAction:(UIButton *)sender {
    CGFloat currentRate = [self.rateText.text floatValue];
    currentRate++;
    
    if (self.lowValue < 0.01) {
        [SVProgressHUD showErrorWithStatus:@"请到经典模式购买!"];
    }else{
        if (currentRate * 0.01 >= self.lowValue) {
            self.rateText.text = [NSString stringWithFormat:@"%.f%%",self.lowValue * 100];
            [self createLayerBoardLineWith:self.tailRateBtn];
//            self.sumRate.text = [NSString stringWithFormat:@"%@  人次",[UserDataSingleton userInformation].listModel.shengyurenshu];

            
            NSString *string = [UserDataSingleton userInformation].listModel.shengyurenshu;
            NSAttributedString * attstring = [self setUpTextColorWith:[NSString stringWithFormat:@"%@  人次",string] length:string.length];
            self.sumRate.attributedText = attstring;
            
            [SVProgressHUD showSuccessWithStatus2:@"已包尾!"];
        }else{
            if (currentRate == [self.fisrtRateBtn.titleLabel.text floatValue]) {
                [self createLayerBoardLineWith:self.fisrtRateBtn];
            }else{
                [self createNormalBoardLineWith:self.fisrtRateBtn];
            }
                if (currentRate == [self.secendRateBtn.titleLabel.text floatValue]){
                [self createLayerBoardLineWith:self.secendRateBtn];
                }else {
                    [self createNormalBoardLineWith:self.secendRateBtn];
                }
            if (currentRate == [self.thirdRateBtn.titleLabel.text floatValue]){
                [self createLayerBoardLineWith:self.thirdRateBtn];
            }else{
                [self createNormalBoardLineWith:self.thirdRateBtn];
            }
            self.rateText.text = [NSString stringWithFormat:@"%.f%%",currentRate];
            [self calculatePtimWithRate:self.rateText.text];
        }
        
    }
}
- (void)calculatePtimeWith:(UIButton *)eachButton{
    
    if ([eachButton.titleLabel.text isEqualToString:@"包尾"]) {
        
        self.rateText.text  = [NSString stringWithFormat:@"%zd%%",(NSInteger)(self.lowValue * 100)];
//        self.sumRate.text = [NSString stringWithFormat:@"%@  人次",[UserDataSingleton userInformation].listModel.shengyurenshu];
        
        NSString *string = [UserDataSingleton userInformation].listModel.shengyurenshu;
        NSAttributedString * attstring = [self setUpTextColorWith:[NSString stringWithFormat:@"%@  人次",string] length:string.length];
        self.sumRate.attributedText = attstring;
        [self createLayerBoardLineWith:eachButton];
        [self createNormalBoardLineWith:self.fisrtRateBtn];
        [self createNormalBoardLineWith:self.secendRateBtn];
        [self createNormalBoardLineWith:self.thirdRateBtn];
    }else{
        if (self.lowValue < 0.01) {
            [SVProgressHUD showErrorWithStatus:@"请到经典模式购买!"];
        }else{
            if (([eachButton.titleLabel.text floatValue] * 0.01 * [[UserDataSingleton userInformation].listModel.zongrenshu integerValue] >= [[UserDataSingleton userInformation].listModel.shengyurenshu integerValue])) {
                self.rateText.text  = [NSString stringWithFormat:@"%zd",(NSInteger)(self.lowValue * 100 + 1)];
//                self.sumRate.text = [UserDataSingleton userInformation].listModel.shengyurenshu;
                
                NSString *string = [UserDataSingleton userInformation].listModel.shengyurenshu;
                NSAttributedString * attstring = [self setUpTextColorWith:[NSString stringWithFormat:@"%@  人次",string] length:string.length];
                self.sumRate.attributedText = attstring;
                [self createLayerBoardLineWith:self.tailRateBtn];
            }else{
                self.rateText.text = [NSString stringWithFormat:@"%@",eachButton.titleLabel.text];
                self.sumRate.text = [UserDataSingleton userInformation].listModel.shengyurenshu;
                [self createLayerBoardLineWith:eachButton];
                
                if (![eachButton isEqual:self.tailRateBtn]) {
                    [self createNormalBoardLineWith:self.tailRateBtn];
                }
                if (![eachButton isEqual:self.fisrtRateBtn]) {
                    [self createNormalBoardLineWith:self.fisrtRateBtn];
                }
                if (![eachButton isEqual:self.secendRateBtn]) {
                    [self createNormalBoardLineWith:self.secendRateBtn];
                }
                if (![eachButton isEqual:self.thirdRateBtn]) {
                    [self createNormalBoardLineWith:self.thirdRateBtn];
                }
            }
        }
        
        [self calculatePtimWithRate:self.rateText.text];
        
    }
}
- (void)calculatePtimWithRate:(NSString *)rate{
    NSInteger finalPtime = 0;
    CGFloat f1 = ([[UserDataSingleton userInformation].listModel.zongrenshu floatValue] * ([rate floatValue]*0.01));
    NSInteger f2 = ((NSInteger)[[UserDataSingleton userInformation].listModel.zongrenshu floatValue] * ([rate floatValue]*0.01));
    CGFloat ff = f1 / f2;
    if (ff == 1) {
        finalPtime = (NSInteger)(f2);
    }else{
        finalPtime = (NSInteger)(f2 + 1);
    }
//    self.sumRate.text = [NSString stringWithFormat:@"%zd  人次",finalPtime];
    
    NSString *string = [NSString stringWithFormat:@"%zd",finalPtime];
    NSAttributedString * attstring = [self setUpTextColorWith:[NSString stringWithFormat:@"%@  人次",string] length:string.length];
    self.sumRate.attributedText = attstring;
}
/**
 *立即参与
 */
- (IBAction)partakeRateAction:(id)sender {
    DebugLog(@"-----结算-----");
    ShoppingModel *model = [UserDataSingleton userInformation].shopModel;
    model.num = [self.sumRate.text integerValue];
    [UserDataSingleton userInformation].shopModel = model;
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(winRateView:goodModel:)]) {
        [self.delegate winRateView:self goodModel:[UserDataSingleton userInformation].shopModel];
    }
}
- (void)awakeFromNib{
    
    [super awakeFromNib];
    [self setUpUI];

    
    
    
    
}
- (void)setUpUI{
    self.subtBtn.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    self.subtBtn.layer.borderWidth = 1;
    self.rateText.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    self.rateText.layer.borderWidth = 1;
    self.addBtn.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    self.addBtn.layer.borderWidth = 1;
    [self.fisrtRateBtn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    [self.secendRateBtn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    [self.thirdRateBtn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    [self.tailRateBtn setTitleColor:[UIColor colorWithHexString:@"#040404"] forState:UIControlStateNormal];
    self.fisrtRateBtn.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    self.fisrtRateBtn.layer.borderWidth = 1;
    self.secendRateBtn.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    self.secendRateBtn.layer.borderWidth = 1;
    self.thirdRateBtn.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    self.thirdRateBtn.layer.borderWidth = 1;
    self.tailRateBtn.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    self.tailRateBtn.layer.borderWidth = 1;
    self.rateText.returnKeyType = UIReturnKeyDone;
    self.rateText.delegate = self;
    self.rateText.textAlignment = NSTextAlignmentCenter;
    self.rateText.keyboardType = UIKeyboardTypeNumberPad;
    [self setUpRateWithRequestData];
    
    [self calculateDegaultValue];
    
}
- (void)setUpRateWithRequestData{
    
    
    NSInteger prize = [[UserDataSingleton userInformation].listModel.zongrenshu integerValue];
    if (prize > 1 && prize <= 99 ) {
        [self.fisrtRateBtn setTitle:@"10%" forState:UIControlStateNormal];
        [self.secendRateBtn setTitle:@"25%" forState:UIControlStateNormal];
        [self.thirdRateBtn setTitle:@"40%" forState:UIControlStateNormal];
    }else if (prize > 99 && prize <= 999){
        [self.fisrtRateBtn setTitle:@"10%" forState:UIControlStateNormal];
        [self.secendRateBtn setTitle:@"20%" forState:UIControlStateNormal];
        [self.thirdRateBtn setTitle:@"30%" forState:UIControlStateNormal];
    }else if (prize >= 1000){
        [self.fisrtRateBtn setTitle:@"10%" forState:UIControlStateNormal];
        [self.secendRateBtn setTitle:@"15%" forState:UIControlStateNormal];
        [self.thirdRateBtn setTitle:@"25%" forState:UIControlStateNormal];
    }
}
/**
 计算默认值
 */
- (void)calculateDegaultValue{
    NSString *surplus = [UserDataSingleton userInformation].listModel.shengyurenshu;
    NSString *sumPtime = [UserDataSingleton userInformation].listModel.zongrenshu;
    CGFloat ratio = [surplus floatValue] / [sumPtime floatValue];
    if (ratio >= 0.01 && ratio < 0.1) {
        self.rateText.text = @"1%";
    }else if (ratio >= 0.1){
        self.rateText.text = @"10%";
    }else if (ratio < 0.01){
        
    }
    self.lowValue = ratio;
    NSInteger initPtime = 0;
    CGFloat f1 = ([[UserDataSingleton userInformation].listModel.shengyurenshu floatValue] * ([self.rateText.text floatValue] * 0.01));
    NSInteger f2 = ((NSInteger)[[UserDataSingleton userInformation].listModel.shengyurenshu floatValue] * ([self.rateText.text floatValue] * 0.01));
    CGFloat ff = f1 / f2;
    if (ff == 1) {
        initPtime = (NSInteger)(f2);
    }else{
        initPtime = (NSInteger)(f2 + 1);
    }
    
    NSString *string = [NSString stringWithFormat:@"%zd",initPtime];
    NSAttributedString * attstring = [self setUpTextColorWith:[NSString stringWithFormat:@"%@  人次",string] length:string.length];
    self.sumRate.attributedText = attstring;
    DebugLog(@"%f",[self.rateText.text floatValue]);
    
    
    if (ratio < [self.fisrtRateBtn.titleLabel.text floatValue] * 0.01) {
        self.fisrtRateBtn.enabled = NO;
        [self noEnabledWith: self.fisrtRateBtn];
    }
    if (ratio < [self.thirdRateBtn.titleLabel.text floatValue] * 0.01) {
        self.thirdRateBtn.enabled = NO;
        [self noEnabledWith: self.thirdRateBtn];
    }
    if (ratio < [self.secendRateBtn.titleLabel.text floatValue] * 0.01) {
        self.secendRateBtn.enabled = NO;
        [self noEnabledWith: self.secendRateBtn];
    } 
}
- (void)noEnabledWith:(UIButton *)sender{
    sender.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    sender.layer.borderWidth = 1;
    [sender setTitleColor:[UIColor colorWithHexString:@"#939393"] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
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
#pragma mark <UITextFieldDelegate>
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.rateText resignFirstResponder];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self createNormalBoardLineWith:self.fisrtRateBtn];
    [self createNormalBoardLineWith:self.secendRateBtn];
    [self createNormalBoardLineWith:self.thirdRateBtn];
    [self createNormalBoardLineWith:self.tailRateBtn];
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    DebugLog(@"-----停止输入------");
    NSInteger finalPtime = 0;
    CGFloat endValue = [textField.text floatValue] * 0.01;
    
    if (self.lowValue < 0.01) {
        [SVProgressHUD showErrorWithStatus:@"请到经典模式购买！"];
    }else{
        
        if ([textField.text floatValue] == 0) {
            [SVProgressHUD showErrorWithStatus:@"不能低于最小%1！"];
            textField.text  = @"1%";
            [self calculatePtimWithRate:textField.text];
        }else{
            if (endValue >= self.lowValue){
                textField.text  = [NSString stringWithFormat:@"%zd%%",(NSInteger)(self.lowValue * 100 + 1)];
                self.sumRate.text = [UserDataSingleton userInformation].listModel.shengyurenshu;
                [self createLayerBoardLineWith:self.tailRateBtn];
                [self createNormalBoardLineWith:self.fisrtRateBtn];
                [self createNormalBoardLineWith:self.secendRateBtn];
                [self createNormalBoardLineWith:self.thirdRateBtn];
            }else{
                
                if (textField.text.length == 2) {
                    textField.text  = [NSString stringWithFormat:@"%@%%",[textField.text substringToIndex:1]];
                }else{
                    textField.text  = [NSString stringWithFormat:@"%@%%",[textField.text substringToIndex:2]];
                }
//                textField.text  = [NSString stringWithFormat:@"%@%%",[textField.text substringToIndex:2]];
                if ([textField.text isEqualToString:self.fisrtRateBtn.titleLabel.text]) {
                    [self createLayerBoardLineWith:self.fisrtRateBtn];
                }else{
                    [self createNormalBoardLineWith:self.fisrtRateBtn];
                }
                if ([textField.text isEqualToString:self.secendRateBtn.titleLabel.text]) {
                    [self createLayerBoardLineWith:self.secendRateBtn];
                }else{
                    [self createNormalBoardLineWith:self.secendRateBtn];
                }
                if ([textField.text isEqualToString:self.thirdRateBtn.titleLabel.text]) {
                    [self createLayerBoardLineWith:self.thirdRateBtn];
                }else{
                    [self createNormalBoardLineWith:self.thirdRateBtn];
                }
                
                CGFloat f1 = ([[UserDataSingleton userInformation].listModel.zongrenshu floatValue] * endValue);
                NSInteger f2 = ((NSInteger)[[UserDataSingleton userInformation].listModel.zongrenshu floatValue] * endValue);
                CGFloat ff = f1 / f2;
                if (ff == 1) {
                    finalPtime = (NSInteger)(f2);
                }else{
                    finalPtime = (NSInteger)(f2 + 1);
                }
                NSString *string = [NSString stringWithFormat:@"%zd",finalPtime];
                NSAttributedString * attstring = [self setUpTextColorWith:[NSString stringWithFormat:@"%@  人次",string] length:string.length];
                self.sumRate.attributedText = attstring;
            }
        }
    }
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

- (NSMutableAttributedString *)setUpTextColorWith:(NSString *)ptime length:(NSInteger )length{
    
    NSMutableAttributedString *attribute = [[NSMutableAttributedString alloc]initWithString:ptime];
    NSRange range = NSMakeRange(0, length);
    [attribute addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#de2f50"] range:range];
    
    return attribute;
}


@end
