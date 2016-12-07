//
//  WXTitleStyle.h
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WXTitleStyle : NSObject


// 标题高度
@property (nonatomic,assign)CGFloat titleHeight;

// 正常颜色
@property (nonatomic,strong)UIColor * normalColor;
// 选中颜色
@property (nonatomic,strong)UIColor * selectColor;

// 标题大小
@property (nonatomic,assign)CGFloat fontSize;

// 是否可滑动
@property (nonatomic,assign)BOOL isScrollEnable;

// 间隔
@property (nonatomic,assign)CGFloat itemMargin;

//是否显示底端线
@property (nonatomic,assign)BOOL isShowScrollLine;

// 底端线高
@property (nonatomic,assign)CGFloat scrollLineHeight;

// 底端线颜色
@property (nonatomic,strong)UIColor  * scrollLineColor;

@end
