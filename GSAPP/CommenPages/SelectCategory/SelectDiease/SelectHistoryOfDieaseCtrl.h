//
//  SelectCategoryCtrl.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectHistoryOfDieaseDelegate <NSObject>

- (void)handleHistoryOfDieaseSelectedWithDic:(NSString*)dic;

@end

@interface SelectHistoryOfDieaseCtrl : UIViewController

@property (nonatomic, weak) id<SelectHistoryOfDieaseDelegate> delegate;

@end
