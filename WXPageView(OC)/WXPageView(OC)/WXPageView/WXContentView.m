//
//  WXContentView.m
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WXContentView.h"

 NSString * const kContentCellID = @"kContentCellID";

@interface WXContentView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation WXContentView


+(instancetype)contentViewWithFrame:(CGRect)frame childVcs:(NSArray *)childVcs parentVc:(UIViewController *)parentVc{
    
    WXContentView * contentView = [[WXContentView alloc]initWithFrame:frame];
    contentView.childVcs = childVcs;
    contentView.parentVc = parentVc;
    
    contentView.startOffsetX = 0;
    
    [contentView setupUI];
    
    return contentView;

}
-(void)setupUI{
   
    for (UIViewController * vc in self.childVcs) {
        
        [self.parentVc addChildViewController:vc];
    }
    
    [self setupCollectionView];
    
    
}

-(void)setupCollectionView{
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = self.bounds.size;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kContentCellID];
    
    self.collectionView.pagingEnabled = YES;
    
    self.collectionView.bounces = NO;
    self.collectionView.scrollsToTop = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self addSubview:self.collectionView];

}

-(void)titleView:(WXTitleView *)titleView targetIndex:(int)targetIndex{
    
    NSIndexPath * indexPath = [NSIndexPath indexPathForItem:targetIndex inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
}

#pragma mark UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.childVcs.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kContentCellID forIndexPath:indexPath];
    
    for (UIView * view in cell.contentView.subviews) {
        
        [view removeFromSuperview];
    }
    
    UIViewController * vc  = self.childVcs[indexPath.item];
    vc.view.frame = cell.contentView.bounds;
    [cell.contentView addSubview:vc.view];
    
    return cell;
}

#pragma  mark UICollectionViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self contentEndScroll];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (!decelerate) {
        [self contentEndScroll];
    }

}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    self.startOffsetX = scrollView.contentOffset.x;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.startOffsetX == scrollView.contentOffset.x) {
        
        return;
    }
    int  targetIndex = 0;
    CGFloat progress = 0.0;
    
    int currentIndex = (int)(_startOffsetX/scrollView.bounds.size.width);
    if (_startOffsetX < scrollView.contentOffset.x) {
        
        targetIndex = currentIndex + 1;
        
        if (targetIndex > _childVcs.count - 1) {
            
            targetIndex = (int)(_childVcs.count - 1);
            
        }
      
         progress = (scrollView.contentOffset.x - _startOffsetX)/scrollView.bounds.size.width;
    }
    else{
        targetIndex = currentIndex - 1;
        
        if (targetIndex < 0) {
            
            targetIndex = 0;
        }
        
        progress = (_startOffsetX - scrollView.contentOffset.x)/scrollView.bounds.size.width;
        
    }
    
   
    [self.delegate  contentView:self targetIndex:targetIndex progress:progress];
 
}


-(void)contentEndScroll{
    
    // 1.获取滚动到的位置
    int  currentIndex = (int)(_collectionView.contentOffset.x / _collectionView.bounds.size.width);
    
    // 2.通知titleView进行调整
    [self.delegate contentView:self targetIndex:currentIndex];
}

@end
