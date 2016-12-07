//
//  WXTitleStyle.m
//  WXPageView(OC)
//
//  Created by mac on 2016/12/5.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "WXTitleStyle.h"
#import "UIColor+WXExtension.h"

@implementation WXTitleStyle


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.titleHeight = 44;
        
        // RGB 值
        self.normalColor = [UIColor colorWithR:0 G:0 B:0 Alpha:1.0];
        self.selectColor = [UIColor colorWithR:255 G:127 B:0 Alpha:1.0];
        
        self.fontSize = 15.0;
        
        self.isScrollEnable = NO;
        self.itemMargin = 30.0;
        
        self.isShowScrollLine = NO;
        self.scrollLineHeight = 2;
        self.scrollLineColor = [UIColor orangeColor];
        
    }
    return self;
}

@end
