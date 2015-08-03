//
//  SelectSpeticalCtrl.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlectSpecialDelegate <NSObject>

- (void)handleSpecialSelectedWithDic:(NSDictionary*)dic;

@end

@interface SelectSpeticalCtrl : UIViewController

@property (nonatomic, weak) id<SlectSpecialDelegate> delegate;

@end
