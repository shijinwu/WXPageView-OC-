//
//  WXPageView.m
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WXPageView.h"

@implementation WXPageView

+(instancetype)PageViewWithFrame:(CGRect)frame titles:(NSArray<NSString *>*)titles childVcs:(NSArray<UIViewController *>*)childVcs parentVc:(UIViewController *)parentVc style:(WXTitleStyle *)style{
    
    WXPageView * pageView = [[WXPageView alloc]initWithFrame:frame];
    pageView.titles = titles;
    pageView.childVcs = childVcs;
    pageView.parentVc = parentVc;
    pageView.style = style;
    
    [pageView setupUI];
    
    return pageView;
}

-(void)setupUI{
    
    [self  setupTitleView];
    [self setupContentView];
}

-(void)setupTitleView{
    
    CGRect frame  = CGRectMake(0, 0, self.bounds.size.width, self.style.titleHeight);
    
    self.titleView =  [WXTitleView titleViewWithFrame:frame titles:self.titles style:self.style];
    
    self.titleView.backgroundColor = [UIColor randomColor];
    [self addSubview:self.titleView];

}

-(void)setupContentView{
    
     CGRect frame  = CGRectMake(0, self.style.titleHeight, self.bounds.size.width,self.bounds.size.height - self.style.titleHeight);
    
    self.contentView = [WXContentView contentViewWithFrame:frame childVcs:self.childVcs parentVc:self.parentVc];
    
    self.contentView.backgroundColor = [UIColor randomColor];
    
    
    self.titleView.delegate = self.contentView;
    self.contentView.delegate = self.titleView;
    
    [self addSubview:self.contentView];
 
}


@end
