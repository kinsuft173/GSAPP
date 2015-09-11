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
#import "GreatDoctorCtrl.h"
#import "ConsulationManager.h"

@interface MessageAlertCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong)  NSMutableArray* arrayOrder;
@property (nonatomic, strong)  NSMutableArray* arrayCancelOrder;
@property (nonatomic, strong) NSMutableArray* arrayConsulation;
@property (nonatomic, strong) NSMutableArray* arrayConsulationNoTimely;

@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToFour;
@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToSix;
@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToOne;
@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToTwo;

//@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualOne;
@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualTwo;
@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualThree;
@property (nonatomic, strong) NSMutableArray* arrayExpertOrderStatusIsEqualSix;


@property (nonatomic, strong) NSMutableArray* arrayDoctorOrdersNew;
@property (nonatomic, strong) NSMutableArray* arrayExpertOrdersNew;
//@property (nonatomic, strong) NSMutableArray* arrayDoctorOrderStatusIsEqualToFour;

@end

@implementation MessageAlertCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [HKCommen addHeadTitle:@"消息提醒" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
//    [HKCommen sete]
    
    self.myTable.backgroundColor = [HKCommen getColor:@"efefef"];
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
    
    if ([[UserDataManager shareManager].userType isEqualToString:UserType]) {
        
        
        
    }else
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        
        //私人的咨询
        NSDictionary* dicPrivate = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"and[expert_id]",@"1",@"and[status]",@"doctor.doctorFiles,consultationFiles",@"expand",nil];
        
        
        [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPrivate completeHandle:^(NSDictionary *response) {
            
            self.arrayConsulation = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (resultArray.count != 0) {
                
                NSLog(@"已经处理过的set = %@",[ConsulationManager shareMgr].setModel);
                
                for (int i = 0 ; i < resultArray.count; i ++) {
                    
                    GSConsulation* consulation = [GSConsulation objectWithKeyValues:[resultArray objectAtIndex:i]];
                    
                    NSString* strId = [NSString stringWithFormat:@"%d",consulation.id];
                    
                    
                    
                    BOOL isNewConsult = YES;
                    
                    for (NSString* consultId in [ConsulationManager shareMgr].setModel) {
                        
                        if ([consultId isEqualToString:strId]) {
                            
                            
                            isNewConsult = NO;
                        }
                        
                    }
                    
                    
                    if (isNewConsult == YES) {
                        [self.arrayConsulation addObject:[resultArray objectAtIndex:i]];
                    }
                    
                    
                    
                    
                }
                
            }

            
           NSDictionary *parameters = @{@"expand": @"consultation,doctor.doctorFiles,orderDoctor.doctorFiles",@"and[order_doctor_id]":[UserDataManager shareManager].userId, @"and[status]": @[@2,@3, @6]};
            
 
            [[NetworkManager shareMgr] server_fetchOrderWithDic:parameters completeHandle:^(NSDictionary *response1) {
                
                
                self.arrayExpertOrdersNew = [[NSMutableArray alloc] init];
                
                NSArray* resultArray1 = [[response1 objectForKey:@"data"] objectForKey:@"items"];
                
      
                if (resultArray1.count != 0) {
                    
                    self.arrayExpertOrdersNew = [[NSMutableArray alloc] initWithArray:resultArray1];
                    
                }
                
                    [hud hide:YES];
                
                
                    [self.myTable reloadData];
                
                }];
            
        
        
            
        }];
    
    }

        

        
    {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在加载...";
        

                

                
                                NSDictionary *parameters = @{@"expand": @"consultation.consultationFiles,orderDoctor.doctorFiles,doctor",@"and[doctor_id]":[UserDataManager shareManager].userId, @"and[status]": @[@1,@2, @4, @6]};

                                [[NetworkManager shareMgr] server_fetchOrderWithDic:parameters completeHandle:^(NSDictionary *response1) {
                
                
                                    NSLog(@"parameters v= %@",response1);

                
                                    NSArray* resultArray1 = [[response1 objectForKey:@"data"] objectForKey:@"items"];
                                    
                                    if (resultArray1.count != 0) {
                                        
                                        
                                        self.arrayDoctorOrdersNew = [NSMutableArray arrayWithArray:resultArray1];
                                    }
                                    

                                    
                                    
                                    
                                    
                                                    [hud hide:YES];
                                                    [self.myTable reloadData];
                                    
                                    }];
            
                

            
   
        
    }




}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == 0) {
//        
//        return self.arrayConsulation.count;
//        
//    }else if (section == 2){
//        
//        return self.arrayExpertOrderStatusIsEqualSix.count;
//    }else if (section == 3){
//        
//        return self.arrayExpertOrderStatusIsEqualThree.count;
//        
//    }else if (section == 1){
//        
//        return self.arrayExpertOrderStatusIsEqualTwo.count;
//        
//    }else if (section == 8){
//    
//        return self.arrayDoctorOrderStatusIsEqualToSix.count;
//    }else if (section == 7){
//    
//        return self.arrayDoctorOrderStatusIsEqualToFour.count;
//    
//    }else if (section == 4){
//        
//        return self.arrayConsulationNoTimely.count;
//        
//    }else if (section == 5){
//        
//        return self.arrayDoctorOrderStatusIsEqualToOne.count;
//        
//    }else if(section == 6){
//    
//        return self.arrayDoctorOrderStatusIsEqualToTwo.count;
//    
//    }
    
    if (section == 0 ) {
        
        return self.arrayDoctorOrdersNew.count;
        
    }else if (section == 1){
    
        return self.arrayExpertOrdersNew.count;
        
    }else if(section == 2){
    
        return self.arrayConsulation.count;
    
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 118;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId = @"MessageAlertCell";
    
    MessageAlertCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (!cell) {
        
        NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
    }
    
    
    
    //new
    
    if (indexPath.section == 0) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrdersNew objectAtIndex:indexPath.row]];
        
        cell.lblTime.text = order.created_at;

        for (int i = 0; i < order.orderDoctor.doctorFiles.count; i ++) {
            
            Doctorfiles* file = [order.orderDoctor.doctorFiles objectAtIndex:i];
            
            if (file.type == 1) {
                
                
                [cell.imgHeadPhoto sd_setImageWithURL:file.path
                                 placeholderImage:[UIImage imageNamed:@"loading-ios"] options:SDWebImageContinueInBackground];
            }
            
        }
        
        
        switch (order.status) {
            case 2:
                
                cell.lbl_hintOfMessage.text = @"支付提醒";
                cell.txtIntro.text = [NSString stringWithFormat:@"您预约的%@专家的订单尚未付款,请及时支付。",order.orderDoctor.name];
                break;
                
            case 1:
                
                cell.lbl_hintOfMessage.text = @"咨询预约成功";
                cell.txtIntro.text = [NSString stringWithFormat:@"您成功预约%@,请确认。",order.orderDoctor.name];
                break;
                
            case 4:
                
                cell.lbl_hintOfMessage.text = @"专家取消手术";
                cell.txtIntro.text = [NSString stringWithFormat:@"%@专家取消了手术，手术费用将会在三到五个工作日退还到您的账户。",order.orderDoctor.name];
                break;
                
            case 6:
                
                cell.lbl_hintOfMessage.text = @"退款提醒";
                cell.txtIntro.text = [NSString stringWithFormat:@"您已经成功取消对%@专家的订单，费用将会在三到五个工作日退还到您的账户",order.orderDoctor.name];
                break;
                
            default:
                break;
        }
        
        
    }else if (indexPath.section == 1){
    
    
    
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrdersNew objectAtIndex:indexPath.row]];
        
        cell.lblTime.text = order.created_at;
        
        for (int i = 0; i < order.doctor.doctorFiles.count; i ++) {
            
            Doctorfiles* file = [order.doctor.doctorFiles objectAtIndex:i];
            
            if (file.type == 1) {
                
                
                [cell.imgHeadPhoto sd_setImageWithURL:file.path
                                     placeholderImage:[UIImage imageNamed:@"loading-ios"] options:SDWebImageContinueInBackground];
            }
            
        }
        
        
        switch (order.status) {
            case 3:
                
                cell.lbl_hintOfMessage.text = @"医生付款";
                cell.txtIntro.text = [NSString stringWithFormat:@"%@医生已对关于%@患者的会诊订单付款。",order.doctor.name,order.consultation.patient_name];
                break;
                
                
            case 2:
                
                cell.lbl_hintOfMessage.text = @"医生选择了咨询";
                cell.txtIntro.text = [NSString stringWithFormat:@"在%@患者的订单中,%@医生选择了您，等待医生付款。",order.consultation.patient_name,order.doctor.name];
                break;
                
            case 6:
                
                cell.lbl_hintOfMessage.text = @"医生取消了订单";
                cell.txtIntro.text = [NSString stringWithFormat:@"%@医生已取消了关于%@患者的咨询。",order.doctor.name,order.consultation.patient_name];
                break;
                
            default:
                break;
        }
    
    
    }else if (indexPath.section == 2){
    
    
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulation objectAtIndex:indexPath.row]];
        
        for (int i = 0; i < consultation.doctor.doctorFiles.count; i ++) {
            
            Doctorfiles* file = [consultation.doctor.doctorFiles objectAtIndex:i];
            
            if (file.type == 1) {
                
                
                [cell.imgHeadPhoto sd_setImageWithURL:file.path
                                     placeholderImage:[UIImage imageNamed:@"loading-ios"] options:SDWebImageContinueInBackground];
            }
            
        }
        
        
        cell.lbl_hintOfMessage.text = @"咨询预约";
        cell.lblTime.text = consultation.created_at;
        cell.txtIntro.text = [NSString stringWithFormat:@"%@医生预约了您，请确认。",consultation.doctor.name] ;
    
    
    
    
    }
    
    
    
    
    cell.imgHeadPhoto.layer.cornerRadius = 4.0;
    cell.imgHeadPhoto.layer.masksToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrdersNew objectAtIndex:indexPath.row]];
        
        switch (order.status) {
            case 2:
                
            {
                OrderCommitCtrl *vc=[[OrderCommitCtrl alloc] initWithNibName:@"OrderCommitCtrl" bundle:nil];
                
                vc.orderGS = order;
                vc.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:vc animated:YES];
            }
                
                break;
                
            case 1:
                
            {
                GSConsulation*  consulation = order.consultation;
                //consulation.doctor = order.doctor;
                
                GreatDoctorCtrl *vc=[[GreatDoctorCtrl alloc]initWithNibName:@"GreatDoctorCtrl" bundle:nil];
                
                vc.hidesBottomBarWhenPushed = YES;
                
                vc.consulation = consulation;
                
                [self.navigationController pushViewController:vc animated:YES];
            
            
            
            }
                
                break;
                
            case 4:
                
            {
            
                
                CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
                
                caseDetail.orderGS = order;
                
                caseDetail.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:caseDetail animated:YES];
            
            }
                
              
                break;
                
            case 6:
                
            {
                
                
                CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
                
                caseDetail.orderGS = order;
                
                caseDetail.hidesBottomBarWhenPushed = YES;
                
                caseDetail.type = @"1";
                
                [self.navigationController pushViewController:caseDetail animated:YES];
                
            }
                
               
                break;
                
            default:
                break;
        }
    }
    
    
    if (indexPath.section == 1) {
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrdersNew objectAtIndex:indexPath.row]];
        
        switch (order.status) {
            case 2:
                
            {
                
                CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
                
                caseDetail.orderGS = order;
                
                caseDetail.hidesBottomBarWhenPushed = YES;
                
                caseDetail.type = @"1";
                
                [self.navigationController pushViewController:caseDetail animated:YES];
            }
                
                break;
                
            case 1:
                
            {
                GSConsulation*  consulation = order.consultation;
                
                //consulation.doctor = order.doctor;
                
                GreatDoctorCtrl *vc=[[GreatDoctorCtrl alloc]initWithNibName:@"GreatDoctorCtrl" bundle:nil];
                
                vc.hidesBottomBarWhenPushed = YES;
                
                vc.consulation = consulation;
                
                [self.navigationController pushViewController:vc animated:YES];
                
                
                
            }
                
                break;
                
            case 3:
                
            {
                
                
                CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
                
                caseDetail.orderGS = order;
                
                caseDetail.hidesBottomBarWhenPushed = YES;
                
                caseDetail.type = @"3";
                
                [self.navigationController pushViewController:caseDetail animated:YES];
                
            }
                
                
                break;
                
            case 6:
                
            {
                
                
                CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
                
                caseDetail.orderGS = order;
                
                caseDetail.hidesBottomBarWhenPushed = YES;
                
                [self.navigationController pushViewController:caseDetail animated:YES];
                
            }
                
                
                break;
                
            default:
                break;
        }
    }
    
    
    if (indexPath.section == 2) {
        
        
        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulation objectAtIndex:indexPath.row]];
        
        ConsultationInfoCtrl* vc = [[ConsultationInfoCtrl alloc] initWithNibName:@"ConsultationInfoCtrl" bundle:nil];
        
        vc.consulation =  consultation;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    return;
    
    
    if (indexPath.section == 1) {
        
//        OrderCommitCtrl *vc=[[OrderCommitCtrl alloc] initWithNibName:@"OrderCommitCtrl" bundle:nil];
//        
//        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrderStatusIsEqualTwo objectAtIndex:indexPath.row]];
//        vc.orderGS = order;
//        vc.hidesBottomBarWhenPushed = YES;
//        
//        [self.navigationController pushViewController:vc animated:YES];
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrderStatusIsEqualTwo objectAtIndex:indexPath.row]];

        
        CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
        
        caseDetail.orderGS = order;
        
        caseDetail.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:caseDetail animated:YES];
        
    }else    if (indexPath.section == 2) {
        
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrderStatusIsEqualSix objectAtIndex:indexPath.row]];
        
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
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayExpertOrderStatusIsEqualThree objectAtIndex:indexPath.row]];
        
        CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
        
        caseDetail.orderGS = order;
        
        caseDetail.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:caseDetail animated:YES];
        
    }else if (indexPath.section == 4){
        
//        GSConsulation* consultation = [GSConsulation objectWithKeyValues:[self.arrayConsulationNoTimely objectAtIndex:indexPath.row]];
//        
//        ConsultationInfoCtrl* vc = [[ConsultationInfoCtrl alloc] initWithNibName:@"ConsultationInfoCtrl" bundle:nil];
//        
//        vc.consulation = consultation;
//        vc.hidesBottomBarWhenPushed = YES;
//        
//        [self.navigationController pushViewController:vc animated:YES];
        
        return;
        
    }else if (indexPath.section == 6){
        
        OrderCommitCtrl *vc=[[OrderCommitCtrl alloc] initWithNibName:@"OrderCommitCtrl" bundle:nil];
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrderStatusIsEqualToTwo objectAtIndex:indexPath.row]];
        vc.orderGS = order;
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section == 7){
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrderStatusIsEqualToFour objectAtIndex:indexPath.row]];
        
        CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
        
        caseDetail.orderGS = order;
        
        caseDetail.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:caseDetail animated:YES];
        
    }else if (indexPath.section == 8){
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrderStatusIsEqualToSix objectAtIndex:indexPath.row]];
        
        CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
        
        caseDetail.orderGS = order;
        
        caseDetail.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:caseDetail animated:YES];
        
    }else if (indexPath.section == 5){
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayDoctorOrderStatusIsEqualToOne objectAtIndex:indexPath.row]];
        
        CaseDetailCtrl *caseDetail=[[CaseDetailCtrl alloc]initWithNibName:@"CaseDetailCtrl" bundle:nil];
        
        caseDetail.orderGS = order;
        
        caseDetail.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:caseDetail animated:YES];
        
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
