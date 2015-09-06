//
//  DiagnoseInfoCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "DiagnoseInfoCtrl.h"
#import "GreatDoctorCtrl.h"
#import "HKCommen.h"
#import "PickerViewCell.h"
#import "NetworkManager.h"
#import "PhotoBroswerVC.h"
#import "CameraCtrl.h"
#import "NetWorkManager.h"
#import "UserDataManager.h"
#import "SelectHistoryOfDieaseCtrl.h"
#import "SelectDieaseCtrl.h"
#import "GSConsulation.h"
#import "SIAlertView.h"

@interface DiagnoseInfoCtrl ()<UIActionSheetDelegate,SelectHistoryOfDieaseDelegate,SelectDateDelegate,SelectDieaseDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *img_Boy;
@property (weak, nonatomic) IBOutlet UIImageView *img_Girl;
@property (weak, nonatomic) IBOutlet UIImageView *img_RightNow;
@property (weak, nonatomic) IBOutlet UIImageView *img_NotRightNow;
@property (strong,nonatomic)UIDatePicker *datePicker;
@property (nonatomic, strong) IBOutlet UITextField* textFiledDoctorDept;
@property (nonatomic, strong) IBOutlet UITextField* textFiledDoctorHospital;
@property (nonatomic, strong) IBOutlet UITextField* textFiledDoctorCity;
@property (nonatomic, strong) IBOutlet UITextField* textFiledDoctorAdress;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPatientName;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPatientAge;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPatientTel;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPatientDisease;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPatientMedicalHistory;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPatientSymptom;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPatientMark;
@property (nonatomic, strong) IBOutlet UITextView*  txtPurpose;

@property (nonatomic, strong) NSArray* arrayTint;
@property (nonatomic, strong) NSArray* arrayTextFiled;
@property (nonatomic, strong) NSArray* arrayKey;

@property (nonatomic, strong) IBOutlet UIButton* btnMan;
@property (nonatomic, strong) IBOutlet UIButton* btnWoman;

@property (weak, nonatomic) IBOutlet UILabel *lbl_agreeOtherExpert;
@property (weak, nonatomic) IBOutlet UIButton *btn_checkAgree;
@property (weak, nonatomic) IBOutlet UIButton *btn_BlueCheck;
@property (assign) BOOL showDateOrNot;
@property (strong,nonatomic) NSDictionary *showData;

@property (nonatomic)  BOOL sexSelected;
@property (nonatomic)  BOOL timelySelected;


@property (nonatomic, strong) NSNumber* strSymptom;
@property (nonatomic, strong) NSNumber* strSnamnesis;


//UI显示
@property (nonatomic, strong) IBOutlet UILabel* lblName;
@property (nonatomic, strong) IBOutlet UILabel* lblPro;
@property (nonatomic, strong) IBOutlet UILabel* lblIntro;
@property (nonatomic, strong) IBOutlet UILabel* lblDept;
@property (nonatomic, strong) IBOutlet UILabel* lblDeptAndSurgery;





@property BOOL isLeft;
@property BOOL isMiddle;
@property BOOL isRight;

@property (nonatomic, strong) IBOutlet UIImageView* imgHeadPhoto;


//去下个页面的数据

@end

@implementation DiagnoseInfoCtrl
@synthesize sexSelected;
@synthesize timelySelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.myScroll.contentSize=CGSizeMake(0, 1550);
    
    [self.myScroll setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];

    self.arrayTint = [NSArray arrayWithObjects:@"请填写患者所在科室",@"请填写患者所在医院",@"请填写患者所在城市",@"请填写患者所在地区",@"请填写患患者姓名",@"请填写患者年龄",@"请填写患者电话",@"请填写患者所患疾病",@"请填写患者病史",@"请填写患者症状",@"请填写备注",nil];
    
    self.arrayTextFiled = [NSArray arrayWithObjects:self.textFiledDoctorDept,self.textFiledDoctorHospital,self.textFiledDoctorCity,self.textFiledDoctorAdress,self.textFiledPatientName,self.textFiledPatientAge,self.textFiledPatientTel,self.textFiledPatientDisease,self.textFiledPatientMedicalHistory,self.textFiledPatientSymptom,self.textFiledPatientMark, nil];
    
    self.arrayKey = [NSArray arrayWithObjects:@"patient_dept",@"patient_hospital",@"patient_city",@"patient_address",@"patient_name",@"patient_age",@"patient_mobile",@"patient_illness",@"anamnesis",@"symptom",@"remark",nil];
    
    
    [self initUI];
    
    self.textFiledPatientSymptom.enabled = YES;
    self.textFiledPatientMedicalHistory.enabled = NO;
    self.timelySelected = YES;
    self.sexSelected = NO;
    
    

}

