//
//  RedPageAlertView.h
//  myg
//
//  Created by Apple on 16/10/14.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RedPageAlertView;
typedef void (^CheckBlock)(NSString *);
typedef void (^CloseBlock)();

@protocol RedPageAlertViewDelegate <NSObject>

- (void)redPageAlertView:(RedPageAlertView *)redpageView checkButton:(UIButton *)button;
- (void)redPageAlertView:(RedPageAlertView *)redpageView closeButton:(UIButton *)button;

@end

@interface RedPageAlertView : UIView
- (void)showWithState:(BOOL)state checkTitle:(NSString *)title imageName:(NSString *)imageName;
- (void)dismiss;
@property (nonatomic,copy)CheckBlock checkBlock;
@property (nonatomic,copy)CloseBlock closeBlock;
+ (instancetype)shareInstance;
@property (nonatomic, weak)id<RedPageAlertViewDelegate>delegate;
@end
