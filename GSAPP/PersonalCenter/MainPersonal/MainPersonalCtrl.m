//
//  MainPersonalCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "MainPersonalCtrl.h"
#import "BasicInfoCell.h"
#import "ListCell.h"
#import "HKCommen.h"
#import "EditPersonalInfoCtrl.h"
#import "AboutUsCtrl.h"
#import "ChangePassWordCtrl.h"
#import "ServiceProjectCtrl.h"
#import "FullImageCtrl.h"
#import "LawProtectionCtrl.h"
#import "MyCaseCtrl.h"
#import "MyExpertCtrl.h"
#import "ComplainCtrl.h"
#import "LoginOutCell.h"
#import "SIAlertView.h"
#import "UserDataManager.h"
#import "NetWorkManager.h"

@interface MainPersonalCtrl ()<logOut>
@property (nonatomic,strong) NSArray *arrayOfList_first;
@property (nonatomic,strong) NSArray *arrayOfImage_first;

@property (nonatomic,strong) NSArray *arrayOfList_second;
@property (nonatomic,strong) NSArray *arrayOfImage_second;

@property (nonatomic, strong) NSString* strHeadUrl;
@property (nonatomic, strong) NSString* strIdUrl;
@property (nonatomic, strong) NSString* strZigezhengUrl;

@end

@implementation MainPersonalCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.arrayOfList_first=[NSArray arrayWithObjects:@"我的案例",@"我的专家",@"我的投诉", nil];
    
    self.arrayOfImage_first=[NSArray arrayWithObjects:@"list_icon_case",@"list_icon_experts",@"list_icon_complaints", nil];
    
    self.arrayOfList_second=[NSArray arrayWithObjects:@"法律保障",@"服务项目",@"关于我们", nil];
    
    self.arrayOfImage_second=[NSArray arrayWithObjects:@"list_icon_law",@"list_icon_service",@"list_icon_about", nil];
    
    [HKCommen setExtraCellLineHidden:self.myTable];
    
    [HKCommen addHeadTitle:@"个人中心" whichNavigation:self.navigationItem];
    
    
    if ([[UserDataManager shareManager].userType isEqualToString:ExpertType]) {
    
        NSMutableDictionary* dic = [[NSMutableDictionary  alloc] init];
        
        [dic setObject:[NSNumber  numberWithInteger:[UserDataManager shareManager].user.doctor.id] forKey:@"and[id]"];
        [dic setObject:@"doctorFiles" forKey:@"expand"];
        
        [[NetworkManager shareMgr] server_fetchDoctorsWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSLog(@"server_fetchNomalDoctorsWithDic ===> dic = %@",response);
            
            NSArray* arrayItems = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (arrayItems.count != 0) {
                
                NSArray* arrayHeadUrl = [[arrayItems objectAtIndex:0]  objectForKey:@"doctorFiles"];
                
                NSString* strHeadUrl;
                
                NSString* strIdUrl;
                NSString* strZigezhengUrl;
                
                if (arrayHeadUrl.count != 0) {
                    
                    for (int i = 0; i < arrayHeadUrl.count; i ++) {
                        
                        NSDictionary* dic = [arrayHeadUrl objectAtIndex:i];
                        
                        if ([[dic objectForKey:@"type"] integerValue] == 1) {
                            
                            strHeadUrl = dic[@"path"];
                            
                        }
                        
                        if ([[dic objectForKey:@"type"] integerValue] == 2) {
                            
                            strZigezhengUrl = dic[@"path"];
                            
                        }
                        
                        if ([[dic objectForKey:@"type"] integerValue] == 3) {
                            
                            strIdUrl = dic[@"path"];
                            
                        }
                        
                    }
                    
                        
                }
                    
                    self.strHeadUrl = strHeadUrl;
                    self.strIdUrl = strIdUrl;
                    
                    self.strZigezhengUrl = strZigezhengUrl;
                    
                    
                    
                    

                
                
                [self.myTable reloadData];
                
                
                
            }
            
            
            
        }];

        
        
    }else{
    
        NSMutableDictionary* dic = [[NSMutableDictionary  alloc] init];
        
        [dic setObject:[NSNumber  numberWithInteger:[UserDataManager shareManager].user.doctor.id] forKey:@"and[id]"];
        [dic setObject:@"doctorFiles" forKey:@"expand"];
        
        [[NetworkManager shareMgr] server_fetchNomalDoctorsWithDic:dic completeHandle:^(NSDictionary *response) {
            
            NSLog(@"server_fetchNomalDoctorsWithDic ===> dic = %@",response);
            
            NSArray* arrayItems = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            if (arrayItems.count != 0) {
                
                NSArray* arrayHeadUrl = [[arrayItems objectAtIndex:0]  objectForKey:@"doctorFiles"];
                
                NSString* strHeadUrl;
                NSString* strIdUrl;
                NSString* strZigezhengUrl;
                
                NSLog(@"这里 %@",arrayHeadUrl);
                
                if (arrayHeadUrl.count != 0) {
                    
                    for (int i = 0; i < arrayHeadUrl.count; i ++) {
                        
                        NSDictionary* dic = [arrayHeadUrl objectAtIndex:i];
                        
                        if ([[dic objectForKey:@"type"] integerValue] == 1) {
                            
                            strHeadUrl = dic[@"path"];
                            
                        }
                        
                        if ([[dic objectForKey:@"type"] integerValue] == 2) {
                            
                            strZigezhengUrl = dic[@"path"];
                            
                        }
                        
                        if ([[dic objectForKey:@"type"] integerValue] == 3) {
                            
                            strIdUrl = dic[@"path"];
                            
                        }
                        
                        
                    }
                    

                    
                    
                }
                
                    
             
                
                self.strIdUrl = strIdUrl;
                
                self.strZigezhengUrl = strZigezhengUrl;
                
                    self.strHeadUrl = strHeadUrl;
                    
                
                    
                    [self.myTable reloadData];
                
                }
                
                
                
                
                
            
            
            
            
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
    return 5;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==2||section==3) {
        return 3;
    }
    else
    {
    return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        
        return  49;
        
    }
    
    if (indexPath.section==0) {
        return 90;
    }
    return 45;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* BasicCellId = @"BasicInfoCell";
    static NSString* ListCellId=@"ListCell";
    static NSString* LoginOut=@"loginOut";
    
    if (indexPath.section==0) {
        BasicInfoCell* cell = [tableView dequeueReusableCellWithIdentifier:BasicCellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:BasicCellId owner:self options:nil];
            
            if ([UIScreen mainScreen].bounds.size.width>=375) {
                cell = [topObjects objectAtIndex:0];
            }
            else
            {
            cell = [topObjects objectAtIndex:1];
            }
            
            cell.lblName.text = [UserDataManager shareManager].user.doctor.name;
            cell.lblProffeision.text = [UserDataManager shareManager].user.doctor.position;
            cell.lblHospital.text = [UserDataManager shareManager].user.doctor.hospital;
            
//            for (int i = 0; i < [UserDataManager shareManager].user.doctor.doctorFiles.count; i ++) {
//                
//                Doctorfiles* file = [[UserDataManager shareManager].user.doctor.doctorFiles objectAtIndex:i];
//                
//                if (file.type == 1) {
//                    
//                    
//                    [cell.imgHeadPhoto sd_setImageWithURL:[NSURL URLWithString:file.path] placeholderImage:[UIImage imageNamed:HEADPHOTO_PLACEHOUDER]];;
//                    
//                    
//                }
//                
//            }
        
            
        }
        
        
        cell.lblName.text = [UserDataManager shareManager].user.doctor.name;
        cell.lblProffeision.text = [UserDataManager shareManager].user.doctor.position;
        cell.lblHospital.text = [UserDataManager shareManager].user.doctor.hospital;
        
        if (![[self.strHeadUrl class] isSubclassOfClass:[NSNull class]]) {
            
            [cell.imgHeadPhoto sd_setImageWithURL:[NSURL URLWithString:self.strHeadUrl]
                                 placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
            
        }
        
        return cell;
        
    }   else if (indexPath.section==4)
    {
        LoginOutCell* cell = [tableView dequeueReusableCellWithIdentifier:LoginOut];
        if (!cell) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"LoginOutCell" owner:self options:nil];
            cell = [topLevelObjects objectAtIndex:0];
            
            cell.delegate = self;
        }
        return cell;
        
        
    }

    else
    {
        ListCell* cell = [tableView dequeueReusableCellWithIdentifier:ListCellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:ListCellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        if (indexPath.section==1) {
            cell.lbl_List.text=@"修改密码";
            cell.img_List.image=[UIImage imageNamed:@"list_icon_locked"];
        }
        else if (indexPath.section==2)
        {
            cell.lbl_List.text=[self.arrayOfList_first objectAtIndex:indexPath.row];
            cell.img_List.image=[UIImage imageNamed:[self.arrayOfImage_first objectAtIndex:indexPath.row]];
        }
        else if (indexPath.section==3)
        {
            cell.lbl_List.text=[self.arrayOfList_second objectAtIndex:indexPath.row];
            cell.img_List.image=[UIImage imageNamed:[self.arrayOfImage_second objectAtIndex:indexPath.row]];
        }
        
        
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 8.0;
    }
    return 12.0;
}

