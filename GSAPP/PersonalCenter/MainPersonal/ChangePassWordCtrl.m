//
//  ChangePassWordCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ChangePassWordCtrl.h"
#import "HKCommen.h"

@interface ChangePassWordCtrl ()

@end

@implementation ChangePassWordCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [HKCommen addHeadTitle:@"修改密码" whichNavigation:self.navigationItem];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:15.0];
    [rightButton setFrame:CGRectMake(0, 0, 30, 50)];
    [rightButton setTitle:@"修改" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(commitChangePassword) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    UIView *view=[[UIView alloc] init];
    [view setFrame:CGRectMake(0, 0, 13, 47)];
    self.txt_OldPassword.leftView=view;
    self.txt_OldPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txt_OldPassword.layer.borderWidth=1.0;
    self.txt_OldPassword.layer.borderColor=[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    
    UIView *view2=[[UIView alloc] init];
    [view2 setFrame:CGRectMake(0, 0, 13, 47)];
    self.txt_NewPassword.leftView=view2;
    self.txt_NewPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txt_NewPassword.layer.borderWidth=1.0;
    self.txt_NewPassword.layer.borderColor=[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    
    UIView *view3=[[UIView alloc] init];
    [view3 setFrame:CGRectMake(0, 0, 13, 47)];
    self.txt_CommitPassword.leftView=view3;
    self.txt_CommitPassword.leftViewMode=UITextFieldViewModeAlways;
    self.txt_CommitPassword.layer.borderWidth=1.0;
    self.txt_CommitPassword.layer.borderColor=[UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:214.0/255.0 alpha:1.0].CGColor;
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitChangePassword
{}

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
