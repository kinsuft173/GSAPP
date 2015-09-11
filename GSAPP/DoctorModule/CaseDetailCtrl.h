//
//  CaseDetailCtrl.h
//  GSAPP
//
//  Created by lijingyou on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSOrder.h"

@interface CaseDetailCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UIView *view_DoctorCaseNotFinished;
@property (weak, nonatomic) IBOutlet UIView *view_ExpertCaseFinished;
@property (weak, nonatomic) IBOutlet UIView *view_ExpertCaseNotFinished;
@property (weak, nonatomic) IBOutlet UIScrollView *myScroll;
@property (strong,nonatomic) GSOrder * orderGS;

@property (nonatomic,strong) NSString* type;

@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UIButton *btn_finish;

@property (weak, nonatomic) IBOutlet UIButton *btn_Comment;
@property (weak, nonatomic) IBOutlet UIButton *btn_Complain;


@property (nonatomic, strong) IBOutlet UIButton* btn_feichangmanyi;
@property (nonatomic, strong) IBOutlet UIButton* btn_manyi;
@property (nonatomic, strong) IBOutlet UIButton* btn_yibanban;

@property (nonatomic, strong) IBOutlet UIImageView* img_feichangmanyi;
@property (nonatomic, strong) IBOutlet UIImageView* img_manyi;
@property (nonatomic, strong) IBOutlet UIImageView* img_yibanban;

@property (nonatomic, strong) IBOutlet UIButton* btn_newCancel;

@property (weak, nonatomic) IBOutlet UIImageView *img_left;

@property (weak, nonatomic) IBOutlet UIImageView *img_middle;

@property (weak, nonatomic) IBOutlet UIImageView *img_right;

@end
