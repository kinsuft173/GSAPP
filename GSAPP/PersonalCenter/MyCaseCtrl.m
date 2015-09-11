//
//  MyCaseCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/13.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "MyCaseCtrl.h"
#import "MyCaseCell.h"
#import "HKCommen.h"
#import "CaseDetailCtrl.h"
#import "UserDataManager.h"
#import "NetWorkManager.h"

@interface MyCaseCtrl ()

@property (nonatomic, strong) NSMutableArray* arrayDotorUnFinished;
@property (nonatomic, strong) NSMutableArray* arrayDotorFinished;
@property (nonatomic, strong) NSMutableArray* arrayExpertUnFinished;
@property (nonatomic, strong) NSMutableArray* arrayExpertFinished;

@property BOOL isFinished;
@end

@implementation MyCaseCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initUI];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"notify" object:nil];
   [self getModel];
}

- (IBAction)go:(UISegmentedControl*)sender
{
    if (sender.selectedSegmentIndex == 0) {
        
        self.isFinished = NO;
        
        [self.myTable reloadData];
        
    }else{
    
        self.isFinished = YES;
        [self.myTable reloadData];
    }

}

-(void)initUI
{
    [HKCommen addHeadTitle:@"我的案例" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"orderUpdate" object:nil];
}


- (void)getModel
{
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[UserDataManager shareManager].user.doctor.id],@"and[order_doctor_id]",@"consultation.consultationFiles,orderDoctor",@"expand",nil];
        
        [[NetworkManager shareMgr] server_fetchOrderWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            
            
            self.arrayExpertUnFinished = [[NSMutableArray alloc] init];
            self.arrayExpertFinished = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                for (int i= 0 ; i < resultArray.count; i++) {
                    
                    NSDictionary* dicItem = [resultArray objectAtIndex:i];
                    
    
                    
                    if ([[dicItem objectForKey:@"status"] integerValue] == 3  || [[dicItem objectForKey:@"status"] integerValue] == 6) {
                        
                        [self.arrayExpertUnFinished addObject:dicItem];
                        
                    }else if ([[dicItem objectForKey:@"status"] integerValue] == 9 || [[dicItem objectForKey:@"status"] integerValue] == 4  ){
                        
                        [self.arrayExpertFinished addObject:dicItem];
                    }
                    
                }
                
            }
            
            
            
            
            [hud hide:YES];
            [self.myTable reloadData];
            
            
            
            
        }];
        
        
        
        
        
        
    }
    
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[UserDataManager shareManager].user.doctor.id],@"and[doctor_id]", @"consultation.consultationFiles,orderDoctor",@"expand",nil];
        
        [[NetworkManager shareMgr] server_fetchOrderWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            self.arrayDotorUnFinished = [[NSMutableArray alloc] init];
            self.arrayDotorFinished = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                for (int i= 0 ; i < resultArray.count; i++) {
                    
                    NSDictionary* dicItem = [resultArray objectAtIndex:i];
                    
                    if ([[dicItem objectForKey:@"status"] integerValue] == 3 || [[dicItem objectForKey:@"status"] integerValue] == 6) {
                        
                        [self.arrayDotorUnFinished addObject:dicItem];
                        
                    }else if ([[dicItem objectForKey:@"status"] integerValue] == 9|| [[dicItem objectForKey:@"status"] integerValue] == 4){
                    
                        [self.arrayDotorFinished addObject:dicItem];
                    }
                    
                }
                
            }

                

                
                [hud hide:YES];
                [self.myTable reloadData];
                

            
            
        }];

        
        
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

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.isFinished == NO) {
        
        if (section == 0) {
            
            return self.arrayDotorUnFinished.count;
            
        }else{
        
                return self.arrayExpertUnFinished.count;
        
        
        }
        
        
        
    }else{
        
        if (section == 0) {
            
                return self.arrayDotorFinished.count;
            
        }else{
            
                return self.arrayExpertFinished.count;
            
            
        }
        
        
    }
    
    

    
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId = @"MyCaseCell";
    static NSString* CellId2 = @"MyCaseCell2";
    
