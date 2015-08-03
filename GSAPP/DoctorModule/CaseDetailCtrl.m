//
//  CaseDetailCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "CaseDetailCtrl.h"
#import "HKCommen.h"
#import "NetWorkManager.h"

@interface CaseDetailCtrl ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_OrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Position;
@property (weak, nonatomic) IBOutlet UILabel *lbl_hospital;
@property (weak, nonatomic) IBOutlet UILabel *lbl_City;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Adress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Patient;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sex;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Age;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Disease;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DiseaseHistory;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sympton;
@property (weak, nonatomic) IBOutlet UILabel *lbl_FinishedTime;
@property (weak, nonatomic) IBOutlet UITextView *lbl_Addition;
@property (weak, nonatomic) IBOutlet UITextView *lbl_Purpose;
@property (weak, nonatomic) IBOutlet UITextView *txt_WriteAddition;

/**********************************************/

@property (weak, nonatomic) IBOutlet UITextView *lbl_CommentOfDoctor;
@property (weak, nonatomic) IBOutlet UITextView *lbl_Complaint;
@property (weak, nonatomic) IBOutlet UITextView *lbl_ExpertAddtion;

/**********************************************/
@property (weak, nonatomic) IBOutlet UITextView *lbl_AdditionOfExpert;
@property (weak, nonatomic) IBOutlet UITextView *lbl_MyComment;
@property (weak, nonatomic) IBOutlet UITextView *lbl_MyComplaint;

@end

@implementation CaseDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myScroll.contentSize=CGSizeMake(0, 1500);
    
    [HKCommen addHeadTitle:@"案例详情" whichNavigation:self.navigationItem];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    self.lbl_OrderNum.text = [NSString stringWithFormat:@"%d",self.orderGS.id];
    self.lbl_Position.text = self.orderGS.consultation.patient_address;
    self.lbl_hospital.text = self.orderGS.consultation.patient_hospital;
    self.lbl_City.text     = self.orderGS.consultation.patient_city;
    self.lbl_Patient.text  = self.orderGS.consultation.patient_name;
    
    if (self.orderGS.consultation.patient_sex == 0) {
        
        self.lbl_Sex.text = @"男";
    }else{
    
        self.lbl_Sex.text = @"女";
    }

    self.lbl_Age.text =  [NSString stringWithFormat:@"%d",self.orderGS.consultation.patient_age];
    
    self.lbl_Disease.text = self.orderGS.consultation.patient_illness;
    self.lbl_DiseaseHistory.text =[NSString stringWithFormat:@"%d",self.orderGS.consultation.anamnesis_id] ;
    self.lbl_Sympton.text =[NSString stringWithFormat:@"%d",self.orderGS.consultation.symptom_id] ;
    self.lbl_FinishedTime.text = self.orderGS.consultation.created_at;
    
    self.lbl_Addition.text = self.orderGS.consultation.remark;
    self.lbl_Purpose.text = self.orderGS.consultation.purpose;
    
    if ([self.type isEqualToString:@"1"]) {
        
        self.view_DoctorCaseNotFinished.hidden = NO;
        self.view_ExpertCaseFinished.hidden = YES;
        self.view_ExpertCaseNotFinished.hidden = YES;
        
    }else    if ([self.type isEqualToString:@"2"]) {
        
//        self.vview.hidden = NO;
        
        
    }else    if ([self.type isEqualToString:@"3"]) {
        
        
        self.view_ExpertCaseNotFinished.hidden = NO;
        self.view_ExpertCaseFinished.hidden = YES;
        self.view_DoctorCaseNotFinished.hidden = YES;
        
    }else    if ([self.type isEqualToString:@"4"]) {
        
        
        self.view_ExpertCaseFinished.hidden = NO;
        self.view_ExpertCaseNotFinished.hidden = YES;
              self.view_DoctorCaseNotFinished.hidden = YES;
        
    }
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goCancel:(id)sender
{
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                      .id],@"id",@4,@"status",nil];
    
    [[NetworkManager shareMgr] server_updateOrderWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        ;
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil];
      [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)goFinish:(id)sender
{
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                      .id],@"id",@9,@"status",nil];
    
    [[NetworkManager shareMgr] server_updateOrderWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        ;
        
    }];
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



@end
