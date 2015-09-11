//
//  GreatDoctorCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "GreatDoctorCtrl.h"
#import "GreatDoctorCell.h"
#import "AdvertisementShowCell.h"
#import "HKCommen.h"
#import "OrderCommitCtrl.h"
#import "NetworkManager.h"
#import "GSOrder.h"
#import "IndicatorWaitCell.h"
#import "SIAlertView.h"

@interface GreatDoctorCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray* arrayModel;

@end

@implementation GreatDoctorCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"nav_cancel"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(exit) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
    [HKCommen addHeadTitle:@"高手在接招" whichNavigation:self.navigationItem];
    [HKCommen setExtraCellLineHidden:self.myTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"notify" object:nil];
    
    [self getModel];    
    
}

- (void)getModel
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.consulation.id],@"and[consultation_id]", @"consultation,orderDoctor.doctorFiles",@"expand",nil];
    
    [[NetworkManager shareMgr] server_fetchOrderWithDic:dic completeHandle:^(NSDictionary *response) {
        
        self.arrayModel = [[NSMutableArray alloc] init];
        
        NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
        
        NSLog(@"用户选单server_fetchOrderWithDic===>%@",resultArray);
        
        if (resultArray.count != 0) {
            
            [self.arrayModel addObjectsFromArray:resultArray];
            
        }
        
        [self.myTable reloadData];
        
    }];
    
}

- (UIView * )tableView:(UITableView * )tableView
        viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}

-(void)exit
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"真的要离开吗?"];
    [alertView addButtonWithTitle:@"确认"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self.navigationController popToRootViewControllerAnimated:YES];
                          }];
    [alertView addButtonWithTitle:@"取消"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              
                          }];
    alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
    alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
    
    alertView.willShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willShowHandler3", alertView);
    };
    alertView.didShowHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didShowHandler3", alertView);
    };
    alertView.willDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, willDismissHandler3", alertView);
    };
    alertView.didDismissHandler = ^(SIAlertView *alertView) {
        NSLog(@"%@, didDismissHandler3", alertView);
    };
    
    [alertView show];
    
//    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.arrayModel.count == 0) {
        
        return 1;
    }
    
    return 3;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        if (self.arrayModel.count == 0) {
            return 1;
        }else{
        
            return 0;
        }
    }
    
    if (section==1) {
        return self.arrayModel.count;
    }
    
    if (section == 2) {
        
        if (self.arrayModel.count == 0) {
            return 0;
        }else{
            
            return 0;
            
        
        }
    }
    
        return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        return SCREEN_HEIGHT - 64;
        
    }else if (indexPath.section==1) {
        
        return 115;
    }else if (indexPath.section == 2){
    return 49;
        
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 13.0;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* BasicCellId = @"GreatDoctorCell";
    static NSString* ListCellId=@"AdvertisementShowCell";
    static NSString* placeCellId=@"IndicatorWaitCell";
    
    if (indexPath.section==0) {
        
        IndicatorWaitCell* cell = [tableView dequeueReusableCellWithIdentifier:BasicCellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:placeCellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }

        return cell;
        
    }else if (indexPath.section==1) {
        GreatDoctorCell* cell = [tableView dequeueReusableCellWithIdentifier:BasicCellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:BasicCellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:1];
            
        }
        
        GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayModel objectAtIndex:indexPath.row]];
        
        [cell.btn_Selection addTarget:self action:@selector(                                                                                                                                                                                                 goToPayment) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.btn_Choice addTarget:self action:@selector(goToPayment) forControlEvents:UIControlEventTouchUpInside];
        
        cell.lblAdress.text = order.consultation.patient_address;
        cell.lblFee1.text   = [NSString stringWithFormat:@"%@元",order.orderDoctor.consultation_fee]  ;
        cell.lblFee2.text   = [NSString stringWithFormat:@"%@元",order.orderDoctor.consultation_operation_fee];
        cell.lblName.text   = order.orderDoctor.name;
        cell.lblPositon.text = order.orderDoctor.current_address;
        
        for (int i = 0; i < order.orderDoctor.doctorFiles.count; i ++) {
            
            Doctorfiles* file = [order.orderDoctor.doctorFiles objectAtIndex:i];
            
            if (file.type == 1) {
                
                
                [cell.imgHead sd_setImageWithURL:[NSURL URLWithString:file.path] placeholderImage:[UIImage imageNamed:HEADPHOTO_PLACEHOUDER]];;
                
                
            }
            
        }
        
        return cell;
    }
    else if (indexPath.section==2)
    {
        AdvertisementShowCell* cell = [tableView dequeueReusableCellWithIdentifier:ListCellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:ListCellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }

        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        
        
        
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"确定要选择这位专家么?"];
        [alertView addButtonWithTitle:@"确认"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  
                                  
                                  
                                  
                                  NSLog(@"测试");
                                  OrderCommitCtrl *vc=[[OrderCommitCtrl alloc] initWithNibName:@"OrderCommitCtrl" bundle:nil];
                                  
                                  GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayModel objectAtIndex:indexPath.row]];
                                  vc.orderGS = order;
                                  
                                  [self.navigationController pushViewController:vc animated:YES];
                                  
                                  NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:order
                                                                                                    .id],@"id",@2,@"status",nil];
                                  
                                  [[NetworkManager shareMgr] server_updateOrderWithDic:dic completeHandle:^(NSDictionary *dic) {
                                      
                                      ;
                                      
                                  }];
                                  
                                  
                                  NSDictionary* dicConsult = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:order
                                                                                                           .consultation_id],@"id",@9,@"status",nil];
                                  
                                  [[NetworkManager shareMgr] server_updateConsultWithDic:dicConsult completeHandle:^(NSDictionary *dic) {
                                      
                                      ;
                                      
                                  }];
                                  
                              }];
        [alertView addButtonWithTitle:@"取消"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  
                              }];
        alertView.transitionStyle = SIAlertViewTransitionStyleDropDown;
        alertView.backgroundStyle = SIAlertViewBackgroundStyleSolid;
        
        alertView.willShowHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, willShowHandler3", alertView);
        };
        alertView.didShowHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, didShowHandler3", alertView);
        };
        alertView.willDismissHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, willDismissHandler3", alertView);
        };
        alertView.didDismissHandler = ^(SIAlertView *alertView) {
            NSLog(@"%@, didDismissHandler3", alertView);
        };
        
        [alertView show];
        

        
    }
    

}

- (void)goOther
{


}


-(void)goToPayment
{
    NSLog(@"测试");
    OrderCommitCtrl *vc=[[OrderCommitCtrl alloc] initWithNibName:@"OrderCommitCtrl" bundle:nil];
    
//    GSOrder* order = [GSOrder objectWithKeyValues:[self.arrayModel objectAtIndex:indexPath.row]];
//    vc.orderGS = order;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