- (IBAction)SendPhoto:(UIButton *)sender {
    self.count_Button=sender.tag;
    [self setImageOfFeedBack];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;

    
}

- (IBAction)goToDisease:(UIButton *)sender {
    
    SelectDieaseCtrl* vc = [[SelectDieaseCtrl alloc] initWithNibName:@"SelectDieaseCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)goHistoryOfDisease:(UIButton *)sender {
    
    SelectHistoryOfDieaseCtrl* vc = [[SelectHistoryOfDieaseCtrl alloc] initWithNibName:@"SelectHistoryOfDieaseCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)handleSpecialSelectedWithDic:(NSDictionary *)dic
{
    self.showData=[NSDictionary dictionaryWithDictionary:dic];
}


-(void)setImageOfFeedBack
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"拍照", @"相簿", nil];

        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            [sheet showInView:self.view];
        else
            [sheet showFromRect:CGRectMake(600, 0, 100, 80) inView:self.view animated:YES];
        
    }
    else
    {
        [self goLibrary];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0: // camera
            [self goCamera];
            break;
            
        case 1: // album
            [self goLibrary];
            break;
            
        case 2: // cancel
            break;
    }
}

- (void)goCamera
{
    CameraCtrl *camera=[[CameraCtrl alloc] init];
    camera.cameraDelegate=self;
    
    camera.count=self.count_Button;
    camera.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:camera animated:YES completion:nil];
}

- (void)goLibrary
{
    CameraCtrl *camera=[[CameraCtrl alloc] init];
    camera.cameraDelegate=self;
    camera.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    camera.count=self.count_Button;
    [self presentViewController:camera animated:YES completion:nil];
}

-(void)getImage:(UIImage *)image whichNum:(NSUInteger)count
{
    if (count==0) {
       [self.img_left setImage:image];
        self.isLeft = YES;
    }
    else if (count==1)
    {
    [self.img_middle setImage:image];
        self.isMiddle = YES;
    }
    else
    {
    [self.img_right setImage:image];
        self.isRight = YES;
    }
    
    
}

