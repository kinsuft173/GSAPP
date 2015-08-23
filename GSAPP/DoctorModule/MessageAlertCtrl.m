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

@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToFour;
@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToSix;
@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToOne;

//@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualOne;
@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualTwo;
@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualThree;
@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualSix;

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    if (self.arrayCancelOrder.count == 0 && self.arrayConsulation.count ==0 && self.arrayConsulationNoTimely.count == 0 && self.arrayOrder.count == 0) {
    
        [self getModel];
        
//    }


}
- (void)getModel
{
   // if ([[UserDataManager shareManager].userType isEqualToString:ExpertType]) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        //私人的咨询
        NSDictionary* dicPrivate = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"ConsultationSearch[expert_id]",@"1",@"ConsultationSearch[status]",@"doctor",@"expand",nil];
        
        
        [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPrivate completeHandle:^(NSDictionary *response) {
            
            self.arrayConsulation = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                [self.arrayConsulation addObjectsFromArray:resultArray];
                
            }
            
//            NSDictionary* dicPrivate1 = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"ConsultationSearch[expert_id]",@"1",@"ConsultationSearch[status]",@"doctor",@"expand",@"0",@"ConsultationSearch[timely]",nil];
            
           NSDictionary* dicPrivate1 = [NSDictionary dictionaryWithObjectsAndKeys:@"consultation,doctor",@"where%5bstatus%5d%5b%5d%3d2%26where%5bstatus%5d%5b%5d%3d3%26where%5bstatus%5d%5b%5d%3d6%26expand",[UserDataManager shareManager].userId,@"where[order_doctor_id][]",nil];
            [[NetworkManager shareMgr] server_fetchOrderWithDic:dicPrivate1 completeHandle:^(NSDictionary *response1) {
                
                
                NSLog(@"获得专家的取消订单以及取消数据 = %@",response1);
                
                
                NSArray* resultArray1 = [[response1 objectForKey:@"data"] objectForKey:@"items"];
                

                
//                NSDictionary* dicPrivate2 = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"where[order_doctor_id][]",@"consultation,doctor",@"&where[status][]=1&expand",@"",@"",nil];
//                [[NetworkManager shareMgr] server_fetchOrderWithDic:dicPrivate1 completeHandle:^(NSDictionary *response1) {
//                    
//                    
//                    NSLog(@"获得医生的取消订单以及取消数据 = %@",response1);
//                    
//                    self.arrayConsulationNoTimely = [[NSMutableArray alloc] init];
//                    
//                    NSArray* resultArray1 = [[response1 objectForKey:@"data"] objectForKey:@"items"];
//                    
//                    if (resultArray1.count != 0) {
//                        
//                        [self.arrayConsulationNoTimely addObjectsFromArray:resultArray1];
//                        
//                    }
//                    
//                    
                    [hud hide:YES];
                
                self.arrayExpertOrderStatusIsEqualTwo = [[NSMutableArray alloc] init];;

                self.arrayExpertOrderStatusIsEqualThree = [[NSMutableArray alloc] init];;
                self.arrayExpertOrderStatusIsEqualSix = [[NSMutableArray alloc] init];;
                
                if (resultArray1.count != 0) {
                    
                    for (int i = 0; i < resultArray1.count; i ++) {
                        
                        GSOrder* order = [GSOrder objectWithKeyValues:[resultArray1 objectAtIndex:i]];
                        
                        if (order.status == 2) {
                            
                            [self.arrayExpertOrderStatusIsEqualTwo addObject:[resultArray1 objectAtIndex:i]];
                            
                        }else if (order.status == 3){
                        
                            [self.arrayExpertOrderStatusIsEqualThree addObject:[resultArray1 objectAtIndex:i]];
                        
                        }else if (order.status == 6){
                        
                            [self.arrayExpertOrderStatusIsEqualSix addObject:[resultArray1 objectAtIndex:i]];
                        
                        }
                        
                        
                    }
                    
                }
                
                
                
                    [self.myTable reloadData];
                
                }];
            
            
                
//                [hud hide:YES];
//                [self.myTable reloadData];
            
//            }];
            

  
            
        }];
   
        
        
        
        
        
 //   }else if([[UserDataManager shareManager].userType isEqualToString:UserType]){
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        //私人的咨询
        NSDictionary* dicPrivate = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"ConsultationSearch[doctor_id]",@"4",@"ConsultationSearch[status]",@"doctor",@"expand",@"0",@"where[timely][]",nil];
        
        [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPrivate completeHandle:^(NSDictionary *response) {
            
            self.arrayConsulationNoTimely = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                [self.arrayConsulationNoTimely addObjectsFromArray:resultArray];
                
            
                
            }
            
            NSLog(@"arrayConsulationNoTimely = %@",self.arrayConsulationNoTimely);
            
            //@"0",@"where[timely]"
            
           NSDictionary* dicPrivate1 = [NSDictionary dictionaryWithObjectsAndKeys:@"consultation",@"join[]",@"0",@"where[consultation.timely]",@"1",@"where[order.status]",[UserDataManager shareManager].userId,@"where[order.doctor_id][]",@"consultation,orderDoctor",@"expand",nil];
            
            [[NetworkManager shareMgr] server_fetchOrderWithDic:dicPrivate1 completeHandle:^(NSDictionary *response) {
                
                self.arrayDoctorOrderStatusIsEqualToOne = [[NSMutableArray alloc] init];
                
                NSArray* resultArray1 = [[response objectForKey:@"data"] objectForKey:@"items"];
                
                if (resultArray1.count != 0) {
                    
                    [self.arrayDoctorOrderStatusIsEqualToOne addObjectsFromArray:resultArray1];
                    
                }
                
                //        [self.myTable reloadData];
                
                //公共的咨询
                
//                [hud hide:YES];
//                [self.myTable reloadData];
                
                
                                NSDictionary* dicPrivate2 = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"where[doctor_id][]",@"consultation,orderDoctor",@"expand",@"4",@"where[status]",nil];
                                [[NetworkManager shareMgr] server_fetchOrderWithDic:dicPrivate2 completeHandle:^(NSDictionary *response1) {
                
                
                                    NSLog(@"获得医生的取消订单以及取消数据 = %@",response1);
                
//                                    self.arrayDoctorOrderStatusIsEqualToFour = [[NSMutableArray alloc] init];
//                                    
//                                    self.arrayDoctorOrderStatusIsEqualToSix = [[NSMutableArray alloc] init];
                
                                    NSArray* resultArray1 = [[response1 objectForKey:@"data"] objectForKey:@"items"];
                
                                    if (resultArray1.count != 0) {
                                        
//                                        for (int i = 0; i < resultArray1.count; i ++) {
//                                            
//                                            GSOrder* order = [GSOrder objectWithKeyValues:[resultArray1 objectAtIndex:i]];
//                                            
//                                            if (order.status == 4) {
//                                                
//                                                [self.arrayDoctorOrderStatusIsEqualToFour addObject:[resultArray1 objectAtIndex:i]];
//                                                
//                                            }else if (order.status == 6){
//                                                
//                                                [self.arrayDoctorOrderStatusIsEqualToSix addObject:[resultArray1 objectAtIndex:i]];
//                                                
//                                            }
//                                            
//                                            
//                                        }
                                                                self.arrayDoctorOrderStatusIsEqualToFour = resultArray1;
                                        
                                    }
                                                    [hud hide:YES];
                                                    [self.myTable reloadData];
                                    
                                    }];
                
                
                NSDictionary* dicPrivate3 = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"where[doctor_id][]",@"consultation,orderDoctor",@"expand",@"6",@"where[status]",nil];
                [[NetworkManager shareMgr] server_fetchOrderWithDic:dicPrivate3 completeHandle:^(NSDictionary *response1) {
                    
                    
                    NSLog(@"获得医生的取消订单以及取消数据 = %@",response1);
                    
//                    self.arrayDoctorOrderStatusIsEqualToFour = [[NSMutableArray alloc] init];
//                    
//                    self.arrayDoctorOrderStatusIsEqualToSix = [[NSMutableArray alloc] init];
                    
                    NSArray* resultArray2 = [[response1 objectForKey:@"data"] objectForKey:@"items"];
                    
                    if (resultArray1.count != 0) {
                        
                        self.arrayDoctorOrderStatusIsEqualToSix = resultArray2;
                        
                    }
                    [hud hide:YES];
                    [self.myTable reloadData];
                    
                }];
                
                
                
            }];
            
            
        }];
        
    }
    

    
    
  //  }



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 8;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.arrayConsulation.count;
        
    }else if (section == 2){
        
        return self.arrayExpertOrderStatusIsEqualSix.count;
    }else if (section == 3){
        
        return self.arrayExpertOrderStatusIsEqualThree.count;
        
    }else if (section == 1){
        
        return self.arrayExpertOrderStatusIsEqualTwo.count;
        
    }else if (section == 7){
    
        return self.arrayDoctorOrderStatusIsEqualToSix.count;
    }else if (section == 6){
    
        return self.arrayDoctorOrderStatusIsEqualToFour.count;
    
    }else if (section == 4){
        
        return self.arrayConsulationNoTimely.count;
        
    }else if (section == 5){
        
        return self.arrayDoctorOrderStatusIsEqualToOne.count;
        
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
    
    if (indexPath.section == 0) {
        
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulation objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"案例提醒";
        cell.lblTime.text = consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"您有一个来自%@即时案例,请处理",consultation.patient_hospital] ;
        
    }else     if (indexPath.section == 1 ) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrderStatusIsEqualTwo objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"选择提醒";

        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:73.0/255.0 green:72.0/255.0 blue:72.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more"]];
        
        cell.lblTime.text = order.consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"您已经被%@选择了%@",order.orderDoctor.name,order.consultation.patient_illness] ;
        
        
    }else if (indexPath.section == 2) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrderStatusIsEqualSix objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"订单被取消了";
        
        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
        
        cell.lblTime.text = order.consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"%@医生取消了案例%@",order.orderDoctor.name,order.consultation.patient_illness];
    }else if (indexPath.section == 3) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrderStatusIsEqualThree objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = [NSString stringWithFormat:@"%@医生已经为案例%@付款",order.orderDoctor.name,order.consultation.patient_illness];
        
        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
        
        cell.lblTime.text = order.consultation.created_at;
