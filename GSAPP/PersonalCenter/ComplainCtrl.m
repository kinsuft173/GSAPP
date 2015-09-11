//
//  ComplainCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/15.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ComplainCtrl.h"
#import "ComplainCell.h"
#import "HKCommen.h"
#import "UserDataManager.h"
#import "NetWorkManager.h"
#import "GSRepine.h"
#import "GSOrder.h"
#import "CaseDetailCtrl.h"

@interface ComplainCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray* arrayRepines;
@property BOOL isFinished;

@end

@implementation ComplainCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void)initUI
{
    [HKCommen addHeadTitle:@"我的投诉" whichNavigation:self.navigationItem];
    
    [HKCommen setExtraCellLineHidden:self.myTable];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    [self getComplaint];
}


- (void)getComplaint
{
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[UserDataManager shareManager].userId,@"and[doctor_id]",@"1",@"status",@"order,repinedDoctor",@"expand",nil];
    
    [[NetworkManager shareMgr] server_fetchRepineWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        NSLog(@"获取的我的投诉数据====>%@",dic);
        
        if ([[dic objectForKey:@"success"] integerValue] == 1) {
            
            self.arrayRepines = [[dic objectForKey:@"data"] objectForKey:@"items"];
            
            [self.myTable reloadData];
            
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

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.arrayRepines.count;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 104;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId = @"ComplainCell";
    
    
    GSRepine* repine = [GSRepine objectWithKeyValues:[self.arrayRepines objectAtIndex:indexPath.section]];
    
    
    
    if (repine.order.type == 0) {
        
        ComplainCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_consultation"]];
        cell.lbl_treat.text=@"会诊";
        
        cell.lblBingshi.text = repine.repinedDoctor.name;
        cell.lblZhengzhuan.text = repine.created_at;
        cell.lblDescription.text = repine.content;
        
        return cell;
    }
    else
    {
        ComplainCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_surgery"]];
        cell.lbl_treat.text=@"会诊手术";
        
        cell.lblBingshi.text = repine.repinedDoctor.name;
        cell.lblZhengzhuan.text = repine.created_at;
        cell.lblDescription.text = repine.content;
        
        return cell;
    }

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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
    

    
    GSRepine* repine = [GSRepine objectWithKeyValues:[self.arrayRepines objectAtIndex:indexPath.section]];
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:repine.order.id],@"and[id]",@"consultation,orderDoctor",@"expand",nil];
    
    [[NetworkManager shareMgr] server_fetchOrderWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        
        
        if (repine.order.status == 9) {
            
            self.isFinished = YES;
            
        }
        
        NSLog(@"获取的我的订单数据====>%@",dic);
        
        if ([[dic objectForKey:@"success"] integerValue] == 1) {
            
            
            GSOrder* order = [GSOrder objectWithKeyValues:[[[dic objectForKey:@"data"] objectForKey:@"items"] objectAtIndex:0]];
            
            if (self.isFinished == NO) {
                
                if ([[UserDataManager shareManager].userType isEqualToString:UserType]) {
                    
                    
                    caseDetail.type = @"1";
                    
                    
                }else if ([[UserDataManager shareManager].userType isEqualToString:ExpertType]){
                    
                    
                    caseDetail.type = @"3";
                    
                    
                    
                }
            }else{
                
                
                
                if ([[UserDataManager shareManager].userType isEqualToString:UserType]) {
                    
                    
                    
                    caseDetail.type = @"2";
                    
                }else if ([[UserDataManager shareManager].userType isEqualToString:ExpertType]){
                    
                    
                    caseDetail.type = @"4";
                    
                }
            }
            
            caseDetail.orderGS = order;
            
            
            
            [self.navigationController pushViewController:caseDetail animated:YES];
            
        }
        
    }];
    
    
    

}

@end
