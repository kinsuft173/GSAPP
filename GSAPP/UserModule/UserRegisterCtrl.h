//
//  UserRegisterCtrl.h
//  GSAPP
//
//  Created by lijingyou on 15/7/18.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"

@interface UserRegisterCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property (weak, nonatomic) IBOutlet UITextField *txt_Name;
@property (weak, nonatomic) IBOutlet UITextView *txt_Intro;

@property (nonatomic, strong) NSString* strPhone;
@property (nonatomic, strong) NSString* strPassword;


@end
