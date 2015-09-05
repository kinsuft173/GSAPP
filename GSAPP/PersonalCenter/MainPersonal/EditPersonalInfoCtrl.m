//
//  EditPersonalInfoCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "EditPersonalInfoCtrl.h"
#import "HKCommen.h"
#import "UserDataManager.h"
#import "NetWorkManager.h"
#import "MBProgressHUD.h"
#import "CameraCtrl.h"

@interface EditPersonalInfoCtrl ()<UIActionSheetDelegate>


@property (nonatomic, strong) IBOutlet UITextField* textFiledAdress;
@property (nonatomic, strong) IBOutlet UITextField* textFiledEmail;
@property (nonatomic, strong) IBOutlet UITextField* textFiledQQ;
@property (nonatomic, strong) IBOutlet UITextField* textFiledWeixin;
@property (nonatomic, strong) IBOutlet UITextField* textFiledHospital;
@property (nonatomic, strong) IBOutlet UITextField* textFiledDept;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPositon;
@property (nonatomic, strong) IBOutlet UITextField* textFiledProfeciton;
@property (nonatomic, strong) IBOutlet UITextField* textFiledExpertise;
@property (nonatomic, strong) IBOutlet UITextField* textFiledIdCard;
@property (nonatomic, strong) IBOutlet UITextField* textFiledIntro;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPhone;
@property (weak, nonatomic) IBOutlet UITextView *txt_Intro;


@property (nonatomic, strong) IBOutlet UIImageView* imgId;
@property (nonatomic, strong) IBOutlet UIImageView* imgZigezheng;
@property (nonatomic, strong) IBOutlet UIImageView* imgHead;



@property NSInteger numOfSelect;
@property BOOL isHanZigezheng;
@property BOOL isHanId;
@property BOOL isHanHead;

@property NSInteger strType;


@property (nonatomic, strong) NSArray* arrayText;

@end

@implementation EditPersonalInfoCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self initUI];
    
    self.arrayText = [NSArray arrayWithObjects:self.textFiledEmail,self.textFiledQQ,self.textFiledWeixin,self.textFiledPhone,self.textFiledAdress,self.textFiledDept,self.textFiledPositon,self.textFiledProfeciton,self.textFiledExpertise,self.textFiledIntro ,nil];    
}