-(void)initUI
{
    self.showDateOrNot=YES;
    
    self.txt_ReserveDate.hidden=YES;
    self.lbl_ReserveDate.hidden=YES;
    
    self.btn_agreeOtherSpecilist.hidden=NO;
    self.btn_checkAgree.hidden=NO;
    self.lbl_agreeOtherExpert.hidden=NO;
    
    self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 1200, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    NSDate *currentTime = [NSDate date];
    [self.datePicker setDate:currentTime animated:NO];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];

    
    self.datePicker.hidden=YES;
    
    [self.myScroll addSubview:self.datePicker];
    
    [HKCommen addHeadTitle:@"会诊资料" whichNavigation:self.navigationItem];
    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    
    /*
    if ([UIScreen mainScreen].bounds.size.width>=375) {
        [self.star setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3.6, 60, 82, 15)];
    }
    else
    {
        [self.star setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3.1, 60, 82, 15)];
    }
    */
    
    [self.star setFrame:CGRectMake(0, 0, 82, 15)];
    
    self.star.whichValue=2.0;
    [self.viewForStar addSubview:self.star];
    
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
    self.btn_agreeOtherSpecilist.tag=0;
    [self.btn_agreeOtherSpecilist setImage:[UIImage imageNamed:@"list_check-icon"] forState:UIControlStateNormal];
    
    self.img_Boy.tag=0;
    [self.img_Boy setImage:[UIImage imageNamed:@"btn_nom"]];
    
    self.img_Girl.tag=0;
    [self.img_Girl setImage:[UIImage imageNamed:@"btn_nom"]];
    
    self.img_RightNow.tag=0;
    [self.img_RightNow setImage:[UIImage imageNamed:@"btn_nom"]];
    
    self.img_NotRightNow.tag=0;
    [self.img_NotRightNow setImage:[UIImage imageNamed:@"btn_nom"]];
    
    for (UIView* subView in [self.myView subviews]) {
        
        if ([subView isMemberOfClass:[UITextField class]]) {
            
            [subView.layer setBorderWidth:1.0];
            [subView.layer setBorderColor:[UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor];
            
        }
    }
    
    
    //UI数据绑定
    self.lblName.text = self.expert.name;//item[@"name"];
    self.lblDept.text = self.expert.dept;//item[@"dept"];
    self.lblDeptAndSurgery.text = self.expert.dept;//item[@"dept"];
    self.lblIntro.text = self.expert.intro; //@"赶紧快点搞完吧快点搞完吧快点搞完吧少年们赶紧快点搞完吧快点搞完吧快点搞完吧少年们赶紧快点搞完吧快点搞完吧快点搞完吧少年们";//item[@"intro"];
    self.lblPro.text = self.expert.position;//item[@"position"];
    
//    if (self.expert.doctorFiles.count != 0) {
//        
//        Doctorfiles* files = [self.expert.doctorFiles objectAtIndex:0];
//        
//        [self.imgHeadPhoto sd_setImageWithURL:files.path
//                             placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
//    }
    
    
    for (int i = 0; i < self.expert.doctorFiles.count; i ++) {
        
        Doctorfiles* file = [self.expert.doctorFiles objectAtIndex:i];
        
        if (file.type == 1) {
            
            
            [self.imgHeadPhoto sd_setImageWithURL:file.path
                             placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
        }
        
    }
    
    
    [self.star  setStarForValue:self.expert.avg_score.floatValue];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)Choose_SexBoy:(UIButton *)sender {

    sexSelected = NO;
    [self setSexSelected:sexSelected];
}

- (IBAction)Choose_SexGirl:(UIButton *)sender {

    sexSelected = YES;
    [self setSexSelected:sexSelected];
}

- (IBAction)Choose_RightNow:(UIButton *)sender {

    self.timelySelected = YES;
    [self setTimelySelected:self.timelySelected];
}

- (IBAction)Choose_NotRightNow:(UIButton *)sender {

    self.timelySelected = NO;
    [self setTimelySelected:self.timelySelected];
}


- (IBAction)AgreeWithOhterSpecilist:(UIButton *)sender {
    
    if (self.btn_agreeOtherSpecilist.tag==1) {
        
        self.btn_agreeOtherSpecilist.tag=0;
        
        [self.btn_agreeOtherSpecilist setImage:[UIImage imageNamed:@"list_check-icon"] forState:UIControlStateNormal];
        
    
    }
    else
    {
        self.btn_agreeOtherSpecilist.tag=1;
        
        
        [self.btn_agreeOtherSpecilist setImage:[UIImage imageNamed:@"list_no-check-icon"] forState:UIControlStateNormal];
        
    }
}




-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)commitMyInfo:(UIButton *)sender {
    
    NSMutableDictionary* dic = [[NSMutableDictionary alloc] init];

    
    for (int i = 0; i < self.arrayTextFiled.count ; i ++ ) {
        
        NSString* strTitel = [self.arrayTint objectAtIndex:i];
        
        UITextField* textFiled = [self.arrayTextFiled objectAtIndex:i];
        
        if ([textFiled.text isEqualToString:strTitel] || [textFiled.text isEqualToString:@""]) {
            
            if (textFiled == self.textFiledPatientMark) {
                
                textFiled.text = @"暂无备注";
                
            }else{
            
                [HKCommen addAlertViewWithTitel:strTitel];
                
                return;
            
            }
            
            
        }
        
        if (!textFiled.text) {
            
            [HKCommen addAlertViewWithTitel:strTitel];
            
            return;
            
        }
        
        
        
        [dic setObject:textFiled.text forKey:[self.arrayKey objectAtIndex:i]];
        
//        if (textFiled == self.textFiledPatientSymptom) {
        
            
//        [dic setObject:self.strSymptom forKey:[self.arrayKey objectAtIndex:i]];
//            
//            
//        }
//        
//        if (textFiled == self.textFiledPatientMedicalHistory) {
//            
//            
//            [dic setObject:self.strSnamnesis forKey:[self.arrayKey objectAtIndex:i]];
//        }
            
        
        if (textFiled == self.textFiledPatientAge) {
            
            if ([self.textFiledPatientAge.text integerValue] > 200 || [self.textFiledPatientAge.text integerValue] < 1) {
            
                [HKCommen addAlertViewWithTitel:@"请填写正确的年龄"];
                
                return;
                
            }
           
            [dic setObject:[NSNumber numberWithInt:[self.textFiledPatientAge.text integerValue]] forKey:[self.arrayKey objectAtIndex:i]];
        }
        
        if (textFiled == self.textFiledPatientTel) {
            
            if (![HKCommen validateMobileWithPhoneNumber:self.textFiledPatientTel.text]) {
                
                [HKCommen addAlertViewWithTitel:@"请填写正确的手机号"];
                
                return;
                
            }
            
            
            
        }
        
        
    }
    
    NSLog(@"[UserDataManager shareManager].userId = %@",[UserDataManager shareManager].userId);
    
    [dic setObject:[NSNumber numberWithInteger:[[UserDataManager shareManager].userId integerValue]] forKey:@"doctor_id"];
    
    [dic setObject:[NSNumber numberWithInteger:self.expert.id] forKey:@"expert_id"];
    
    if (self.sexSelected == YES) {
        
        [dic setObject:@1 forKey:@"patient_sex"];
        
    }else{
        
        [dic setObject:@0 forKey:@"patient_sex"];
    }
    
    if (self.timelySelected == YES) {
        
        [dic setObject:@1 forKey:@"timely"];
        
        
    }else{
        
        [dic setObject:@0 forKey:@"timely"];
        
    }
    if (self.btn_agreeOtherSpecilist.tag == 0) {
        
        [dic setObject:@"1" forKey:@"other_order"];
        
    }else{
        
        [dic setObject:@"0" forKey:@"other_order"];
    
    }
    
    
    
    if ([self.txtPurpose.text isEqualToString:@""] || self.txtPurpose.text == nil) {
        
        [dic setObject:self.txtPurpose.text forKey:@"purpose"];
        
    }
    
    if (self.timelySelected == NO) {
        
        if ([self.txt_ReserveDate.text isEqualToString:@""] || self.txt_ReserveDate.text == nil ) {
            
            [HKCommen addAlertViewWithTitel:@"请选择日期"];
            
            return;
            
            
        }else{
        
            NSString* strDate = [self.txt_ReserveDate.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
            [dic setObject:strDate forKey:@"created_at"];
        }
        
    }
    
    //统一先设置为手术
    
    [dic setObject:[NSNumber numberWithInteger:self.type] forKey:@"type"];

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    [[NetworkManager shareMgr] server_createConsultWithDic:dic completeHandle:^(NSDictionary *response) {
        
        [hud hide:YES];
        
        if ([[response objectForKey:@"success"] integerValue] == 1) {
            
            NSLog(@"consulatasion sucess = %@",response);
            
            if (self.isLeft || self.isRight || self.isMiddle) {
                
                
                NSMutableDictionary* dicNew = [[NSMutableDictionary alloc] init];
                
                [dicNew setObject:[[response objectForKey:@"data"] objectForKey:@"id"] forKey:@"consultation_id"];
                
                [dicNew setObject:@"path" forKey:@"field"];
                
                NSInteger num = self.isMiddle + self.isRight + self.isLeft;
                
                NSMutableArray* array = [[NSMutableArray alloc] init];
                
                if (self.isLeft) {
                    
                    [array addObject:UIImagePNGRepresentation(self.img_left.image)];
                    
                }
                
                if (self.isMiddle) {
                         
                    [array addObject:UIImagePNGRepresentation(self.img_middle.image)];
                          
                }
                          
                if (self.isRight) {
                         
                    [array addObject:UIImagePNGRepresentation(self.img_right.image)];
                          
                }
               
                     
                     
                if (num == 1) {
                    
                    if (self.isRight) {
                        [dicNew setObject:@"3" forKey:@"type"];
                    }
                    
                    if (self.isLeft) {
                        [dicNew setObject:@"1" forKey:@"type"];
                    }
                    
                    if (self.isMiddle) {
                        [dicNew setObject:@"2" forKey:@"type"];
                    }
                    
                    
                    
                    
                }else if (num == 2){
                    
                    if (self.isRight == NO) {
                        [dicNew setObject:@"1,2" forKey:@"fieldVal[type]"];
                    }
                    
                    if (self.isLeft == NO) {
                        [dicNew setObject:@"2,3" forKey:@"fieldVal[type]"];
                    }
                    
                    if (self.isMiddle == NO) {
                        [dicNew setObject:@"1,3" forKey:@"fieldVal[type]"];
                    }
                    
                
                }else{
                    
                    [dicNew setObject:@"1,2,3" forKey:@"fieldVal[type]"];
                    
                
                }
                
                [dicNew setObject:array forKey:@"file[]"];

                
                [[NetworkManager shareMgr] server_createConsulationImageWithDic:dicNew completeHandle:^(NSDictionary *response1) {
                    
                    
                    
                }];
            }
            

            
            if (self.timelySelected == YES) {
                
        
                GSConsulation*  consulation = [GSConsulation  objectWithKeyValues:[response objectForKey:@"data"]];
                
                GreatDoctorCtrl *vc=[[GreatDoctorCtrl alloc]initWithNibName:@"GreatDoctorCtrl" bundle:nil];
                
                vc.consulation = consulation;
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }else{
            
                
                SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"提交咨询成功,是否返回主页?"];
                [alertView addButtonWithTitle:@"确认"
                                         type:SIAlertViewButtonTypeCancel
                                      handler:^(SIAlertView *alertView) {
                                          [self.navigationController popToRootViewControllerAnimated:YES];
                                      }];
                [alertView addButtonWithTitle:@"取消"
                                         type:SIAlertViewButtonTypeDefault
                                      handler:^(SIAlertView *alertView) {
                                          
                                      }];
                alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
                alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
                
                alertView.willShowHandler = ^(SIAlertView *alertView) {
                    NSLog(@"%@, willShowHandler3", alertView);
                };
                alertView.didShowHandler = ^(SIAlertView *alertView) {
                    NSLog(@"%@, didShowHandler3", alertView);
                };
                alertView.willDismissHandler = ^(SIAlertView *alertView) {
                    NSLog(@"%@, willDismissHandler3", alertView);
                };
                alertView.didDismissHandler = ^(SIAlertView *alertView) {
                    NSLog(@"%@, didDismissHandler3", alertView);
                };
                
                [alertView show];
                
            
            }
            
            
        }else{
        
            [HKCommen addAlertViewWithTitel:@"创建咨询失败"];
        
        }
    
    } failHandle:^{
        
        hud.hidden = YES;
        
        [HKCommen addAlertViewWithTitel:@"创建咨询失败"]; 
        
    } ];

}

