//
//  HKCommen.h
//  GSAPP
//
//  Created by kinsuft173 on 15/6/6.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NewworkConfig.h"
#import "HKTextFiled.h"
#import "GS-Config.h"
#import <UIImageView+WebCache.h>

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


//各种便利宏
#define IOS7 [[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0
#define IOS8 [[[UIDevice currentDevice]systemVersion] floatValue] >= 8.0



@interface HKCommen : NSObject

//正则验证
+ (BOOL)validateEmail:(NSString *)email;
+ (BOOL)validatePassword:(NSString *)passWord;
+ (BOOL)validateNickname:(NSString *)nickname;
+ (BOOL)validateMobileWithPhoneNumber:(NSString*)strPhoneNumber;
+ (UIColor*)getColor:(NSString *)hexColor;
//控制器的标题
+ (void)addHeadTitle: (NSString*)string whichNavigation:(UINavigationItem*)item;
+ (CGFloat)compulateTheHightOfAttributeLabelWithWidth:(CGFloat)width WithContent:(NSString*)string WithFontSize:(NSInteger)size;
//隐藏多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

//给一个view加上边框
+ (void)addBoardToView:(UIView*)view WithSuperView:(UIView*)superView withWidth:(CGFloat)width  withInset:(CGFloat)inset;


+ (void)addAlertViewWithTitel:(NSString*)titel;

@end
