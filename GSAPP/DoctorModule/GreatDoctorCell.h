//
//  GreatDoctorCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GreatDoctorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_Choice;
@property (weak, nonatomic) IBOutlet UIButton *btn_Selection;

@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UILabel *lblFee1;
@property (nonatomic, strong) IBOutlet UILabel *lblFee2;
@property (nonatomic, strong) IBOutlet UILabel *lblAdress;
@property (nonatomic, strong) IBOutlet UILabel *lblPositon;


@end
