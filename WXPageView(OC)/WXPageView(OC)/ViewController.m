//
//  ViewController.m
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "WXPageView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray * titles =  @[@"推荐", @"热点", @"视频",@"北京",@"社会",@"娱乐", @"图片",@"科技",@"汽车",@"体育"];
  //  NSArray * titles =  @[@"推荐",@"手游",@"娱乐",@"游戏",@"趣玩"];
    
    NSMutableArray * controllers = [NSMutableArray array];
    
    for (NSString * str  in titles) {
        
        UIViewController * vc  = [[UIViewController alloc]init];
        
        vc.view.backgroundColor = [UIColor randomColor];
        
        [controllers addObject:vc];
    }
    
    WXTitleStyle * style = [[WXTitleStyle alloc]init];
    style.isScrollEnable = YES;
    style.isShowScrollLine = YES;
    
    
    
    CGRect frame = CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height - 64);
    
    WXPageView * pageView = [WXPageView PageViewWithFrame:frame titles:titles childVcs:controllers parentVc:self style:style];
    
    [self.view addSubview:pageView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
