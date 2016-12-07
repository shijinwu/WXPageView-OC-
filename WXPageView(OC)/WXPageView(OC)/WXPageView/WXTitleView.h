//
//  WXTitleView.h
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WXTitleStyle.h"



@class WXTitleView;

@protocol WXTitleViewDelegate <NSObject>

// 点击的是第一个title
-(void)titleView:(WXTitleView *)titleView targetIndex:(int)targetIndex;

@end

#import "WXContentView.h"

@interface WXTitleView : UIView<WXContentViewDelegate>

@property (nonatomic,weak)id<WXTitleViewDelegate>delegate;

// 是否正在点击标题
@property (nonatomic,assign)BOOL isTaping;

// 标题数组
@property (nonatomic,strong)NSArray *titles;

@property (nonatomic,strong)WXTitleStyle * style;

// 当前显示的位置
@property (nonatomic,assign)int currentIndex;

// 标题Label数组
@property (nonatomic,strong)NSMutableArray * titleLabels;

@property (nonatomic,strong)UIScrollView *scrollView;

// 底部的线
@property (nonatomic,strong)UIView * bottomLine;


+(instancetype)titleViewWithFrame:(CGRect)frame titles:(NSArray *)titles style:(WXTitleStyle *)style;

@end
