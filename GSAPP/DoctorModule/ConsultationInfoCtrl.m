//
//  ConsultationInfoCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/17.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ConsultationInfoCtrl.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "PhotoBroswerVC.h"
#import "UserDataManager.h"
#import <UIImageView+WebCache.h>
#import "ConsulationManager.h"

@interface ConsultationInfoCtrl ()

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;
@property (nonatomic,strong) NSArray *images;

@property (nonatomic, strong) IBOutlet UILabel* lblDoctorDept;
@property (nonatomic, strong) IBOutlet UILabel* lblDoctorHospital;
@property (nonatomic, strong) IBOutlet UILabel* lblDoctorCity;
@property (nonatomic, strong) IBOutlet UILabel* lblDoctorAdress;
@property (nonatomic, strong) IBOutlet UILabel* lblPatientName;
@property (nonatomic, strong) IBOutlet UILabel* lblPatientAge;
@property (nonatomic, strong) IBOutlet UILabel* lblPatientTel;
@property (nonatomic, strong) IBOutlet UILabel* lblPatientDisease;
@property (nonatomic, strong) IBOutlet UILabel* lblPatientMedicalHistory;
@property (nonatomic, strong) IBOutlet UILabel* lblPatientSymptom;
@property (nonatomic, strong) IBOutlet UILabel* lblPatientMark;
@property (nonatomic, strong) IBOutlet UILabel* lblTime;
@property (nonatomic, strong) IBOutlet UITextView* txtPatientMark;
@property (nonatomic, strong) IBOutlet UITextView* txtPurpose;

@end

@implementation ConsultationInfoCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    
    
    self.scrollView.contentSize = CGSizeMake( SCREEN_WIDTH, 1300);
}