//    if (indexPath.section == 0) {
    MyCaseCell* cell;
    
    if (self.isFinished == NO ) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellId2];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:1];
            
        }
        
        
    }else{
    
        cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
    }
    
        
        
        
        GSOrder* order;
        
        
        if (self.isFinished == NO) {
            
            if (indexPath.section == 0) {
                
                order = [GSOrder objectWithKeyValues:[self.arrayDotorUnFinished objectAtIndex:indexPath.row]];
                
                cell.btn_comment.hidden = YES;
                cell.btn_tousu.hidden = YES;
                
            }else if ([[UserDataManager shareManager].userType isEqualToString:ExpertType]){
                
                order = [GSOrder objectWithKeyValues:[self.arrayExpertUnFinished objectAtIndex:indexPath.row]];
                
                cell.btn_comment.hidden = YES;
                cell.btn_tousu.hidden = YES;
            }
        }else{
            
            
            
            if (indexPath.section == 0) {
                
                order = [GSOrder objectWithKeyValues:[self.arrayDotorFinished objectAtIndex:indexPath.row]];
                
                cell.btn_comment.hidden = NO;
                cell.btn_tousu.hidden = NO;
                
                
            }else if ([[UserDataManager shareManager].userType isEqualToString:ExpertType]){
                
                order = [GSOrder objectWithKeyValues:[self.arrayExpertFinished objectAtIndex:indexPath.row]];
                
                cell.btn_comment.hidden = YES;
                cell.btn_tousu.hidden = YES;
                
            }
        }
        
        cell.lbl_bingshi.text = order.consultation.anamnesis;//[NSString stringWithFormat:@"%d",order.consultation.anamnesis_id];
        cell.lbl_jibingmiaoshu.text =   order.consultation.patient_illness;//order.consultation.patient_illness;
        cell.lbl_zhuangzhuang.text = order.consultation.symptom;
        
        if (order.type == 0) {
            
            [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_consultation"]];
            cell.lbl_treat.text=@"会诊";
            
        }else{
        
                    [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_surgery"]];
                    cell.lbl_treat.text=@"会诊手术";
        }
        
        return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
    
    GSOrder* order;
    
    if (self.isFinished == NO) {
        
        if (indexPath.section == 0) {
            
            order = [GSOrder objectWithKeyValues:[self.arrayDotorUnFinished objectAtIndex:indexPath.row]];
            caseDetail.type = @"1";
            
            
        }else if (indexPath.section == 1){
            
            order = [GSOrder objectWithKeyValues:[self.arrayExpertUnFinished objectAtIndex:indexPath.row]];
                      caseDetail.type = @"3";
            
            
            
        }
    }else{
        
        
        
        if (indexPath.section == 0) {
            
            order = [GSOrder objectWithKeyValues:[self.arrayDotorFinished objectAtIndex:indexPath.row]];
            
                      caseDetail.type = @"2";
            
        }else if (indexPath.section == 1){
            
            order = [GSOrder objectWithKeyValues:[self.arrayExpertFinished objectAtIndex:indexPath.row]];
                        caseDetail.type = @"4";
            
        }
    }
    
    caseDetail.orderGS = order;
    
    
    
    [self.navigationController pushViewController:caseDetail animated:YES];
    
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    return 52.0;
}

- (UIView * )tableView:(UITableView * )tableView
viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *view=[[UIView alloc]init];
        [view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 52.0)];
        view.backgroundColor=[HKCommen getColor:@"f9f9f9"];
        
        UILabel *lbl_Middle=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5-60-10, 19.0, 120, 16)];
        lbl_Middle.textAlignment=UITextAlignmentCenter;
        [lbl_Middle setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width*0.5-10, 26.0)];
        [lbl_Middle setText:@"我下的单"];
        [lbl_Middle setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        lbl_Middle.font=[UIFont systemFontOfSize:15.0];
        
        UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-10, 1)];
        [leftView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5+lbl_Middle.frame.size.width*0.5-10, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-10, 1)];
        [rightView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        [view addSubview:lbl_Middle];
        [view addSubview:leftView];
        [view addSubview:rightView];
        
        return view;
    }
    else
    {
        UIView *view=[[UIView alloc]init];
        [view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 52.0)];
        view.backgroundColor=[HKCommen getColor:@"f9f9f9"];
        
        UILabel *lbl_Middle=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5-60-10, 19.0, 120, 16)];
        lbl_Middle.textAlignment=UITextAlignmentCenter;
        [lbl_Middle setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width*0.5-10, 26.0)];
        [lbl_Middle setText:@"我接的单"];
        [lbl_Middle setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        lbl_Middle.font=[UIFont systemFontOfSize:15.0];
        
        UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-20, 1)];
        [leftView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5+lbl_Middle.frame.size.width*0.5-5, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-20, 1)];
        [rightView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        [view addSubview:lbl_Middle];
        [view addSubview:leftView];
        [view addSubview:rightView];
        
        return view;
    }
    
    
}


@end
