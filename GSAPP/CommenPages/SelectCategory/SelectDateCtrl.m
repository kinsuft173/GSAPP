//
//  SelectDateCtrl.m
//  GSAPP
//
//  Created by walter on 15/7/29.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "SelectDateCtrl.h"
#import "HKCommen.h"

@interface SelectDateCtrl ()

@end

@implementation SelectDateCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.datePicker=[[UIDatePicker alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    
    NSDate *currentTime = [NSDate date];
    [self.datePicker setDate:currentTime animated:NO];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.datePicker];
    
    [HKCommen addHeadTitle:@"日期选择" whichNavigation:self.navigationItem];
    
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 40, 50)];
    [rightButton setTitle:@"确认" forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(commit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commit
{
    if (![self.lbl_Date.text isEqualToString:@""]) {
        [self.delegate getDateData:self.lbl_Date.text];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(void)dateChanged:(id)sender{
    　UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* dateChange = control.date;
    
    NSString *date = [NSString stringWithFormat:@"%@",dateChange];
    self.lbl_Date.text= [date substringToIndex:10];
    
    
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
