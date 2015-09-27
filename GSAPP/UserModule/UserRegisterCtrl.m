
//  UserRegisterCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/18.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "UserRegisterCtrl.h"
#import "NetWorkManager.h"
#import "MBProgressHUD.h"
#import "CameraCtrl.h"

@interface UserRegisterCtrl ()<UIActionSheetDelegate>


@property (nonatomic, strong) IBOutlet UITextField* textFiledCity;
@property (nonatomic, strong) IBOutlet UITextField* textFiledAdress;
@property (nonatomic, strong) IBOutlet UITextField* textFiledName;
@property (nonatomic, strong) IBOutlet UITextField* textFiledEmail;
@property (nonatomic, strong) IBOutlet UITextField* textFiledQQ;
@property (nonatomic, strong) IBOutlet UITextField* textFiledWeixin;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPhone;
@property (nonatomic, strong) IBOutlet UITextField* textFiledHospital;
@property (nonatomic, strong) IBOutlet UITextField* textFiledDept;
@property (nonatomic, strong) IBOutlet UITextField* textFiledPositon;
@property (nonatomic, strong) IBOutlet UITextField* textFiledProfeciton;
@property (nonatomic, strong) IBOutlet UITextField* textFiledExpertise;
@property (nonatomic, strong) IBOutlet UITextField* textFiledIdCard;
@property (nonatomic, strong) IBOutlet UITextField* textFiledIntro;
//@property (nonatomic, strong) IBOutlet UITextField* textFiledCity;

@property (nonatomic, strong) IBOutlet UIImageView* imgTypeDoctor;
@property (nonatomic, strong) IBOutlet UIImageView* imgTypeExpert;
@property (nonatomic, strong) IBOutlet UIImageView* imgSexMan;
@property (nonatomic, strong) IBOutlet UIImageView* imgSexWoMan;
@property (nonatomic, strong) IBOutlet UIImageView* imgId;
@property (nonatomic, strong) IBOutlet UIImageView* imgZigezheng;
@property (nonatomic, strong) IBOutlet UIImageView* imgHead;
@property (nonatomic, strong) IBOutlet UIButton* btnImageZigezheng;
@property (nonatomic, strong) IBOutlet UIButton* btnImageId;
@property (nonatomic, strong) IBOutlet UIButton* btnImageHead;

@property NSInteger numOfSelect;
@property BOOL isHanZigezheng;
@property BOOL isHanId;
@property BOOL isHanHead;

@property NSInteger strType;
@property NSInteger strSex;

@property (nonatomic, strong)  UIImage* imgZigezhenghahhah;
@property (nonatomic, strong)  UIImage* imgIdhehe;
@property (nonatomic, strong)  UIImage* imgHeadHehe;

@property (nonatomic, strong) NSArray* arrayText;




@end

@implementation UserRegisterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    self.arrayText = [NSArray arrayWithObjects:self.textFiledName,self.textFiledEmail,self.textFiledQQ,self.textFiledWeixin,self.textFiledPhone,self.textFiledAdress,self.textFiledDept,self.textFiledPositon,self.textFiledProfeciton,self.textFiledExpertise,self.textFiledIntro ,nil];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    
}