- (void)setSexSelected:(BOOL)value
{
    if (value == YES) {
        
        [self.img_Boy setImage:[UIImage imageNamed:@"btn_nom"]];
        [self.img_Girl setImage:[UIImage imageNamed:@"btn_pre"]];
        
    }else{
        
        [self.img_Boy setImage:[UIImage imageNamed:@"btn_pre"]];
        [self.img_Girl setImage:[UIImage imageNamed:@"btn_nom"]];
    
    }
    
    sexSelected = value;

}

- (void)setTimelySelected:(BOOL)value
{
    timelySelected = value;
    
    if (value == YES) {
        
        [self.img_RightNow setImage:[UIImage imageNamed:@"btn_pre"]];
        [self.img_NotRightNow setImage:[UIImage imageNamed:@"btn_nom"]];
        

        
        self.txt_ReserveDate.hidden=YES;
        self.lbl_ReserveDate.hidden=YES;
        
        self.btn_agreeOtherSpecilist.hidden=NO;
        self.btn_checkAgree.hidden=NO;
        self.lbl_agreeOtherExpert.hidden=NO;

        
        
    }else{
    
        [self.img_RightNow setImage:[UIImage imageNamed:@"btn_nom"]];
        [self.img_NotRightNow setImage:[UIImage imageNamed:@"btn_pre"]];

        
        
        self.txt_ReserveDate.hidden=NO;
        self.lbl_ReserveDate.hidden=NO;
        
        self.btn_agreeOtherSpecilist.hidden=YES;
        self.btn_checkAgree.hidden=YES;
        self.lbl_agreeOtherExpert.hidden=YES;
        
    }
    
    
}

