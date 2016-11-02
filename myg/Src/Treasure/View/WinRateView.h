//
//  WinRateView.h
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WinRateView;
@protocol WinRateViewDelegate <NSObject>

- (void)winRateView:(WinRateView *)winRateView goodModel:(ShoppingModel *)good;

@end
@interface WinRateView : UIView
@property (nonatomic,weak)id<WinRateViewDelegate>delegate;
@property (nonatomic,strong)ShoppingModel *model;
@end
