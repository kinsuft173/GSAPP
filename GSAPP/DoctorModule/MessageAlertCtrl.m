//
//  MessageAlertCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/23.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "MessageAlertCtrl.h"
#import "MessageAlertCell.h"
#import "HKCommen.h"
#import "UserDataManager.h"
#import "NetWorkManager.h"
#import "GSOrder.h"
#import "GSConsulation.h"
#import "OrderCommitCtrl.h"
#import "CaseDetailCtrl.h"
#import "ConsultationInfoCtrl.h"

@interface MessageAlertCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  NSMutableArray* arrayOrder;
@property (nonatomic, strong)  NSMutableArray* arrayCancelOrder;
@property (nonatomic, strong) NSMutableArray* arrayConsulation;
@property (nonatomic, strong) NSMutableArray* arrayConsulationNoTimely;
@end

@implementation MessageAlertCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"消息提醒" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
//    [HKCommen sete]
    
    [self getModel];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"notify" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"updateConsulation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"orderUpdate" object:nil];
}
- (void)getModel
{
    if ([[UserDataManager shareManager].userId isEqualToString:@"2"]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        //私人的咨询
        NSDictionary* dicPrivate = [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"ConsultationSearch[expert_id]",@"1",@"ConsultationSearch[status]",@"doctor",@"expand",@"1",@"ConsultationSearch[timely]",nil];
        
        
        [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPrivate completeHandle:^(NSDictionary *response) {
            
            self.arrayConsulation = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                [self.arrayConsulation addObjectsFromArray:resultArray];
                
            }
            
            NSDictionary* dicPrivate1 = [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"ConsultationSearch[expert_id]",@"1",@"ConsultationSearch[status]",@"doctor",@"expand",@"0",@"ConsultationSearch[timely]",nil];
            
            
            [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPrivate1 completeHandle:^(NSDictionary *response1) {
                
                self.arrayConsulationNoTimely = [[NSMutableArray alloc] init];
                
                NSArray* resultArray1 = [[response1 objectForKey:@"data"] objectForKey:@"items"];
                
                if (resultArray1.count != 0) {
                    
                    [self.arrayConsulationNoTimely addObjectsFromArray:resultArray1];
                    
                }
                

                
                [hud hide:YES];
                [self.myTable reloadData];
                
                
                
                
            }];
            

  
            
        }];
   
        
        
        
        
        
    }else if([[UserDataManager shareManager].userId isEqualToString:@"1"]){
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@1,@"OrderSearch[status]", @"consultation,orderDoctor",@"expand",nil];
        
        [[NetworkManager shareMgr] server_fetchOrderWithDic:dic completeHandle:^(NSDictionary *response) {
            
            self.arrayOrder = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                [self.arrayOrder addObjectsFromArray:resultArray];
                
            }
            NSDictionary* dicCancel = [NSDictionary dictionaryWithObjectsAndKeys:@4,@"OrderSearch[status]", @"consultation,orderDoctor",@"expand",nil];
            
            [[NetworkManager shareMgr] server_fetchOrderWithDic:dicCancel completeHandle:^(NSDictionary *response) {
                
                self.arrayCancelOrder = [[NSMutableArray alloc] init];
                
                NSArray* resultArray1 = [[response objectForKey:@"data"] objectForKey:@"items"];
                
                if (resultArray1.count != 0) {
                    
                    [self.arrayCancelOrder addObjectsFromArray:resultArray1];
                    
                }
                
                //        [self.myTable reloadData];
                
                //公共的咨询
                
                [hud hide:YES];
                [self.myTable reloadData];
                
                
                
                
            }];
            
            
        }];
        
        
    
    
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        hud.mode = MBProgressHUDModeIndeterminate;
//        hud.labelText = @"正在加载...";
//        
//        //私人的咨询
//        NSDictionary* dicPrivate = [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"ConsultationSearch[expert_id]", nil];
//        
//        
//        [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPrivate completeHandle:^(NSDictionary *response) {
//            
//            self.arrayPrivateConsulation = [[NSMutableArray alloc] init];
//            
//            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
//            
//            if (resultArray.count != 0) {
//                
//                [self.arrayPrivateConsulation addObjectsFromArray:resultArray];
//                
//            }
//            
//            //        [self.myTable reloadData];
//            
//            //公共的咨询
//            
//            NSDictionary* dicPublic = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"ConsultationSearch[anamnesis_id]", nil];
//            
//            [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPublic completeHandle:^(NSDictionary *response) {
//                
//                self.arrayPublicConsulation = [[NSMutableArray alloc] init];
//                
//                NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
//                
//                for (int i = 0; i < resultArray.count; i++) {
//                    
//                    BOOL isHas = NO;
//                    
//                    for (int j = 0; j < self.arrayPrivateConsulation.count; j++) {
//                        
//                        NSDictionary* dicPrivateItem = [self.arrayPrivateConsulation objectAtIndex:j];
//                        
//                        if ([[dicPrivateItem objectForKey:@"id"] isEqualToValue:[[resultArray objectAtIndex:i] objectForKey:@"id"]]) {
//                            
//                            isHas = YES;
//                            
//                            break;
//                            
//                        }
//                        
//                    }
//                    
//                    if(isHas == NO){
//                        
//                        [self.arrayPublicConsulation addObject:[resultArray objectAtIndex:i]];
//                        
//                    }
//                    
//                }
//                
//                [hud hide:YES];
//                [self.myTable reloadData];
//                
//            }];
//            
//            
//        }];

    
    
    }



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.arrayConsulation.count;
        
    }else if (section == 1){
    
        return self.arrayOrder.count;
    }else if (section == 2){
    
        return self.arrayCancelOrder.count;
    
    }else if (section == 3){
        
        return self.arrayConsulationNoTimely.count;
        
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 98;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId = @"MessageAlertCell";
    
    MessageAlertCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (!cell) {
        
        NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
    }
//    if ([cell.lbl_hintOfMessage.text isEqualToString:@"预约提示"]) {
//        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
//        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
//    }
//    else
//    {
//        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:73.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]];
//        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more"]];
//    }
    
    if (indexPath.section == 0) {
        
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulation objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"及时案例提示";
        cell.lblTime.text = consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"您有一个来自%@即时案例,请处理",consultation.patient_hospital] ;
        
    }else     if (indexPath.section == 1) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayOrder objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"付款提示";
       

        
                [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:73.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]];
                [cell.img_goNext setImage:[UIImage imageNamed:@"list_more"]];
        
        cell.lblTime.text = order.consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"%@医生接受了您的%@案例,请付款",order.orderDoctor.name,order.consultation.patient_illness] ;
        
        
    }else if (indexPath.section == 2) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayCancelOrder objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"退款提示";
        
        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
        
        cell.lblTime.text = order.consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"%@医生取消了您的%@案例,手术费退返到您的账户,请查收",order.orderDoctor.name,order.consultation.patient_illness];
    }else if (indexPath.section == 3) {
        
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulationNoTimely objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"预约提示";
        
        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
        
        cell.lblTime.text = consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"您有一个来自%@预约,请处理",consultation.patient_hospital];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        OrderCommitCtrl *vc=[[OrderCommitCtrl alloc] initWithNibName:@"OrderCommitCtrl" bundle:nil];
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayOrder objectAtIndex:indexPath.row]];
        vc.orderGS = order;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else    if (indexPath.section == 2) {
        
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayCancelOrder objectAtIndex:indexPath.row]];
        
        CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
        
        caseDetail.orderGS = order;
        
        caseDetail.hidesBottomBarWhenPushed = YES;

        [self.navigationController pushViewController:caseDetail animated:YES];
        
    }else if (indexPath.section == 0){
        
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulation objectAtIndex:indexPath.row]];
    
        ConsultationInfoCtrl* vc = [[ConsultationInfoCtrl alloc] initWithNibName:@"ConsultationInfoCtrl" bundle:nil];
        
        vc.consulation = consultation;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    
    }else if (indexPath.section == 3){
        
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulationNoTimely objectAtIndex:indexPath.row]];
        
        ConsultationInfoCtrl* vc = [[ConsultationInfoCtrl alloc] initWithNibName:@"ConsultationInfoCtrl" bundle:nil];
        
        vc.consulation = consultation;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }


}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{

    return 12.0;
}

- (UIView * )tableView:(UITableView * )tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

@end
