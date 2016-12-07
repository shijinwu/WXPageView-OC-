//
//  WXPageView.h
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXTitleView.h"
#import "WXTitleStyle.h"
#import "WXContentView.h"
#import "UIColor+WXExtension.h"
@interface WXPageView : UIView



// 标题数组
@property (nonatomic,strong)NSArray * titles;

// 标题对应的控制器数组
@property (nonatomic,strong)NSArray * childVcs;

// 控制器的父控制器
@property (nonatomic,strong)UIViewController * parentVc;

// 标题视图
@property (nonatomic,strong)WXTitleView * titleView;

// 标题视图的属性设置
@property (nonatomic,strong)WXTitleStyle * style;

// 显示内容的视图
@property (nonatomic,strong)WXContentView * contentView;


+(instancetype)PageViewWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles childVcs:(NSArray<UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc style:(WXTitleStyle *)style;

@end
