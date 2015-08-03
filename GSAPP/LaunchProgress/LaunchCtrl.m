//
//  LaunchCtrl.m
//  GSAPP
//
//  Created by 胡昆1 on 6/4/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "LaunchCtrl.h"
#import <ReactiveCocoa.h>
#import "HKCommen.h"
#import "UtilityManager.h"
#import <IQKeyboardManager.h>
#import "UserDataManager.h"
#import "NetworkManager.h"
#import "APService.h"

@interface LaunchCtrl ()

@property (nonatomic, strong) IBOutlet HKTextFiled* textFiledUserName;
@property (nonatomic, strong) IBOutlet HKTextFiled* textFiledPassword;
@property (nonatomic, strong) IBOutlet UIButton*    btnLogin;
@property (nonatomic, strong) IBOutlet UIButton*    btnExpertSelected;
@property (nonatomic, strong) IBOutlet UIButton*    btnUserSelected;

@end

@implementation LaunchCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //init UI
    [self.btnUserSelected setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    NSMutableDictionary* userAutoLoginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAutoLoginInfo"];
    
    self.textFiledPassword.text = userAutoLoginInfo[@"passWord"];
    self.textFiledUserName.text = userAutoLoginInfo[@"userName"];
    
    
//    UIImageView*  imgViewUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
//    imgViewUser.image = [UIImage imageNamed:@"bg1.png"];
//    
//    self. textFiledUserName.leftViewMode = UITextFieldViewModeAlways;
//    
//    self.textFiledUserName.leftView = imgViewUser;
//
//    self.textFiledUserName.leftViewMode = UITextFieldViewModeAlways;
//    self.textFiledUserName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    
//    UIImageView*  imgViewPsd = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
//    imgViewPsd.image = [UIImage imageNamed:@"bg2.png"];
//    self.textFiledPassword.leftView = imgViewPsd;
//    self.textFiledPassword.leftViewMode = UITextFieldViewModeAlways;
//    self.textFiledPassword.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    if([userAutoLoginInfo[@"userType"] isEqualToString:@"doctor"]){
        
//      w  [self.btnExpertSelected  sendActionsForControlEvents:UIControlEventTouchDragInside];
        [self.btnExpertSelected setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.btnUserSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    
    
    /***********************************
     创建用户名和密码文本是否有效的信号量
     ***********************************/
    RACSignal *validUsernameSignal =
    [self.textFiledUserName.rac_textSignal
     map:^id(NSString *text) {
         return @([HKCommen validateMobileWithPhoneNumber:text]);
     }];
    
    RACSignal *validPasswordSignal =
    [self.textFiledPassword.rac_textSignal
     map:^id(NSString *text) {
         return @([HKCommen validatePassword:text]);
     }];
    
    /***********************************
     控制textFiled在有效和无效输入值的变色
     ***********************************/
//    RAC(self.textFiledPassword, backgroundColor) =
//    [validPasswordSignal
//     map:^id(NSNumber *passwordValid){
//        return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
//     }];
//    
//    RAC(self.textFiledUserName, backgroundColor) =
//    [validUsernameSignal
//     map:^id(NSNumber *passwordValid){
//        return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor yellowColor];
//     }];
    
    /***********************************
     创建复合信号，在用户名密码都有效的情况下才
     始得登陆按钮使能
     ***********************************/
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                      reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
                          return @([usernameValid boolValue]&&[passwordValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.btnLogin.enabled =[signupActive boolValue];

    }];
    
    /***********************************
     增加用户和专家的选择信号
     ***********************************/
     [[self.btnUserSelected rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(id x) {
         
         [self.btnExpertSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [self.btnUserSelected setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
     }];
    
    [[self.btnExpertSelected rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(id x) {
        
        [self.btnExpertSelected setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.btnUserSelected setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }];
    
    
    /***********************************
     登陆按钮的事件点击
     ***********************************/
    [[[self.btnLogin
      rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^id(id value) {
        
        return [self signInSignal];
        
        }]  subscribeNext:^(NSNumber* x) {
            
            if (x.boolValue == NO && (self.btnExpertSelected.titleLabel.textColor.CGColor == [UIColor redColor].CGColor) ) {
                
            
                     [self goDoctorInterface:nil];
                    

            }else if(x.boolValue == NO){
            
                    [self goUserInterface:nil];
                
            }
            
            NSLog(@"Sign in result: %@", x);
            
     }];
    
    
    /***********************************
     config
     ***********************************/

    
}

- (IBAction)goForgetPassword:(UIButton *)sender {
    
    ForgetPasswordCtrl *vc=[[ForgetPasswordCtrl alloc]initWithNibName:@"ForgetPasswordCtrl" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (RACSignal *)signInSignal {
    return [RACSignal createSignal:^RACDisposable *(id subscriber){
        
        [[UtilityManager shareMgr] signInWithUsername:self.textFiledUserName.text
                                             password:self.textFiledPassword.text
                                             complete:^(BOOL success) {
        
        [subscriber sendNext:@(success)];
        [subscriber sendCompleted];
                                                 
        }];
        
        return nil;
    }];
}

- (IBAction)goUserInterface:(id)sender
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在登录...";
    
    //用户数据保存
    [UserDataManager shareManager].userType = UserType;
    
    NSDictionary* userAutoLoginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAutoLoginInfo"];//[NSDictionary dictionaryWithObjectsAndKeys:@"",@"",@"",@"", nil];
    
    if(!userAutoLoginInfo){
    
        userAutoLoginInfo = [[NSMutableDictionary alloc] init];
        
    }

    NSMutableDictionary* dicTemp = [[NSMutableDictionary alloc] init];//[NSMutableDictionary dictionaryWithDictionary:userAutoLoginInfo];
    
    
    [dicTemp setObject:self.textFiledUserName.text forKey:@"userName"];
    [dicTemp setObject:self.textFiledPassword.text forKey:@"passWord"];
    [dicTemp setObject:@"user" forKey:@"userType"];
    
    [UserDataManager shareManager].userId = @"9";
    
    [[NetworkManager shareMgr] setTags:[UserDataManager shareManager].userId];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:dicTemp forKey:@"userAutoLoginInfo"];
    
    [UserDataManager shareManager].userId = @"9";
    
    
    UIStoryboard* stroyboardUser = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    UIViewController* vc = [stroyboardUser instantiateInitialViewController];
    
//    [APService setAlias:[UserDataManager shareManager].userId callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
//    [APService setTags:[NSSet setWithObject:[UserDataManager shareManager].userId] alias:@"doctor1212234" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
    
    //[UserDataManager shareManager].userId
    

    
    [hud setHidden:YES];
    
    [self presentViewController:vc animated:YES completion:^{

        
        
    }];
    
}


- (IBAction)goDoctorInterface:(id)sender
{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在登录...";
    
    //用户数据保存
    [UserDataManager shareManager].userType = ExpertType;
    
    [UserDataManager shareManager].userId   = @"10";

    //下次登录时的填充数据处理
    NSDictionary* userAutoLoginInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userAutoLoginInfo"];//[NSDictionary dictionaryWithObjectsAndKeys:@"",@"",@"",@"", nil];
    
    if(!userAutoLoginInfo){
    
        userAutoLoginInfo = [[NSMutableDictionary alloc] init];
        
    }
    
    NSMutableDictionary* dicTemp = [[NSMutableDictionary alloc] init]; //[NSMutableDictionary dictionaryWithDictionary:userAutoLoginInfo];
    
    [dicTemp setObject:self.textFiledUserName.text forKey:@"userName"];
    [dicTemp setObject:self.textFiledPassword.text forKey:@"passWord"];
    [dicTemp setObject:@"doctor" forKey:@"userType"];
    
    [[NSUserDefaults standardUserDefaults] setObject:dicTemp forKey:@"userAutoLoginInfo"];
    
    UIStoryboard* stroyboardUser = [UIStoryboard storyboardWithName:@"User" bundle:nil];
    
    UIViewController* vc = [stroyboardUser instantiateInitialViewController];
    
//    [[NetworkManager shareMgr] setTags:[UserDataManager shareManager].userId];
    
//    [APService setTags:[NSSet setWithObject:[UserDataManager shareManager].userId] alias:@"doctor1412222sds" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
    
    [hud setHidden:YES];
    
    [self presentViewController:vc animated:YES completion:^{
        
        
        
    }];

}

- (IBAction)goRegister:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"用户注册"]) {
        
        //[self performSegueWithIdentifier:@"goRegister" sender:nil];
        goRegisterCtrl *vc=[[goRegisterCtrl alloc]initWithNibName:@"goRegisterCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
    
        goRegisterCtrl *vc=[[goRegisterCtrl alloc]initWithNibName:@"goRegisterCtrl" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Jpush回调

//- (void)jpushSetAliasCallBack:(id)sender
//{
//
//
//}


@end
