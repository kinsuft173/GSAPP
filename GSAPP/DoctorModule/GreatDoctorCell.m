//
//  GreatDoctorCell.m
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "GreatDoctorCell.h"

@implementation GreatDoctorCell

- (void)awakeFromNib {
    // Initialization code
    self.btn_Choice.layer.cornerRadius=5.0;
    self.btn_Choice.layer.masksToBounds=YES;
    
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
