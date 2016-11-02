//
//  TheWiningCell.m
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "TheWiningCell.h"

@interface TheWiningCell()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userBuyPtime;
@property (weak, nonatomic) IBOutlet UILabel *userWinRate;
@property (weak, nonatomic) IBOutlet UIButton *userBuy;

@property (weak, nonatomic) IBOutlet UILabel *identName;
@property (weak, nonatomic) IBOutlet UILabel *identPtime;
@property (weak, nonatomic) IBOutlet UILabel *identWinRate;

@end


@implementation TheWiningCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setUpUI];
    
    
}
- (void)setUpUI{
    
    UIView *selectView = [[UIView alloc]initWithFrame:self.bounds];
    selectView.backgroundColor = [UIColor clearColor];
    
    self.selectedBackgroundView = selectView;
    
    self.userIcon.layer.cornerRadius = 28.5;
    self.userIcon.layer.masksToBounds = YES;
    
    self.userWinRate.textColor = [UIColor colorWithHexString:@"#de2f50"];
    self.userBuyPtime.textColor = [UIColor colorWithHexString:@"#de2f50"];
     self.userName.textColor = [UIColor colorWithHexString:@"#de2f50"];
    
    
    self.identName.textColor = [UIColor colorWithHexString:@"#939393"];
    self.identPtime.textColor = [UIColor colorWithHexString:@"#939393"];
    self.identWinRate.textColor = [UIColor colorWithHexString:@"#939393"];
    
    
}
- (void)setModel:(BeforeModel *)model{
    _model = model;
    
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:DefaultImage]];
    self.userName.text = model.username;
    self.userBuyPtime.text = model.gonumber;
    self.userWinRate.text = [NSString stringWithFormat:@"%.2f%%",([model.gonumber floatValue] / [[UserDataSingleton userInformation].listModel.zongrenshu floatValue]) * 100];
}
- (IBAction)buyAction:(UIButton *)sender  {
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(theWiningCell:button:oldPtime:oldRate:)]) {
        [self.delegate theWiningCell:self button:sender oldPtime:self.userBuyPtime.text oldRate:self.userWinRate.text];
    }
    
}

@end
