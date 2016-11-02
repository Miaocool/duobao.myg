//
//  TheWiningCell.h
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BeforeModel.h"
@class TheWiningCell;

@protocol TheWiningCellDelegate <NSObject>

- (void)theWiningCell:(TheWiningCell *)theWiningCell button:(UIButton *)button oldPtime:(NSString *)oldptime oldRate:(NSString *)oldrate;

@end

@interface TheWiningCell : UITableViewCell
@property (nonatomic, strong) BeforeModel *model;
@property (weak,nonatomic)id<TheWiningCellDelegate>delegate;
@end