- (void)getDateData:(NSString*)date
{
    self.txt_ReserveDate.text=date;
}

- (IBAction)MakeDateAppear:(UIButton *)sender {
    
    SelectDateCtrl *vc=[[SelectDateCtrl alloc]initWithNibName:@"SelectDateCtrl" bundle:nil];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
;
-(void)dateChanged:(id)sender{
    　UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* dateChange = control.date;

    NSString *date = [NSString stringWithFormat:@"%@",dateChange];
    self.txt_ReserveDate.text= [date substringToIndex:10];
    
    
}

- (void)handleDieaseSelectedWithDic:(NSString*)str
{
   // NSLog(@"dic  handleDieaseSelectedWithDic= %@",dic);
    
    //self.textFiledPatientSymptom.text = [dic objectForKey:@"name"];
    self.textFiledPatientSymptom.text = str;
   // self.strSymptom  = [NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]];
}

- (void)handleHistoryOfDieaseSelectedWithDic:(NSString *)str
{
    
//    NSLog(@"dic  handleHistoryOfDieaseSelectedWithDic= %@",dic);
//    self.textFiledPatientMedicalHistory.text = [dic objectForKey:@"name"];
    
    self.textFiledPatientMedicalHistory.text = str;// [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
//    self.strSnamnesis  = [NSNumber numberWithInteger:[[dic objectForKey:@"id"] integerValue]];

}


@end
