//
//  ChanceofViewController.m
//  myg
//
//  Created by Apple on 16/10/20.
//  Copyright © 2016年 bxs. All rights reserved.
//

#import "ChanceofViewController.h"
#import "ChanceSurperView.h"
#import "BettingToolView.h"
#import "SettlementModel.h"
#import "SettlementViewController.h"
#import "BeforeModel.h"
#import "MYGPushGuideView.h"
@interface ChanceofViewController ()<ChanceSurperViewDelegate>
@property (nonatomic,strong)ChanceSurperView *chanceSurperView;
@property (nonatomic,assign)BOOL isKeyboardVisible;

@property(nonatomic,strong)NSMutableArray *classArray;  //支付方式
@property(nonatomic,strong)NSMutableArray *zhifuNameArray; //支付名
@property(nonatomic,strong)NSMutableArray *zhifuTishiArray; //支付小标题
@property(nonatomic,strong)NSMutableArray *zhifuColorArray; //支付颜色
@property(nonatomic,strong)NSMutableArray *zhifuImgArray; //支付图片
@property (assign,nonatomic)NSInteger num;

@end

@implementation ChanceofViewController
{
    int _isback;//是否从结算返回
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    // 初始化
    [self setUpUI];
    
    
    self.classArray=[NSMutableArray array];
    self.zhifuNameArray=[NSMutableArray array];
    self.zhifuColorArray=[NSMutableArray array];
    self.zhifuImgArray=[NSMutableArray array];
    self.zhifuTishiArray=[NSMutableArray array];
    
    DebugLog(@"待处理的数据： %@",[UserDataSingleton userInformation].shopModel);
    [self keyboardNotification];
    
    [self refreshData];
    
    // 判断引导是否第一次加载
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"first"])
//    {
//        
//    }
//    else
//    {
//        
//    }
    [self judgeGuideView];
   
}
- (void)judgeGuideView{
    
    NSString *keyString =@"CFBundleShortVersionString";
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[keyString];
    NSString *saboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:keyString];
    if (![currentVersion isEqualToString:saboxVersion]) {
        
        MYGPushGuideView *guideView = [MYGPushGuideView guideView];
        guideView.frame = self.view.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:guideView];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:keyString];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    
    
}

/** 
 *键盘收起与弹出
 */
- (void)keyboardNotification{
    DebugLog(@"aaa");
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow) name:UIKeyboardDidShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide) name:UIKeyboardDidHideNotification object:nil];
//    
}
/** 
 *弹出
 */
- (void)keyboardShow{
    DebugLog(@"keyboard will show");
    
    
    if (_isKeyboardVisible) {
        return;
    }else{
        CGRect frame =  self.chanceSurperView.frame;
        frame.origin.y = self.chanceSurperView.frame.origin.y - 100;
        DebugLog(@"%f",self.chanceSurperView.frame.origin.x);
        [UIView animateWithDuration:0.3 animations:^{
            DebugLog(@"%f",self.chanceSurperView.frame.origin.x);
            self.chanceSurperView.frame = frame;
            DebugLog(@"%f",self.chanceSurperView.frame.origin.x);
        }];
        _isKeyboardVisible = YES;
    }
}
/**
 *隐藏
 */
- (void)keyboardHide{
    _isKeyboardVisible = NO;
    DebugLog(@"keyboard will hide");
    CGRect frame =  self.chanceSurperView.frame;
    frame.origin.y = MSH - self.chanceSurperView.frame.size.height;
    [UIView animateWithDuration:0.5 animations:^{
        self.chanceSurperView.frame = frame;
    }];
}


/**
 *UI初始化
 */
