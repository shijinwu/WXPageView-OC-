//
//  WXContentView.h
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@class WXContentView;

@protocol  WXContentViewDelegate<NSObject>

-(void)contentView:(WXContentView *)contentView targetIndex:(int)targetIndex;

-(void)contentView:(WXContentView *)contentView targetIndex:(int)targetIndex progress:(CGFloat)progress;

@end

#import "WXTitleView.h"

@interface WXContentView : UIView<WXTitleViewDelegate>

@property (nonatomic,weak)id<WXContentViewDelegate>delegate;

// 标题对应的控制器数组
@property (nonatomic,strong)NSArray  * childVcs;
// 父控制器
@property (nonatomic,strong)UIViewController  * parentVc;

// 起始的偏移量
@property (nonatomic,assign)CGFloat startOffsetX;

@property (nonatomic,strong)UICollectionView  * collectionView;



+(instancetype)contentViewWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc;

@end
