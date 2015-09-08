//
//  OrderCommitCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/18.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "OrderCommitCtrl.h"
#import "OrderCommitCell.h"
#import "HKCommen.h"
#import "starView.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"
#import "Order.h"
#import "NetWorkManager.h"
#import "ExpertCertificationViewController.h"

@interface OrderCommitCtrl ()
@property (nonatomic,strong) starView *star;
@property (assign) BOOL judgePayOrNot;
@end

@implementation OrderCommitCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self.myTable reloadData];
}

-(void)initUI
{
    
    self.judgePayOrNot=NO;
    [HKCommen addHeadTitle:@"订单确认" whichNavigation:self.navigationItem];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    
    /*
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 50)];
    [rightButton setTitle:@"测试" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
     */
}

-(void)test
{
    self.judgePayOrNot=!self.judgePayOrNot;
    [self.myTable reloadData];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId = @"OrderCommitCell";
    
    OrderCommitCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    
    if (!cell) {
        
        NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
        cell = [topObjects objectAtIndex:0];
        [cell.btnPay addTarget:self action:@selector(goPayNow:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnRenzheng addTarget:self action:@selector(goRenzheng) forControlEvents:UIControlEventTouchUpInside];
    }
    
 
    [cell.btn_checkCommit setImage:[UIImage imageNamed:@"list_check-icon"] forState:UIControlStateNormal];
    
    if (!self.judgePayOrNot) {
        cell.view_PayAfter.hidden=YES;
        cell.view_PayBefore.hidden=NO;

    }
    else
    {
        cell.view_PayAfter.hidden=NO;
        cell.view_PayBefore.hidden=YES;
        [cell.btnPay setTitle:@"返回首页" forState:UIControlStateNormal];        
    }
    
    
    cell.view_PayBefore.layer.borderWidth=1.0;
    cell.view_PayBefore.layer.borderColor=[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0].CGColor;
    
    cell.view_PayAfter.layer.borderWidth=1.0;
    cell.view_PayAfter.layer.borderColor=[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0].CGColor;
    
    cell.lblAdress.text = self.orderGS.orderDoctor.address;
    cell.lblDept.text   = self.orderGS.orderDoctor.dept;
    cell.lblIntro.text  = self.orderGS.orderDoctor.intro;
    cell.lblName.text   = self.orderGS.orderDoctor.name;
    cell.lblPro.text    = self.orderGS.orderDoctor.position;
    cell.lblTel.text    = [NSString stringWithFormat:@"%lld",self.orderGS.orderDoctor.mobile];
    
    
    GSOrder* order =  self.orderGS;
    
    for (int i = 0; i < order.orderDoctor.doctorFiles.count; i ++) {
        
        Doctorfiles* file = [order.orderDoctor.doctorFiles objectAtIndex:i];
        
        if (file.type == 1) {
            
            
            [cell.imgHeadPhoto sd_setImageWithURL:[NSURL URLWithString:file.path] placeholderImage:[UIImage imageNamed:HEADPHOTO_PLACEHOUDER]];;
            
            
        }
        
    }
    
    return cell;
}

- (IBAction)goPayNow:(id)sender
{
    if (self.judgePayOrNot == NO) {
        [self payAliAction];
    
    }else{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    
    }

    
    
}



- (void)payAliAction
{
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = @"2088612117404563";
    NSString *seller = @"info@kswiki.com";
    NSString *privateKey = @"MIICdQIBADANBgkqhkiG9w0BAQEFAASCAl8wggJbAgEAAoGBAJoDAQHVkOxP0sscLyWTL8IlOKWMq75+lvIXmJTGZJ3NsoMV2lNMX7vklOazvlPrZN7BZHkHkYIzjwxNWE1u+QS+i6vCslzmnRMoO/hFiZ7fHPkyifklXfmb/efhc2p06w3nzwtoVceASInTh6iHibGMaCjifpKlV6sl17lvoT79AgMBAAECgYB1v7ozZs8ofVcShvfc6I1pCAApQkXEnRBXA4dap9whcjT7V+fWK9w90WOuhtoLWzuBu6ZPimPLghPqOfA7M48ay9gv7HMhVt9dWVIgf0DmmtNeCEEu0S5ex9x82d2t36PRbcAtBVTBQK4OJKSQ3V1sAxylZS6TZ1CgcSTksyHdgQJBAMiWSwPjRlWE6c0VHyb/J0F1zAtS3zdCHrDDoK+54D3wNIvrkIvG9p+YwL3MUETnQIXxKBBuAfz9imBLDhQoQ1ECQQDEjtvH9Y0RnfWWInnBNa0cN64CIwwkypGHkmr3ghi2hDqo/4kZJL8hnhVHiubzErars8ThdCPIJCK0QNRk3t3tAkAG4WDhWUJoXI7Ighj3dXkbPbcqDEWr15DF72/rlyyh80NaKVJj+Qcsoki6Oe/m7SfBcGw3ZA6dZvUAKJLrDhaBAkAn+q61YzqIRMq4+NYu+E33mVOpV5uWuCUVoDBlm26PYSHVUfR+yrydh9voK1aCRmIlVnFLMiY9BSyR4UXSJoqZAkAhBxGmwYu4dI1sbMbkFeFShNNLpFUoic1xo5kFQLlWCNkcRue9zxQQp2jQTbLjSnibclptWxxk/53+ZuSUVZE6";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO = [self generateTradeNO];//[NSString stringWithFormat:@"%@",[self.orderResult objectForKey:@"id"]];
    
    
    order.productName = [self generateTradeNO];
    
    order.productDescription = @"test";
    
    
    order.amount = [NSString stringWithFormat:@"0.01"];
    
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = @"GSAPP";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    

    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {

            NSString *resultStatus =  [resultDic objectForKey:@"resultStatus"];
            
            NSLog(@"resultDic = %@",resultDic);
            
            if (resultStatus.integerValue == 9000) {
                
                
//                   NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:self.consulation.id],@"id",@2,@"status", nil];
                
                NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                                 .id],@"id",@3,@"status",nil];

                [[NetworkManager shareMgr] server_updateOrderWithDic:dic completeHandle:^(NSDictionary *dic) {

                    ;
                    
                }];
                
                
                NSDictionary* dicConsult = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                                  .consultation_id],@"id",@3,@"status",nil];
                
                [[NetworkManager shareMgr] server_updateConsultWithDic:dicConsult completeHandle:^(NSDictionary *dic) {
                    
                    ;
                    
                }];
                
                
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil];
                
                self.judgePayOrNot=YES;
                [self.myTable reloadData];
            
            }
            else {
                
                NSString *mStr = [resultDic objectForKey:@"memo"];
                
                if (mStr != nil && ![mStr isEqualToString:@""]) {
                    //                    [CTCommon addAlertWithTitle:[resultDic objectForKey:@"memo"]];
                }
                
                NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                                  .id],@"id",@2,@"status",nil];
                
                [[NetworkManager shareMgr] server_updateOrderWithDic:dic completeHandle:^(NSDictionary *dic) {
                    
                    ;
                    
                }];
                
            }
            
        }];
        
    }
    
    
}

#pragma mark   ==============产生随机订单号==============


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}





/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (void)goRenzheng
{
    NSString* strUrl;
    
    if (self.orderGS.doctor.doctorFiles.count != 0) {
        
        for (int i = 0; i < self.orderGS.orderDoctor.doctorFiles.count; i ++) {
            
            Doctorfiles* file = [self.orderGS.orderDoctor.doctorFiles objectAtIndex:i];
            
            if (file.type == 2) {
                
                
                strUrl = file.path;
            }
            
        }
        
    }
    
    //[HKCommen addAlertViewWithTitel:@"测试模式尚无认证信息"];
    ExpertCertificationViewController* vc = [[ExpertCertificationViewController alloc] initWithNibName:@"ExpertCertificationViewController" bundle:nil];
    
    vc.strUrl = strUrl;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}




@end
