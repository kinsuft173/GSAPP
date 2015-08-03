//
//  DiagnoseInfoCtrl.h
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"
#import "SelectCategoryCtrl.h"
#import "SelectDateCtrl.h"
#import "GSExpert.h"

@interface DiagnoseInfoCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property (strong,nonatomic) starView *star;
@property (weak, nonatomic) IBOutlet UIButton *btn_agreeOtherSpecilist;
@property (weak, nonatomic) IBOutlet UIImageView *img_left;
@property (weak, nonatomic) IBOutlet UIImageView *img_middle;
@property (weak, nonatomic) IBOutlet UIImageView *img_right;
@property (assign)NSUInteger count_Button;
@property (weak, nonatomic) IBOutlet UIButton *btn_updateData;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (weak, nonatomic) IBOutlet UIView *viewForStar;

@property (weak, nonatomic) IBOutlet UITextField *txt_ReserveDate;

@property (weak, nonatomic) IBOutlet UILabel *lbl_ReserveDate;

@property (nonatomic, strong) GSExpert* expert;

@end
