//
//  ChanceSurperView.m
//  myg
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "ChanceSurperView.h"
#import "PeopleTimeView.h"
#import "WinRateView.h"
#import "TheWiningCell.h"
#import "BettingToolView.h"




@interface ChanceSurperView ()<WinRateViewDelegate,PeopleTimeViewDelegate,UITableViewDelegate,UITableViewDataSource,BettingToolViewDelegate,UIScrollViewDelegate,TheWiningCellDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,assign)CGFloat startOffsetX;
@property (nonatomic,assign)BOOL isForbidScrollDelegate;
@property (nonatomic,assign)NSInteger num;
@end
@implementation ChanceSurperView

static NSString *const cellID = @"cellID";
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI{
    
//    self.backgroundColor = [UIColor redColor];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 8, 80, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"参与人次";
    label.font = [UIFont systemFontOfSize:13];
    label.backgroundColor = [UIColor whiteColor];
    [self addSubview:label];
    
    label.layer.cornerRadius = 6;
    label.layer.masksToBounds = YES;
    
    
    UIView *coverView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:coverView];
    
    BettingToolView *bettingToolView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BettingToolView class]) owner:nil options:nil].lastObject;
    bettingToolView.frame = CGRectMake(0, 40, MSW, 40);
    [self addSubview:bettingToolView];
    
    bettingToolView.layer.borderColor = [UIColor colorWithHexString:@"#e1e1e1"].CGColor;
    bettingToolView.layer.borderWidth = 1;
    
    [self addSubview:self.scrollView];

    bettingToolView.delegate = self;
    self.bettingToolView = bettingToolView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TheWiningCell class]) bundle:nil] forCellReuseIdentifier:cellID];
    [self.scrollView addSubview:self.tableView];
    self.startOffsetX = 0;
//    [self refreshData];
 
    NSString *surplus = [UserDataSingleton userInformation].listModel.shengyurenshu;
    NSString *sumPtime = [UserDataSingleton userInformation].listModel.zongrenshu;
    CGFloat ratio = [surplus floatValue] / [sumPtime floatValue];
    if (ratio < 0.01) {
        self.bettingToolView.heighRateBtn.enabled = NO;
        [self.bettingToolView.heighRateBtn setTitleColor:[UIColor colorWithHexString:@"#939393"] forState:UIControlStateNormal];
    }
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 80, MSW, 260)];
        _scrollView.pagingEnabled = YES;
        _scrollView.scrollEnabled = YES;
        _scrollView.contentSize = CGSizeMake(MSW * 3, 0);
        _scrollView.delegate = self;
        _scrollView.scrollEnabled = NO;
//        _scrollView.backgroundColor = [UIColor redColor];

        
        WinRateView *rateView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([WinRateView class]) owner:nil options:nil].lastObject;
        rateView.frame = CGRectMake(MSW * 2, 0, MSW, _scrollView.frame.size.height);
        rateView.delegate = self;
        [_scrollView addSubview:rateView];
        
        PeopleTimeView *peopleTimeView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([PeopleTimeView class]) owner:nil options:nil].lastObject;
        peopleTimeView.delegate = self;
        peopleTimeView.frame = CGRectMake(0, 0, MSW, _scrollView.frame.size.height);
        [_scrollView addSubview:peopleTimeView];
        
//        [_scrollView addSubview:_tableView];
        
        
    }
    return _scrollView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(MSW, 0, MSW, 260) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
        _tableView.dataSource = self;
        
    }
   return _tableView;
}
#pragma mark -WinRateViewDelegate
- (void)winRateView:(WinRateView *)winRateView goodModel:(ShoppingModel *)good{
    DebugLog(@"%zd,%@",good.num,good.goodsId);
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(chanceSurperView:settleModel:)]) {
        [self.delegate chanceSurperView:self settleModel:good];
    }
}
#pragma mark -PeopleTimeViewDelegate
- (void)peopleTimeView:(PeopleTimeView *)peopleTimeView good:(ShoppingModel *)good{
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(chanceSurperView:settleModel:)]) {
        [self.delegate chanceSurperView:self settleModel:good];
    }
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.beforeModelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TheWiningCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.delegate = self;
    cell.model = self.beforeModelArray[indexPath.section];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 230 / 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else{
        return 0;
    }
}
#pragma mark -BettingToolViewDelegate
- (void)bettingToolView:(BettingToolView *)bettingToolView index:(NSInteger)index{
    _isForbidScrollDelegate = YES;
    
    [_scrollView setContentOffset:CGPointMake(index * MSW, 0) animated:YES];
   
}
#pragma mark <TheWiningCellDelegate>
- (void)theWiningCell:(TheWiningCell *)theWiningCell button:(UIButton *)button oldPtime:(NSString *)oldptime oldRate:(NSString *)oldrate{
    
    DebugLog(@"----跟买-----");
    
//    [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    CGRect frame = self.bettingToolView.lineView.frame;
    frame.origin.x = 10;
    self.bettingToolView.lineView.frame = frame;
    
    [self.bettingToolView changeSecendBtnStateWith:100];
    
    [UserDataSingleton userInformation].oldPtime = oldptime;
    [UserDataSingleton userInformation].oldRate = oldrate;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"followBuyNotification" object:nil];
  
}


#pragma mark -UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    DebugLog(@"begin --- %f",scrollView.contentOffset.x);
    _isForbidScrollDelegate = NO;
    self.startOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    DebugLog(@"did --- %f",scrollView.contentOffset.x);
    if (_isForbidScrollDelegate) {
        return;
    }
    
    if (scrollView.contentOffset.x != 0) {
        NSInteger source = 0;
        NSInteger target = 0;
        CGFloat progress = 0.0;
        CGFloat contOffsetX = scrollView.contentOffset.x;
        if (contOffsetX > self.startOffsetX) { //左滑
            DebugLog(@"左滑");
            progress = contOffsetX / MSW - floor(MSW);
            source = (NSInteger)(contOffsetX / MSW);
            target = source + 1;
            if (target >= 3) {
                target = 2;
            }
            if (contOffsetX - self.startOffsetX == MSW) {
                target = source;
            }
        } else { //右滑
            DebugLog(@"右滑");
            progress = 1 - (contOffsetX / MSW - floor(MSW));
            target = (NSInteger)(contOffsetX / MSW);
            source = target + 1;
            if (source >= 3) {
                source = 2;
            }
        }
        [self.bettingToolView setTitleWithSourceIndex:source targetIndex:target progress:progress];
    }else{
        
    }
    
}

- (void)setModel:(ShoppingModel *)model{
    _model = model;
}
- (void)setBeforeModelArray:(NSMutableArray *)beforeModelArray{
    _beforeModelArray = beforeModelArray;
    [self.tableView reloadData];
}

#pragma mark - 往期中奖data
//- (NSMutableArray *)beforeModelArray{
//    if (!_beforeModelArray) {
//        self.beforeModelArray = [NSMutableArray array];
//    }
//    return _beforeModelArray;
//}


@end
