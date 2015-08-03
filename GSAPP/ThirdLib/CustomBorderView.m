//
//  CustomBorderView.m
//  GSAPP
//
//  Created by kinsuft173 on 15/6/20.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "CustomBorderView.h"

@implementation CustomBorderView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
//    [self drawRectangle];
    
    [self drawBorder:rect];
    
    
}

// 绘制矩形
- (void)drawRectangle {
    
    // 定义矩形的rect
    CGRect rectangle = CGRectMake(40, 0, 260, 40);
    
    // 获取当前图形，视图推入堆栈的图形，相当于你所要绘制图形的图纸
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 在当前路径下添加一个矩形路径
    CGContextAddRect(ctx, rectangle);
    
    // 设置试图的当前填充色
    CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
    
    // 绘制当前路径区域
    CGContextFillPath(ctx);
    
}

- (void)drawBorder:(CGRect)rect
{
    NSLog(@"rect = %@",NSStringFromCGRect(rect));
    
    [[UIColor lightGrayColor] set];
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(currentContext,[UIColor blackColor].CGColor);
    
    CGContextSetShadowWithColor(currentContext,CGSizeMake(0, 0),0 ,[UIColor clearColor].CGColor);
    
    CGContextSetLineWidth(currentContext, 0.5f);
    CGContextSetStrokeColorWithColor(currentContext,[UIColor lightGrayColor].CGColor);
    
    
    CGContextMoveToPoint(currentContext, 0, rect.size.height*0.5);
    CGContextAddLineToPoint(currentContext, rect.size.width , rect.size.height*0.5 );
    
    CGContextSetLineWidth(currentContext, 0.5f);
    CGRect rectangle = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGContextSetLineCap(currentContext, kCGLineCapButt);//设置顶点样式
    CGContextAddRect(currentContext, rectangle);
    
    
    CGContextStrokePath(currentContext);
    
//    CGContextStrokePath(ctx);  

    
//    CGContextAddLineToPoint(currentContext, rect.size.width - 20,0.0f );
//    
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextAddLineToPoint(currentContext, rect.size.width - 20,rect.size.height);
//    
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextAddLineToPoint(currentContext, 10.0,rect.size.height);
//    
//    CGContextSetLineWidth(currentContext, 5.0f);
//    CGContextAddLineToPoint(currentContext, 10.0f, 0.0f);
//    
    CGContextStrokePath(currentContext);
    
}


@end
