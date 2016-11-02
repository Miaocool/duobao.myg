//
//  ChanceSubViewCell.m
//  myg
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "ChanceSubViewCell.h"
#import "WinRateView.h"
#import "PeopleTimeView.h"

@interface ChanceSubViewCell ()
@property (nonatomic,assign)NSInteger row;
@end


@implementation ChanceSubViewCell
- (instancetype)initWithFrame:(CGRect)frame indexPathRow:(NSInteger)row{
    
    if (self = [super init]) {
        self.frame = frame;
        self.row = row;
        [self setUpUIWithRow:self.row];
    }
    return self;
    
    
}
- (void)setUpUIWithRow:(NSInteger)row{
    
    if (row == 0) {
        
        PeopleTimeView *peopletimeView = [[PeopleTimeView alloc]initWithFrame:CGRectZero];
        
        
        
        
        
    }else if (row == 1){
        
        
        
        
    }else{
        
    }
    
    
    
}
@end