- (void)setUpUI{
    
    /**  
     *{
     shengyurenshu = 2776;
     shopid = 10125;
     thumb = "http://www.miyungou.com/statics/uploads/shopimg/20161021/73974172014777.jpg";
     title = "\U3010\U65b0\U54c1\U3011SMARTISAN\U9524\U5b50 M1L \U5168\U7f51\U901a4G\U667a\U80fd\U624b\U673aLT23";
     xiangou = 0;
     yunjiage = 1;
     zongrenshu = 3959;
     }
     */
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
    [self.view addSubview:self.chanceSurperView];
    
    
    
    
   
    
}
#pragma mark <ChanceSurperViewDelegate>
- (void)chanceSurperView:(ChanceSurperView *)chanceSurperView settleModel:(ShoppingModel *)model{
    
    [self settlement];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CGRect frame = self.chanceSurperView.frame;
    frame.origin.y = self.view.bounds.size.height - 340;
    [UIView animateWithDuration:0.2 animations:^{
        self.chanceSurperView.frame = frame;
    }];
}
- (ChanceSurperView *)chanceSurperView{
    if (!_chanceSurperView) {
        _chanceSurperView = [[ChanceSurperView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 340)];
        _chanceSurperView.delegate = self;
    }
    return _chanceSurperView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_isKeyboardVisible) {
        [self.view endEditing:YES];
    }else{
        if (![[touches anyObject].view isKindOfClass:[BettingToolView class]]) {
            CGRect frame = self.chanceSurperView.frame;
            frame.origin.y = self.view.bounds.size.height;
            [UIView animateWithDuration:0.3 animations:^{
                self.chanceSurperView.frame = frame;
            }];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:NO completion:nil];
            });
        }
    }
    DebugLog(@"%@",[touches anyObject].view);
  
}
- (void)refreshData
{
    
    self.num = 1;
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:[UserDataSingleton userInformation].sid forKey:@"sid"];
    [MDYAFHelp AFPostHost:APPHost bindPath:Before postParam:dict1 getParam:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDic)  {
        
        DebugLog(@"------%@",responseDic);
        
        [self refreshSuccessful:responseDic];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
- (void)refreshSuccessful:(id)data
{
//    [self.beforeModelArray removeAllObjects];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    if ([data isKindOfClass:[NSDictionary class]])
    {
        if([data[@"code"] isEqualToString:@"200"])
        {
            NSArray *array = data[@"data"];
            
            if (array.count >=3) {
                for (NSInteger i = 0; i<3; i++) {
                    
                    BeforeModel  *model = [[BeforeModel alloc]initWithDictionary:array[i]];
                    if (![model.status isEqualToString:@"0"]) {
                        [modelArray addObject:model];
                    }
                }
                _chanceSurperView.beforeModelArray = modelArray;

            }else{
                for (NSInteger i = 0; i<array.count; i++) {
                    
                    BeforeModel  *model = [[BeforeModel alloc]initWithDictionary:array[i]];
                    if (![model.status isEqualToString:@"0"]) {
                        [modelArray addObject:model];
                    }
                }
                _chanceSurperView.beforeModelArray = modelArray;
 
            }
            
            
            
        }
    }
    if ([data[@"code"] isEqualToString:@"400"])
    {
    }
}
#pragma mark 结算
- (void)settlement 
{
    __block NSString *settlementString;
    NSMutableArray *settlementArray = [NSMutableArray array]; //结算array
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    if ([UserDataSingleton userInformation].isLogin == YES)
    {
        //解析数据对象
            settlementString =  [NSString stringWithFormat:@"{\"shopid\":%@,\"number\":%ld}",[UserDataSingleton userInformation].shopModel.goodsId,(long)[UserDataSingleton userInformation].shopModel.num];
        NSString *string = [NSString stringWithFormat:@"[%@]",settlementString];
        DebugLog(@"!!!!!!!!!!!解析%@",string);
//        [{"shopid":10125,"number":10}]
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:[UserDataSingleton userInformation].uid forKey:@"yhid"];
        [dict setValue:[UserDataSingleton userInformation].code forKey:@"code"];
        [dict setValue:string forKey:@"cart"];
        [dict setValue:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"] forKey:@"ver"];
        [MDYAFHelp AFPostHost:APPHost bindPath:xinjiesuan postParam:dict getParam:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDic) {
            DebugLog(@"====%@ ====%@",responseDic,responseDic[@"msg"]);
            if ([responseDic[@"code"] isEqualToString:@"302"])
            {
                [SVProgressHUD showErrorWithStatus:@"请登录"];
                
                LoginViewController *loginVC = [[LoginViewController alloc]init];
                loginVC.hidesBottomBarWhenPushed=YES;
                [self.navigationController pushViewController:loginVC animated:YES];
            }
            if ([responseDic[@"code"]isEqualToString:@"400"])
            {
                [SVProgressHUD showErrorWithStatus:responseDic[@"msg"]];
            }
            if ([responseDic[@"code"] isEqualToString:@"200"])
            {
                [SVProgressHUD dismiss];
                
                [self.classArray removeAllObjects];
                [self.zhifuNameArray removeAllObjects];
                [self.zhifuTishiArray removeAllObjects];
                [self.zhifuColorArray removeAllObjects];
                [self.zhifuImgArray removeAllObjects];
                
                NSDictionary *dict = responseDic[@"data"];
                SettlementModel *model = [[SettlementModel alloc]initWithDictionary:dict];
                //                DebugLog(@"===================%@",model.jiage);
//                for (int i=0; i<model.pay_type.count; i++) {
//                    NSDictionary*dic1=[model.pay_type objectAtIndex:i];
//                    [self.classArray addObject:dic1[@"pay_class"]];
//                    [self.zhifuNameArray addObject:dic1[@"pay_name"]];
//                    [self.zhifuTishiArray addObject:dic1[@"tishi"]];
//                    [self.zhifuColorArray addObject:dic1[@"color"]];
//                    [self.zhifuImgArray addObject:dic1[@"img"]];
//                    
//                    DebugLog(@"---->%@",self.classArray);
//                    DebugLog(@"++++>%@",self.zhifuNameArray);
//                }
                
                
                
                [self.classArray addObject:@"wapalipay"];
                [self.zhifuImgArray addObject:@"支付宝"];
                [self.zhifuNameArray addObject:@"支付宝"];
                [self.zhifuColorArray addObject:@"支付宝"];
                [self.zhifuTishiArray addObject:@"支付宝"];
                
                SettlementViewController *settVC = [[SettlementViewController alloc]init];
                settVC.settModel = model;
                settVC.goods = string;
                settVC.totalYue = [NSString stringWithFormat:@"%@",dict[@"totalYue"]];
                settVC.classArray=self.classArray;
                settVC.zhifuNameArray=self.zhifuNameArray;
                settVC.zhifuTishiArray=self.zhifuTishiArray;
                settVC.zhifuColorArray=self.zhifuColorArray;
                settVC.zhifuImgArray=self.zhifuImgArray;
                
                [self.navigationController pushViewController:settVC animated:YES];
                _isback=1;
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"请检查您的网络"];
            [settlementArray removeAllObjects];
            DebugLog(@"%@",error);
            NSData *data = [operation responseData];
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            DebugLog(@"请求下来的数据%@",str);
        }];
    }
    else
    {
        [SVProgressHUD dismiss];
        LoginViewController *loginVC = [[LoginViewController alloc]init];
        loginVC.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
    
}


@end
