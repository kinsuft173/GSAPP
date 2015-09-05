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
//@property (weak, nonatomic) IBOutlet UIButton *btn_goSeeDoctor;
//@property (weak, nonatomic) IBOutlet UIButton *btn_goSeeIdentifierPhoto;
@property (weak, nonatomic) IBOutlet UITextField *txt_Name;
@property (weak, nonatomic) IBOutlet UITextField *txt_Sex;
@property (weak, nonatomic) IBOutlet UILabel *txt_phone;

@property (nonatomic, strong) IBOutlet UIButton* btnImageZigezheng;
@property (nonatomic, strong) IBOutlet UIButton* btnImageId;
@property (nonatomic, strong) IBOutlet UIButton* btnImageHead;
@property (nonatomic, strong)  UIImage* imgZigezhenghahhah;
@property (nonatomic, strong)  UIImage* imgIdhehe;
@property (nonatomic, strong)  UIImage* imgHeadHehe;


@property (nonatomic, strong) NSString* strHeadUrl;
@property (nonatomic, strong) NSString* strZigezhengUrl;
@property (nonatomic, strong) NSString* strIdUrl;

@property (nonatomic, strong) IBOutlet UILabel* lblName;
@property (nonatomic, strong) IBOutlet UILabel* lblPhone;
@property (nonatomic, strong) IBOutlet UILabel* lblSex;

@end
