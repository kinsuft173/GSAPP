//
//  SelectCategoryCtrl.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectDieaseDelegate <NSObject>

- (void)handleDieaseSelectedWithDic:(NSDictionary*)dic;

@end

@interface SelectDieaseCtrl : UIViewController

@property (nonatomic, weak) id<SelectDieaseDelegate> delegate;

@end
