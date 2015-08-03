//
//  DoctorDetailCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/11.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol touchExpand <NSObject>

-(void)Expand;

@end

@interface DoctorDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *btn_Expand;
@property (nonatomic,weak) id<touchExpand> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lbl_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_Diagnose;
@property (weak, nonatomic) IBOutlet UIButton *btn_Diagnose_opertation;
@property (weak, nonatomic) IBOutlet UILabel * lblDooctorName;
@property (nonatomic, strong) IBOutlet UILabel* lbl_consultation_fee;
@property (nonatomic, strong) IBOutlet UILabel* lbl_consultation_operation_fee;

@property (nonatomic, strong) IBOutlet UIImageView* imgHeadPhoto;
@property (nonatomic, strong) IBOutlet UIButton*    btnRenzheng;

@end
