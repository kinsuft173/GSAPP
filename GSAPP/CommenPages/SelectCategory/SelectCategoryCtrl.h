//
//  SelectCategoryCtrl.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SlectCategoryDelegate <NSObject>

- (void)handleCategorySelectedWithDic:(NSDictionary*)dic;

@end

@interface SelectCategoryCtrl : UIViewController

@property (nonatomic, weak) id<SlectCategoryDelegate> delegate;

@end
