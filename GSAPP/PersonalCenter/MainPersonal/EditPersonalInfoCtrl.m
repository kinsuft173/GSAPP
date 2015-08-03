//
//  EditPersonalInfoCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "EditPersonalInfoCtrl.h"
#import "HKCommen.h"

@interface EditPersonalInfoCtrl ()

@end

@implementation EditPersonalInfoCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self initUI];
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
    
    [self.btn_goSeeDoctor addTarget:self action:@selector(goSeeDoctor) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn_goSeeIdentifierPhoto addTarget:self action:@selector(goSeeIdentifierPhoto) forControlEvents:UIControlEventTouchUpInside];
    
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

}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitEdit
{}

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


@end
