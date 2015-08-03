//
//  CTTabbarCtrl.h
//  ksbk
//
//  Created by 胡昆1 on 1/4/15.
//  Copyright (c) 2015 cn.chutong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface CTTabbarCtrl : UITabBarController

@property(nonatomic, weak) ICSDrawerController *drawer;

- (void)setTabBarItemUI;

@end
