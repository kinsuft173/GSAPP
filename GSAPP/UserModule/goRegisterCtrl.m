//
//  goRegisterCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/18.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "goRegisterCtrl.h"

@interface goRegisterCtrl ()
@property (weak, nonatomic) IBOutlet UITextField *txt_mobile;
@property (weak, nonatomic) IBOutlet UITextField *txt_code;
@property (weak, nonatomic) IBOutlet UITextField *txt_password;

@end

@implementation goRegisterCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void)initUI
{
    [self configNav];
    
    UIImageView *image_mobile=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_phone"]];
    [image_mobile setFrame:CGRectMake(10, 0, 16, 20)];
    //[image_mobile setContentMode:UIViewContentModeCenter];
    UIView *view_mobile=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 20)];
    [view_mobile addSubview:image_mobile];
    self.txt_mobile.leftView=view_mobile;
    self.txt_mobile.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView *image_code=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_verification-code"]];
    [image_code setFrame:CGRectMake(10, 0, 9, 19)];
    //[image_code setContentMode:UIViewContentModeCenter];
    UIView *view_code=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 20)];
    [view_code addSubview:image_code];
    
    self.txt_code.leftView=view_code;
    self.txt_code.leftViewMode=UITextFieldViewModeAlways;
    
    UIImageView *image_password=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_password"]];
    [image_password setFrame:CGRectMake(10, 0, 15, 19)];
    //[image_password setContentMode:UIViewContentModeCenter];
    UIView *view_password=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 33, 20)];
    [view_password addSubview:image_password];
    self.txt_password.leftView=view_password;
    self.txt_password.leftViewMode=UITextFieldViewModeAlways;
    
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[UITextField class]]) {
            UITextField *textField=(UITextField*)view;
            textField.layer.borderWidth=1.0;
            textField.layer.borderColor=[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:0.8].CGColor;
        }
    }
}

- (void)configNav
{
    //创建navbar
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64)];
    //创建navbaritem
    UINavigationItem *NavTitle = [[UINavigationItem alloc] initWithTitle:@"注册"];
    
    [nav pushNavigationItem:NavTitle animated:YES];
    
    [self.view addSubview:nav];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 48, 83)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    
    
    [[UINavigationBar appearance] setBarTintColor:[HKCommen getColor:@"4fc1e9"]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes =  [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)goNext:(UIButton *)sender {
    UserRegisterCtrl *vc=[[UserRegisterCtrl alloc] initWithNibName:@"UserRegisterCtrl" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
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

@end
