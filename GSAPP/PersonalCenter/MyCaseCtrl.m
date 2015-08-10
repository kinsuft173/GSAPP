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
    if ([[UserDataManager shareManager].userType isEqualToString:UserType]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:[UserDataManager shareManager].user.doctor.id],@"OrderSearch[doctor_id]",@"consultation,orderDoctor",@"expand",nil];
        
        [[NetworkManager shareMgr] server_fetchOrderWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            self.arrayExpertUnFinished = [[NSMutableArray alloc] init];
            self.arrayExpertFinished = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                for (int i= 0 ; i < resultArray.count; i++) {
                    
                    NSDictionary* dicItem = [resultArray objectAtIndex:i];
                    
                    if ([[dicItem objectForKey:@"status"] integerValue] == 3) {
                        
                        [self.arrayExpertUnFinished addObject:dicItem];
                        
                    }else if ([[dicItem objectForKey:@"status"] integerValue] == 9){
                        
                        [self.arrayExpertFinished addObject:dicItem];
                    }
                    
                }
                
            }
            
            
            
            
            [hud hide:YES];
            [self.myTable reloadData];
            
            
            
            
        }];
        
        
        
        
        
        
    }else if([[UserDataManager shareManager].userType isEqualToString:ExpertType]){
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"order_doctor_id", @"consultation,orderDoctor",@"expand",nil];
        
        [[NetworkManager shareMgr] server_fetchOrderWithDic:dic completeHandle:^(NSDictionary *response) {
            
            
            self.arrayDotorUnFinished = [[NSMutableArray alloc] init];
            self.arrayDotorFinished = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                for (int i= 0 ; i < resultArray.count; i++) {
                    
                    NSDictionary* dicItem = [resultArray objectAtIndex:i];
                    
                    if ([[dicItem objectForKey:@"status"] integerValue] == 3) {
                        
                        [self.arrayDotorUnFinished addObject:dicItem];
                        
                    }else if ([[dicItem objectForKey:@"status"] integerValue] == 9){
                    
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
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.isFinished == NO) {
        
        
        if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
            
            if (section == 0) {
                
                return self.arrayDotorUnFinished.count;
            }
            
            
        }else{
            
            if (section == 0) {
                
                return self.arrayExpertUnFinished.count;
            }
            
        }
        
    }else{
        
        
        
        if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
            
            if (section == 0) {
                
                return self.arrayDotorFinished.count;
            }
            
            
        }else{
            
            if (section == 0) {
                
                return self.arrayExpertFinished.count;
            }
            
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

    
    if (indexPath.section==0) {
        MyCaseCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        
        [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_consultation"]];
        cell.lbl_treat.text=@"会诊";
        
        GSOrder* order;
        
        
        if (self.isFinished == NO) {
            
            if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
                
                order = [GSOrder objectWithKeyValues:[self.arrayDotorUnFinished objectAtIndex:indexPath.row]];
                
            }else if ([[UserDataManager shareManager].userId isEqualToString:@"2"]){
                
                order = [GSOrder objectWithKeyValues:[self.arrayExpertUnFinished objectAtIndex:indexPath.row]];
                
            }
        }else{
            
            
            
            if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
                
                order = [GSOrder objectWithKeyValues:[self.arrayDotorFinished objectAtIndex:indexPath.row]];
                
            }else if ([[UserDataManager shareManager].userId isEqualToString:@"2"]){
                
                order = [GSOrder objectWithKeyValues:[self.arrayExpertFinished objectAtIndex:indexPath.row]];
                
            }
        }
        
        cell.lbl_bingshi.text = [NSString stringWithFormat:@"%d",order.consultation.anamnesis_id];
        cell.lbl_jibingmiaoshu.text = order.consultation.patient_illness;
        cell.lbl_zhuangzhuang.text = [NSString stringWithFormat:@"%d",order.consultation.symptom_id];
        
        
        
        return cell;
    }
    else if (indexPath.section==1)
    {
        MyCaseCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        
        [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_surgery"]];
        cell.lbl_treat.text=@"会诊手术";
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
    
    GSOrder* order;
    
    if (self.isFinished == NO) {
        
        if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
            
            order = [GSOrder objectWithKeyValues:[self.arrayDotorUnFinished objectAtIndex:indexPath.row]];
            caseDetail.type = @"1";
            
            
        }else if ([[UserDataManager shareManager].userId isEqualToString:@"2"]){
            
            order = [GSOrder objectWithKeyValues:[self.arrayExpertUnFinished objectAtIndex:indexPath.row]];
                      caseDetail.type = @"3";
            
            
            
        }
    }else{
        
        
        
        if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
            
            order = [GSOrder objectWithKeyValues:[self.arrayDotorFinished objectAtIndex:indexPath.row]];
            
                      caseDetail.type = @"2";
            
        }else if ([[UserDataManager shareManager].userId isEqualToString:@"2"]){
            
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
    if (section==1) {
        return 11.0;
    }
    return 0;
}

- (UIView * )tableView:(UITableView * )tableView
        viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

@end
