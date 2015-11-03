//
//  OrderCommitCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/19.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"



@interface OrderCommitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_PayBefore;
@property (weak, nonatomic) IBOutlet UIView *view_PayAfter;
@property (weak, nonatomic) IBOutlet UIButton *btn_checkCommit;
@property (weak, nonatomic) IBOutlet UIView *viewForStar;

@property (nonatomic, strong) IBOutlet UIButton* btnPay;
@property (nonatomic,strong) starView *star;



@property (nonatomic, strong) IBOutlet UILabel* lblName;
@property (nonatomic, strong) IBOutlet UILabel* lblPro;
@property (nonatomic, strong) IBOutlet UILabel* lblIntro;
@property (nonatomic, strong) IBOutlet UILabel* lblDept;
@property (nonatomic, strong) IBOutlet UILabel* lblHospital;
@property (nonatomic, strong) IBOutlet UILabel* lblDeptAndSurgery;

@property (nonatomic, strong) IBOutlet UILabel *lblAdress;
@property (nonatomic, strong) IBOutlet UILabel *lblTel;
//@property (nonatomic, strong) IBOutlet UILabel *lblIntro;

@property (nonatomic, strong) IBOutlet UIImageView* imgHeadPhoto;
@property (nonatomic, strong) IBOutlet UIButton* btnRenzheng;

@end
