//
//  MYGPushGuideView.m
//  myg
//
//  Created by Apple on 16/10/27.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "MYGPushGuideView.h"
@implementation MYGPushGuideView
+ (instancetype)guideView{
        return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     [self removeFromSuperview];
    DebugLog(@"----触摸----");
    
}

@end
