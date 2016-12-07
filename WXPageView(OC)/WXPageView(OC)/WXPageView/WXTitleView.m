//
//  WXTitleView.m
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WXTitleView.h"
#import "UIColor+WXExtension.h"
@implementation WXTitleView


+(instancetype)titleViewWithFrame:(CGRect)frame titles:(NSArray *)titles style:(WXTitleStyle *)style{
    
    WXTitleView * titleView = [[WXTitleView alloc]initWithFrame:frame];
    titleView.titles = titles;
    titleView.style = style;
    
    [titleView setupUI];
    return titleView;
    
}

-(void)setupUI{
    
    [self addSubview:self.scrollView];
    
    [self setupTitleLabels];
    
    [self setupTitleLabelsFrame];
    
    if (_style.isShowScrollLine) {
        
        [self.scrollView addSubview:self.bottomLine];
    }
}

-(UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
    }
    
    return _scrollView;
}

-(UIView *)bottomLine{
    
    if (_bottomLine == nil){
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0,self.bounds.size.height - self.style.scrollLineHeight, 0,self.style.scrollLineHeight)];
        _bottomLine.backgroundColor = self.style.scrollLineColor;
    }
    
    return _bottomLine;
}

-(NSMutableArray *)titleLabels{
    
    if (_titleLabels == nil) {
        
        _titleLabels = [NSMutableArray array];
    }
    
    return _titleLabels;
}


-(void)setupTitleLabels{
    
    for (int i = 0 ; i < self.titles.count; i++) {
       
        UILabel * label = [[UILabel alloc]init];
        label.text = self.titles[i];
        label.font = [UIFont systemFontOfSize:self.style.fontSize];
        label.tag = i;
        label.textAlignment = NSTextAlignmentCenter;
      
        label.textColor = i == 0 ? self.style.selectColor : self.style.normalColor;
        
    
        label.userInteractionEnabled = YES;
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleLabelClick:)];
        [label addGestureRecognizer:tap];
        
        [self.scrollView addSubview:label];
        
        [self.titleLabels addObject:label];
    }
}

-(void)titleLabelClick:(UITapGestureRecognizer *)sender{
    NSLog(@"ssssss");
    
    _isTaping = YES;
    
    UILabel * targetLabel = (UILabel *)sender.view;
    
    [self adjustTitleLabelWithTargetIndex:(int)targetLabel.tag];
    
    [self.delegate titleView:self targetIndex:_currentIndex];
    
    
    _isTaping = NO;
        
}

-(void)setupTitleLabelsFrame{
    

    
    int count = (int)self.titles.count;
    
    for (int  i = 0 ; i < count; i++) {
        
        CGFloat w = 0.0;
        CGFloat h = self.bounds.size.height;
        CGFloat x = 0.0;
        CGFloat y = 0.0;
        
        
        
        UILabel * label = self.titleLabels[i];
        
        if (self.style.isScrollEnable) {
            
            w = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size.width;
            
            if (i == 0) {
                
                x = self.style.itemMargin * 0.5;
                
                if (self.style.isShowScrollLine) {
                    
                    CGRect frame = self.bottomLine.frame;
                    frame.origin.x = x;
                    frame.size.width = w;
                    self.bottomLine.frame = frame;
                    
                }
          
            }
            else{
                
                
                UILabel * preLabel = _titleLabels[i - 1];
                x = CGRectGetMaxX(preLabel.frame) + _style.itemMargin;
            }
            
        }
        else{
            
            w = self.bounds.size.width/count;
            x = w*i;
            
        if (i == 0 && _style.isShowScrollLine) {
            
            CGRect frame = self.bottomLine.frame;
            frame.origin.x = 0;
            frame.size.width = w;
            self.bottomLine.frame = frame;
            
        }
 
            
        }
        
        
        label.frame = CGRectMake(x, y, w, h);
       
    }
    
    UILabel * lastlabel = _titleLabels.lastObject;
    
    _scrollView.contentSize = _style.isScrollEnable ? CGSizeMake(CGRectGetMaxX(lastlabel.frame)+_style.itemMargin*0.5, 0):CGSizeZero;
    
   
    
}

-(void)adjustTitleLabelWithTargetIndex:(int)targetIndex{
    
    
//    if (_currentIndex == targetIndex) {
//        
//        return;
//    }
//    
    UILabel * targetLabel = _titleLabels[targetIndex];
    UILabel * sourceLabel = _titleLabels[_currentIndex];
    
    sourceLabel.textColor = _style.normalColor;
    targetLabel.textColor = _style.selectColor;
    
    
    _currentIndex = targetIndex;
    
    if (_style.isScrollEnable) {
        CGFloat offsetX = targetLabel.center.x - _scrollView.bounds.size.width * 0.5;
        if (offsetX < 0){
            offsetX = 0;
            }
        if (offsetX > (_scrollView.contentSize.width - _scrollView.bounds.size.width)) {
            offsetX = _scrollView.contentSize.width - _scrollView.bounds.size.width;
                }
        [_scrollView setContentOffset:CGPointMake(offsetX, 0) animated:NO];
        }
    
    if (_style.isShowScrollLine) {
        
        [UIView animateWithDuration:0.25 animations:^{
           
            CGRect frame = self.bottomLine.frame;
            frame.origin.x = targetLabel.frame.origin.x;
            frame.size.width = targetLabel.frame.size.width;
            self.bottomLine.frame = frame;
            
        }];
    }
    
    
}


-(void)contentView:(WXContentView *)contentView targetIndex:(int)targetIndex{
    
    [self adjustTitleLabelWithTargetIndex:targetIndex];
}

-(void)contentView:(WXContentView *)contentView targetIndex:(int)targetIndex progress:(CGFloat)progress{
    
    if (self.isTaping) {
        
        return;
    }
    
    UILabel * targetLabel = _titleLabels[targetIndex];
    UILabel * sourceLabel = _titleLabels[_currentIndex];
    
    
    NSArray<NSNumber *> * deltaRGB = [UIColor getRGBDeltaWithFristColor:self.style.selectColor SecondColor:self.style.normalColor];
    
    NSArray<NSNumber *> * n = [self.style.normalColor getRGB];
    NSArray<NSNumber *> * s = [self.style.selectColor getRGB];
    
    
    
    targetLabel.textColor = [UIColor colorWithR:(CGFloat)(n[0].floatValue+deltaRGB[0].floatValue*progress) G:(CGFloat)(n[1].floatValue+deltaRGB[1].floatValue*progress) B:(CGFloat)(n[2].floatValue+deltaRGB[2].floatValue*progress) Alpha:1.0];
    
    sourceLabel.textColor = [UIColor colorWithR:(CGFloat)(s[0].floatValue-deltaRGB[0].floatValue*progress) G:(CGFloat)(s[1].floatValue-deltaRGB[1].floatValue*progress) B:(CGFloat)(s[2].floatValue-deltaRGB[2].floatValue*progress) Alpha:1.0];
    
    if (self.style.isShowScrollLine) {
        
        CGFloat deltaX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x;
        CGFloat deltaW = targetLabel.frame.size.width - sourceLabel.frame.size.width;
        
        CGRect frame = self.bottomLine.frame;
        
        frame.origin.x = sourceLabel.frame.origin.x + deltaX * progress;
        
        frame.size.width = sourceLabel.frame.size.width + deltaW * progress;
        
        
        self.bottomLine.frame = frame;
    }

}

@end