- (UIView * )tableView:(UITableView * )tableView
viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc]init];
    view.backgroundColor=[UIColor clearColor];
    return view;
}


#pragma tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        EditPersonalInfoCtrl *vc=[[EditPersonalInfoCtrl alloc]initWithNibName:@"EditPersonalInfoCtrl" bundle:nil];
        
        vc.strHeadUrl = self.strHeadUrl;
        vc.strIdUrl = self. strIdUrl;
        vc.strZigezhengUrl = self.strZigezhengUrl;
        
        vc.hidesBottomBarWhenPushed=YES;
    
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            
//            [HKCommen addAlertViewWithTitel:@"尚在测试之中"];
//            return;

            ChangePassWordCtrl *vc=[[ChangePassWordCtrl alloc]initWithNibName:@"ChangePassWordCtrl" bundle:nil];
  
            vc.hidesBottomBarWhenPushed=YES;
   
            [self.navigationController pushViewController:vc animated:YES];

        }
        
        
    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0)
        {
            MyCaseCtrl *vc=[[MyCaseCtrl alloc]initWithNibName:@"MyCaseCtrl" bundle:nil];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==1)
        {
            
            MyExpertCtrl *vc=[[MyExpertCtrl alloc]initWithNibName:@"MyExpertCtrl" bundle:nil];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==2)
        {
            
            ComplainCtrl *vc=[[ComplainCtrl alloc]initWithNibName:@"ComplainCtrl" bundle:nil];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section==3)
    {
        if (indexPath.row==0)
        {
            LawProtectionCtrl *vc=[[LawProtectionCtrl alloc]initWithNibName:@"LawProtectionCtrl" bundle:nil];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==1)
        {
            ServiceProjectCtrl *vc=[[ServiceProjectCtrl alloc]initWithNibName:@"ServiceProjectCtrl" bundle:nil];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==2)
        {
            AboutUsCtrl *vc=[[AboutUsCtrl alloc]initWithNibName:@"AboutUsCtrl" bundle:nil];
            vc.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}



- (void)logOut
{

    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"是否确认退出"];
    [alertView addButtonWithTitle:@"确认"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self goOut];
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

- (void)goOut
{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    
}
    

@end