//        cell.txtIntro.text = [NSString stringWithFormat:@"您有一个来自%@预约,请处理",consultation.patient_hospital];
        
    }else if(indexPath.section == 4) {
        
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulationNoTimely objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"您的一个咨询被拒绝了";
        cell.lblTime.text = consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"您的%@咨询被拒绝了",consultation.patient_illness] ;
        
    }else if (indexPath.section == 5) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrderStatusIsEqualToOne objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"付款提醒";
        
        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
        
        cell.lblTime.text = order.consultation.created_at;
             cell.txtIntro.text = [NSString stringWithFormat:@"%@医生取消了您的%@案例,手术费退返到您的账户,请查收",order.orderDoctor.name,order.consultation.patient_illness];
    }else if (indexPath.section == 6) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrderStatusIsEqualToFour objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"医生取消了手术";
        
        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
        
        cell.lblTime.text = order.consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"%@医生取消了您的%@案例,手术费退返到您的账户,请查收",order.orderDoctor.name,order.consultation.patient_illness];
        
    }else if (indexPath.section == 7) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrderStatusIsEqualToSix objectAtIndex:indexPath.row]];
        
        cell.lbl_hintOfMessage.text = @"已经取消了这个订单";
        
        [cell.lbl_hintOfMessage setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        [cell.img_goNext setImage:[UIImage imageNamed:@"list_more_pre"]];
        
        cell.lblTime.text = order.consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"您取消了%@案例",order.orderDoctor.name];
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
