//
//  PeopleTimeView.h
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PeopleTimeView;
@protocol PeopleTimeViewDelegate <NSObject>

- (void)peopleTimeView:(PeopleTimeView *)peopleTimeView good:(ShoppingModel *)good;

@end


@interface PeopleTimeView : UIView
@property (nonatomic,weak)id<PeopleTimeViewDelegate>delegate;
@end
