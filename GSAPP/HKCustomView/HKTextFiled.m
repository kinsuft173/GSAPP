//
//  HKTextFiled.m
//  GSAPP
//
//  Created by kinsuft173 on 15/7/1.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "HKTextFiled.h"

@implementation HKTextFiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static CGFloat leftMargin = 24;

- (CGRect)textRectForBounds:(CGRect)bounds
{
    bounds.origin.x += leftMargin;
    
    return bounds;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    bounds.origin.x += leftMargin;
    
    return bounds;
}

@end
