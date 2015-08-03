//
//  MessageAlertCell.m
//  GSAPP
//
//  Created by lijingyou on 15/7/23.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "MessageAlertCell.h"

@implementation MessageAlertCell

- (void)awakeFromNib {
    // Initialization code
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
