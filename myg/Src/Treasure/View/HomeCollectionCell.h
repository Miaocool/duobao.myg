//
//  HomeCollectionCell.h
//  myg
//
//  Created by Apple on 16/10/19.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsModel.h"
@class HomeCollectionCell;
@protocol HomeCollectionCellDelegate <NSObject>

- (void)homeCollectionCell:(HomeCollectionCell *)homeCollectionCell button:(UIButton *)button;

@end

@interface HomeCollectionCell : UICollectionViewCell
@property (nonatomic, strong) GoodsModel *goodsModel;
@property (nonatomic, weak)id<HomeCollectionCellDelegate>delegate;
@end