- (void)initUI
{
//    @property (nonatomic, assign) NSInteger status;
//    
//    @property (nonatomic, copy) NSString *order_at;
//    
//    @property (nonatomic, assign) NSInteger other_order;
//    
//    @property (nonatomic, copy) NSString *patient_mobile;
//    
//    @property (nonatomic, copy) NSString *patient_illness;
//    
//    @property (nonatomic, copy) NSString *patient_address;
//    
//    @property (nonatomic, assign) NSInteger doctor_id;
//    
//    @property (nonatomic, copy) NSString *patient_dept;
//    
//    @property (nonatomic, copy) NSString *patient_name;
//    
//    @property (nonatomic, assign) NSInteger type;
//    
//    @property (nonatomic, copy) NSString *purpose;
//    
//    @property (nonatomic, assign) NSInteger id;
//    
//    @property (nonatomic, assign) NSInteger anamnesis_id;
//    
//    @property (nonatomic, copy) NSString *patient_hospital;
//    
//    @property (nonatomic, assign) NSInteger timely;
//    
//    @property (nonatomic, copy) NSString *patient_city;
//    
//    @property (nonatomic, assign) NSInteger symptom_id;
//    
//    @property (nonatomic, copy) NSString *created_at;
//    
//    @property (nonatomic, assign) NSInteger patient_sex;
//    
//    @property (nonatomic, copy) NSString *remark;
//    
//    @property (nonatomic, assign) NSInteger patient_age;
    
    self.lblDoctorAdress.text =  self.consulation.patient_address;
    self.lblDoctorDept.text = self.consulation.patient_dept;
    self.lblDoctorHospital.text = self.consulation.patient_hospital;
    self.lblDoctorCity.text = self.consulation.patient_city;
    self.lblDoctorAdress.text = self.consulation.patient_address;
    self.lblPatientName.text = self.consulation.patient_name;
    self.lblPatientAge.text =  [NSString stringWithFormat:@"%ld",self.consulation.patient_age];
    self.lblPatientTel.text = self.consulation.patient_mobile;
    self.lblPatientDisease.text = self.consulation.patient_illness;
    self.lblPatientMedicalHistory.text =  self.consulation.anamnesis;//[NSString stringWithFormat:@"%ld",self.consulation.anamnesis_id];
    self.lblPatientSymptom.text =  self.consulation.symptom;//[NSString stringWithFormat:@"%ld",self.consulation.symptom_id];
    self.lblPatientMark.text = self.consulation.remark;
//    self.lblTime.text = self.consulation.
    
    self.txtPatientMark.text = self.consulation.remark;
    self.txtPurpose.text = self.consulation.purpose;
    
    self.txtPatientMark.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    self.txtPurpose.font = [UIFont fontWithName:@"Helvetica" size:17.0];
    
    self.txtPatientMark.textColor = [HKCommen getColor:@"6A6A6A"];
    self.txtPurpose.textColor     = [HKCommen getColor:@"6A6A6A"];
    
    
    NSLog(@"self.consulation.consultationFiles.count = %d",self.consulation.consultationFiles.count);
    
    if (self.consulation.consultationFiles.count != 0) {
        
        for (int i = 0; i < self.self.consulation.consultationFiles.count ; i ++) {
            
            
            Consultationfiles* file =[self.consulation.consultationFiles objectAtIndex:i];
            
            if (file.type == 1 ) {
                
                
                if (![[file.path class] isSubclassOfClass:[NSNull class]]) {
                    
                    [self.img_left sd_setImageWithURL:[NSURL URLWithString:file.path]
                                 placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
                }
                
                
            }
            
            if (file.type == 2 ) {
                
                
                if (![[file.path class] isSubclassOfClass:[NSNull class]]) {
                    
                    [self.img_middle sd_setImageWithURL:[NSURL URLWithString:file.path]
                                     placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
                }
                
                
            }
            
            if (file.type == 3 ) {
                
                
                if (![[file.path class] isSubclassOfClass:[NSNull class]]) {
                    
                    [self.img_right sd_setImageWithURL:[NSURL URLWithString:file.path]
                                     placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
                }
                
                
            }
        
        
        }
        
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SeeMyImage:(UIButton *)sender {
    [self localImageShow:sender.tag];
}

/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index{
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        NSArray *localImages = weakSelf.images;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image = localImages[i];
            
            if (index==0) {
                pbModel.sourceImageView = self.img_left;
            }
            else if (index==1)
            {
            pbModel.sourceImageView = self.img_middle;
            }
            else
            {
            pbModel.sourceImageView = self.img_right;
            }

            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}

-(NSArray *)images{
    
    if(_images ==nil){
        NSMutableArray *arrayM = [NSMutableArray array];
        

        [arrayM addObject:self.img_left.image];
        [arrayM addObject:self.img_middle.image];
        [arrayM addObject:self.img_right.image];
        
        _images = arrayM;
    }
    
    return _images;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirm:(id)sender
{
    NSDictionary *parameters = @{@"doctor_id":[NSString stringWithFormat:@"%ld",(long)self.consulation.doctor_id],@"order_doctor_id":[UserDataManager shareManager].userId,@"consultation_id":[NSString stringWithFormat:@"%ld",(long)self.consulation.id]};
    
    [[NetworkManager shareMgr] server_createOrderWithDic:parameters completeHandle:^(NSDictionary * dic) {
        
        if (dic) {
            
            [[ConsulationManager shareMgr] addHandledConsulation:[NSString stringWithFormat:@"%d",self.consulation.id]];            
            
            [HKCommen addAlertViewWithTitel:@"接单成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
            
        }
        
        
        
    }];
}

- (IBAction)confuse:(id)sender
{
    

    
    if (self.consulation.other_order == 0 && self.consulation.expert_id == [UserDataManager shareManager].userId.integerValue ) {
        

        
            NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.consulation.id],@"id",@4,@"status", nil];
        
                [[NetworkManager shareMgr] server_updateConsultWithDic:dic completeHandle:^(NSDictionary * dic) {
        
             
        
                    if (dic) {
        
                        [HKCommen addAlertViewWithTitel:@"已拒绝处理该咨询"];
                        
                        [[ConsulationManager shareMgr] addHandledConsulation:[NSString stringWithFormat:@"%d",self.consulation.id]];
        
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }
                    
            }];
        
        
        
    }else{
    
        [HKCommen addAlertViewWithTitel:@"已拒绝处理该咨询"];
    
        [[ConsulationManager shareMgr] addHandledConsulation:[NSString stringWithFormat:@"%d",self.consulation.id]];
        
        [self.navigationController popViewControllerAnimated:YES];
    
    }
    

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

}


@end
