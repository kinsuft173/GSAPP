//
//  MyCaseCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/13.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyCaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgOfDisease;
@property (weak, nonatomic) IBOutlet UILabel *lbl_treat;

@property (weak, nonatomic) IBOutlet UILabel *lbl_bingshi;
@property (weak, nonatomic) IBOutlet UILabel *lbl_zhuangzhuang;
@property (weak, nonatomic) IBOutlet UILabel *lbl_jibingmiaoshu;

@property (weak, nonatomic) IBOutlet UIButton *btn_tousu;
@property (weak, nonatomic) IBOutlet UIButton *btn_comment;

@end
