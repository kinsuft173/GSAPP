//
//  HKMapCtrl.h
//  eCarter
//
//  Created by kinsuft173 on 15/7/7.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultLocationZoomLevel       16.1
#define kDefaultControlMargin           22
#define kDefaultCalloutViewMargin       -8

@protocol SlectMapDelegate <NSObject>

- (void)handleMapSelectedWithDic;

@end


@interface HKMapCtrl : UIViewController


@property (nonatomic,weak) id<SlectMapDelegate>delegate;

@end
