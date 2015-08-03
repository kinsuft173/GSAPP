//
//  CommentTitleCell.m
//  GSAPP
//
//  Created by lijingyou on 15/7/28.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "CommentTitleCell.h"

@implementation CommentTitleCell

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
