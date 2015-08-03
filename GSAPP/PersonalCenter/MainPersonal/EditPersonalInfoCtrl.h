//
//  EditPersonalInfoCtrl.h
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FullImageCtrl.h"

@interface EditPersonalInfoCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property (weak, nonatomic) IBOutlet UIButton *btn_goSeeDoctor;
@property (weak, nonatomic) IBOutlet UIButton *btn_goSeeIdentifierPhoto;
@property (weak, nonatomic) IBOutlet UITextField *txt_Name;
@property (weak, nonatomic) IBOutlet UITextField *txt_Sex;


@end