-(void)initUI
{
    self.myScroll.contentSize=CGSizeMake(0, 1100);
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
  //  [self.btn_goSeeDoctor addTarget:self action:@selector(goSeeDoctor) forControlEvents:UIControlEventTouchUpInside];
    
  //   [self.btn_goSeeIdentifierPhoto addTarget:self action:@selector(goSeeIdentifierPhoto) forControlEvents:UIControlEventTouchUpInside];
    
    [HKCommen addHeadTitle:@"填写完整资料" whichNavigation:self.navigationItem];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 50)];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(commitEdit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    for (UIView* subView in [self.myScroll subviews]) {
        
        if ([subView isMemberOfClass:[UITextField class]]) {
            
            [subView.layer setBorderWidth:1.0];
            [subView.layer setBorderColor:[UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor];
            
            if ([subView isEqual:self.txt_Name]) {
                [subView.layer setBorderWidth:0.0];
            }
           else if ([subView isEqual:self.txt_Sex])
            {
                [subView.layer setBorderWidth:0.0];
            }
            
        }
    }

    GSExpert* user = [UserDataManager shareManager].user.doctor;
    
    self.textFiledAdress.text = user.address;
    self.textFiledDept.text = user.dept;
    self.textFiledEmail.text = user.email;
    self.textFiledExpertise.text = user.expertise;
    self.textFiledHospital.text = user.hospital;
    self.txt_Intro.text = user.intro;
    self.textFiledQQ.text = user.qq;
    self.textFiledPhone.text = user.mobile;
    self.textFiledPositon.text = user.position;
    self.textFiledWeixin.text = user.weixin;
    self.textFiledIdCard.text = user.identity;

//    self.textFiledProfeciton.text = user.
    
    [self.imgHead sd_setImageWithURL:[NSURL URLWithString:self.strHeadUrl]
                         placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
    
    [self.imgZigezheng sd_setImageWithURL:[NSURL URLWithString:self.strZigezhengUrl]
                         placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
    
    [self.imgId sd_setImageWithURL:[NSURL URLWithString:self.strIdUrl]
                         placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
    
    
    self.txt_Name.text = user.name;
    self.txt_phone.text = user.mobile;
    self.txt_Sex.text = (user.sex == 1)?@"男":@"女";
    

}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitEdit
{
    NSMutableDictionary* dicDoctor = [[NSMutableDictionary alloc] init];
    
    [dicDoctor setObject:[NSString stringWithFormat:@"%d",[UserDataManager shareManager].user.doctor.id] forKey:@"id"];
//    NSMutableDictionary* dicDoctor;
    
  //  NSLog(@"[UserDataManager shareManager].user.mobile = %@",[UserDataManager shareManager].user.username);
    
    [dicDoctor setObject:[UserDataManager shareManager].user.username forKey:@"username"];

    if (!self.textFiledHospital.text || [self.textFiledHospital.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请填写所在医院"];
        
        return;
        
    }else{
        
        [dicDoctor setObject:self.textFiledHospital.text forKey:@"hospital"];
        
    }
    
    if (!self.textFiledDept.text|| [self.textFiledDept.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请填写所在科室"];
        
        return;
        
    }else{
        
        [dicDoctor setObject:self.textFiledDept.text forKey:@"dept"];
        
    }
    
    if (!self.textFiledPositon.text || [self.textFiledPositon.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请填写职务"];
        
        return;
        
    }else{
        
        [dicDoctor setObject:self.textFiledPositon.text forKey:@"position"];
        
    }
    
//    if (!self.textFiledProfeciton.text || [self.textFiledProfeciton.text isEqualToString:@""]) {
//        
//        [HKCommen addAlertViewWithTitel:@"请填写职称"];
//        
//        return;
//        
//    }else{
//        
//        [dicDoctor setObject:self.textFiledProfeciton.text forKey:@"title"];
//        
//    }
    
    if (!self.textFiledExpertise.text || [self.textFiledExpertise.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请填写专长"];
        
        return;
        
    }else{
        
        [dicDoctor setObject:self.textFiledExpertise.text forKey:@"expertise"];
        
    }
    
    
    if (!self.textFiledIdCard.text || [self.textFiledIdCard.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请填写专长"];
        
        return;
        
    }else{
        
        [dicDoctor setObject:self.textFiledIdCard.text forKey:@"identity"];
        
    }
    
    if (!self.txt_Intro.text || [self.txt_Intro.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请填写简介"];
        
        return;
        
    }else{
        
        [dicDoctor setObject:self.txt_Intro.text forKey:@"intro"];
        
    }
    
    
    
    
    if (self.textFiledEmail.text && ![self.textFiledHospital.text isEqualToString:@""]) {
        
        [dicDoctor setObject:self.textFiledEmail.text forKey:@"email"];
        
    }
    
    if (self.textFiledQQ.text && ![self.textFiledHospital.text isEqualToString:@""]) {
        
        [dicDoctor setObject:self.textFiledQQ.text forKey:@"qq"];
        
    }
    
    if (self.textFiledWeixin.text && ![self.textFiledHospital.text isEqualToString:@""]) {
        
        [dicDoctor setObject:self.textFiledWeixin.text forKey:@"weixin"];
        
    }
    
    //        if (self.textFiledPhone.text && ![self.textFiledHospital.text isEqualToString:@""]) {
    //
    //            [dicDoctor setObject:self.textFiledPhone.text forKey:@"mobile"];
    //
    //        }else{
    
    [dicDoctor setObject:[UserDataManager shareManager].user.username forKey:@"mobile"];
    
    //        }
    
    if (self.textFiledAdress.text && ![self.textFiledHospital.text isEqualToString:@""]) {
        
        [dicDoctor setObject:self.textFiledAdress.text forKey:@"address"];
        
    }else{
        
        [HKCommen addAlertViewWithTitel:@"请填写地址"];
        
        return;
    }
    
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    
    [[NetworkManager shareMgr] server_updateExpertWithDic:dicDoctor completeHandle:^(NSDictionary *responseDoctor) {
        
        
        if (self.isHanId || self.isHanZigezheng||self.isHanHead) {
            
            
            NSMutableDictionary* dicNew = [[NSMutableDictionary alloc] init];
            
           [dicNew setObject:[NSString stringWithFormat:@"%d",[UserDataManager shareManager].user.doctor.id] forKey:@"doctor_id"];
            
            [dicNew setObject:@"path" forKey:@"field"];
            
            NSInteger num = self.isHanId + self.isHanZigezheng + self.isHanHead;
            
            NSMutableArray* array = [[NSMutableArray alloc] init];
            
            
            if (self.isHanHead) {
                
                [array addObject:UIImagePNGRepresentation(self.imgHeadHehe)];
                
            }
            
            if (self.isHanZigezheng) {
                
                [array addObject:UIImagePNGRepresentation(self.imgZigezhenghahhah)];
                
            }
            
            if (self.isHanId) {
                
                [array addObject:UIImagePNGRepresentation(self.imgIdhehe)];
                
            }
            
            
            if (num == 1) {
                
                if (self.isHanId) {
                    [dicNew setObject:@"3" forKey:@"type"];
                }
                
                if (self.isHanHead) {
                    [dicNew setObject:@"1" forKey:@"type"];
                }
                
                if (self.isHanZigezheng) {
                    [dicNew setObject:@"2" forKey:@"type"];
                }
                
                
                
            }else if (num == 2){
                
                if (self.isHanId == NO) {
                    [dicNew setObject:@"1,2" forKey:@"fieldVal[type]"];
                }
                
                if (self.isHanHead == NO) {
                    [dicNew setObject:@"2,3" forKey:@"fieldVal[type]"];
                }
                
                if (self.isHanZigezheng == NO) {
                    [dicNew setObject:@"1,3" forKey:@"fieldVal[type]"];
                }
                
                
            }else{
                
                [dicNew setObject:@"1,2,3" forKey:@"fieldVal[type]"];
                
                
            }
            
            [dicNew setObject:array forKey:@"file[]"];
            
            
            [[NetworkManager shareMgr] server_createDoctorImageWithDic:dicNew completeHandle:^(NSDictionary *response1) {
                
                if ([[response1 objectForKey:@"success"] boolValue] == YES) {
                    
                    //[UserDataManager shareManager].user.doctor.doctorFiles = [GSExpert objectWithKeyValues:[responseDoctor objectForKey:@"data"]];
                    
                    
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                    
                }
                
                
                
            }];
            
            
            
            
            
        }
        
        
        hud.hidden = YES;
        
        if ([[responseDoctor objectForKey:@"success"] boolValue] == YES) {
            
            [UserDataManager shareManager].user.doctor = [GSExpert objectWithKeyValues:[responseDoctor objectForKey:@"data"]];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            
            
        }else{
            
            
            
            
        }
        
        
        
        
        
        
    }];
    
    
    
    




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goSeeDoctor
{
    FullImageCtrl *vc=[[FullImageCtrl alloc]initWithNibName:@"FullImageCtrl" bundle:nil];
    vc.title=@"医师资格证";
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)goSeeIdentifierPhoto
{
    FullImageCtrl *vc=[[FullImageCtrl alloc]initWithNibName:@"FullImageCtrl" bundle:nil];
    vc.title=@"身份证照片";
    [self.navigationController pushViewController:vc animated:YES];
}


-(IBAction)setImageOfFeedBack:(UIButton*)sender
{
    
    if (sender == self.btnImageId) {
        
        self.numOfSelect = 1;
        
    }else if(sender == self.btnImageHead ){
        
        self.numOfSelect = 2;
        
    }else{
        
        self.numOfSelect = 0;
        
    }
    
    
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
    
    camera.count= self.numOfSelect;
    camera.sourceType=UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:camera animated:YES completion:nil];
}

- (void)goLibrary
{
    CameraCtrl *camera=[[CameraCtrl alloc] init];
    camera.cameraDelegate= self;
    camera.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    camera.count=self.numOfSelect;
    [self presentViewController:camera animated:YES completion:nil];
}

-(void)getImage:(UIImage *)image whichNum:(NSUInteger)count
{
    if (count==1) {
        
        self.isHanId = YES;
        self.imgIdhehe = image;
        [self.btnImageId setImage:image forState:UIControlStateNormal];
        
    }
    else if(count == 0)
    {
        self.isHanZigezheng = YES;
        self.imgZigezhenghahhah = image;
        [self.btnImageZigezheng setImage:image forState:UIControlStateNormal];
        
    }else{
        
        self.isHanHead= YES;
        self.imgHeadHehe = image;
        [self.btnImageHead setImage:image forState:UIControlStateNormal];
        
    }
    
    
    
}

@end
