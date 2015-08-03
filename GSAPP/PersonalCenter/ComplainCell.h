//
//  ComplainCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/15.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplainCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbl_treat;
@property (weak, nonatomic) IBOutlet UIImageView *imgOfDisease;

@property (nonatomic, strong) IBOutlet UILabel *lblBingshi;
@property (nonatomic, strong) IBOutlet UILabel *lblZhengzhuan;
@property (nonatomic, strong) IBOutlet UILabel *lblDescription;

@end