- (void)configNav
{
    //创建navbar
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    //创建navbaritem
    UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:@"填写完整资料"];
    
    [nav pushNavigationItem:NavTitle animated:YES];
    
    [self.view addSubview:nav];
    
    
    [[UINavigationBar appearance] setBarTintColor:[HKCommen getColor:@"4fc1e9"]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes =  [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void)initUI
{
    self.myScroll.contentSize=CGSizeMake(0, 1300);
    
    
    
    [self configNav];
    
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 48, 83)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    for (UIView *view in self.myScroll.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UIView *subView=[[UIView alloc]init];
            [subView setFrame:CGRectMake(0, 0, 10, 100)];
            
            UITextField *textField=(UITextField *)view;
            textField.leftView=subView;
            textField.leftViewMode=UITextFieldViewModeAlways;
            
            [view.layer setBorderWidth:1.0];
            [view.layer setBorderColor:[UIColor colorWithRed:164.0/255.0 green:164.0/255.0 blue:164.0/255.0 alpha:1.0].CGColor];
        }
    }
    
    
    
}
- (IBAction)goRegister:(UIButton *)sender {
    
    NSMutableDictionary* dicUser = [[NSMutableDictionary alloc] init];
    [dicUser setObject:self.strPhone forKey:@"username"];
    [dicUser setObject:self.strPassword forKey:@"password"];
    
    if (!self.textFiledEmail.text) {
        
        self.textFiledEmail.text = @"475002739@qq.com";
        [dicUser setObject:@"475002739@qq.com" forKey:@"email"];
    }
    
    NSMutableDictionary* dicDoctor = [[NSMutableDictionary alloc] init];

    [dicDoctor setObject:self.strPhone forKey:@"username"];
    [dicDoctor setObject:self.strPassword forKey:@"password"];
    
    if (!self.textFiledName.text) {
        
        [HKCommen addAlertViewWithTitel:@"请填写姓名"];
        
        return;

    }else{
    
        [dicDoctor setObject:self.textFiledName.text forKey:@"name"];
    
    }
    
    //专家参数
//    if (self.strType == 1) {
    
        
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
        
        if (!self.textFiledProfeciton.text || [self.textFiledProfeciton.text isEqualToString:@""]) {
            
            [HKCommen addAlertViewWithTitel:@"请填写职称"];
            
            return;
            
        }else{
            
            [dicDoctor setObject:self.textFiledProfeciton.text forKey:@"title"];
            
        }
        
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
    
    if (!self.textFiledCity.text || [self.textFiledCity.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请填写城市"];
        
        return;
        
    }else{
        
        [dicDoctor setObject:self.textFiledCity.text forKey:@"city"];
        
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
    
            [dicDoctor setObject:self.strPhone forKey:@"mobile"];
        
//        }
    
        if (self.textFiledAdress.text && ![self.textFiledHospital.text isEqualToString:@""]) {
            
            [dicDoctor setObject:self.textFiledAdress.text forKey:@"address"];
            
        }else{
            
            [HKCommen addAlertViewWithTitel:@"请填写地址"];
            
            return;
        }
        
        
        
//    }else{
//        
//    
//        if (!self.textFiledHospital.text) {
//            
//
//            
//        }else{
//            
//            [dicDoctor setObject:self.textFiledHospital.text forKey:@"hospital"];
//            
//        }
//        
//        if (!self.textFiledDept.text) {
//            
//
//            
//        }else{
//            
//            [dicDoctor setObject:self.textFiledDept.text forKey:@"dept"];
//            
//        }
//        
//        if (!self.textFiledPositon.text) {
//            
//
//            
//        }else{
//            
//            [dicDoctor setObject:self.textFiledPositon.text forKey:@"position"];
//            
//        }
//        
//        if (!self.textFiledProfeciton.text) {
//            
//
//            
//        }else{
//            
//            [dicDoctor setObject:self.textFiledProfeciton.text forKey:@"title"];
//            
//        }
//        
//        if (!self.textFiledExpertise.text) {
//            
//
//            
//        }else{
//            
//            [dicDoctor setObject:self.textFiledExpertise.text forKey:@"expertise"];
//            
//        }
//        
//        
//        if (!self.textFiledIdCard.text) {
//            
//
//            
//        }else{
//            
//            [dicDoctor setObject:self.textFiledIdCard.text forKey:@"identity"];
//            
//        }
//        
//        if (!self.txt_Intro.text) {
//
//            
//        }else{
//            
//            [dicDoctor setObject:self.txt_Intro.text forKey:@"intro"];
//            
//        }
//        
//        
//        
//        
//        if (self.textFiledEmail.text) {
//            
//            [dicDoctor setObject:self.textFiledEmail.text forKey:@"email"];
//            
//        }
//        
//        if (self.textFiledQQ.text) {
//            
//            [dicDoctor setObject:self.textFiledQQ.text forKey:@"qq"];
//            
//        }
//        
//        if (self.textFiledWeixin.text) {
//            
//            [dicDoctor setObject:self.textFiledWeixin.text forKey:@"weixin"];
//            
//        }
//        
//        if (self.textFiledPhone.text) {
//            
//            [dicDoctor setObject:self.textFiledPhone.text forKey:@"mobile"];
//            
//        }
//        
//        if (self.textFiledAdress.text) {
//            
//            [dicDoctor setObject:self.textFiledAdress.text forKey:@"address"];
//            
//        }
//    
//    
//    
//    
//    }
    

    [dicDoctor setObject:[NSNumber numberWithInteger:self.strType] forKey:@"type"];
    [dicDoctor setObject:[NSNumber numberWithInteger:self.strSex] forKey:@"sex"];
    [dicDoctor setObject:@1 forKey:@"city_id"];
    

    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
   
    
    
    [[NetworkManager shareMgr] server_registerWithDic:dicUser completeHandle:^(NSDictionary *response) {
        
//        hud.hidden = YES;
        
        if ([[response objectForKey:@"success"] boolValue] == YES) {
            
            [dicDoctor setObject:[NSNumber numberWithInteger:[[[response objectForKey:@"data"] objectForKey:@"id"] integerValue]] forKey:@"user_id"];
            
            
            [[NetworkManager shareMgr] server_createDoctorsWithDic:dicDoctor completeHandle:^(NSDictionary *responseDoctor) {
                
                
                if (self.isHanId || self.isHanZigezheng||self.isHanHead) {
                    
                    
                    NSMutableDictionary* dicNew = [[NSMutableDictionary alloc] init];
                    
                    
                    NSLog(@"server_createDoctorsWithDic ==>Inner.Dic = %@",[responseDoctor objectForKey:@"data"]);
                    
                    [dicNew setObject:[[responseDoctor objectForKey:@"data"] objectForKey:@"id"] forKey:@"doctor_id"];
                    
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
                        
                        
                        
                    }];

                    
                    
                    
                    
                }
                
                
                hud.hidden = YES;
               
                if ([[response objectForKey:@"success"] boolValue] == YES) {
                    
                    
                    [self.navigationController popToRootViewControllerAnimated:YES];
                    
                    
                }else{
                
    

                    
                }
                
                

                
                
                
            }];
            
            
            
            
        }else{
        

            hud.hidden = YES;

        }
        
    }];

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

- (IBAction)selectDoctor:(id)sender
{

    self.strType = 0;
    
    self.imgTypeDoctor.image = [UIImage imageNamed:@"btn_pre.png"];
    self.imgTypeExpert.image = [UIImage imageNamed:@"btn_nom.png"];
 

}

- (IBAction)selectExpert:(id)sender
{
    
    self.strType = 1;
    
    self.imgTypeDoctor.image = [UIImage imageNamed:@"btn_nom.png"];
    self.imgTypeExpert.image = [UIImage imageNamed:@"btn_pre.png"];
    
    
}

- (IBAction)selectMan:(id)sender
{
    
    self.strSex = 0;
    
    self.imgSexMan.image = [UIImage imageNamed:@"btn_pre.png"];
    self.imgSexWoMan.image = [UIImage imageNamed:@"btn_nom.png"];
    
    
}

- (IBAction)selectWoMan:(id)sender
{
    
    self.strSex = 1;
    
    self.imgSexMan.image = [UIImage imageNamed:@"btn_nom.png"];
    self.imgSexWoMan.image = [UIImage imageNamed:@"btn_pre.png"];
    
    
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
