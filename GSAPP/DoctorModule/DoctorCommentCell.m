//
//  DoctorCommentCell.m
//  GSAPP
//
//  Created by lijingyou on 15/7/28.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "DoctorCommentCell.h"

@implementation DoctorCommentCell

- (void)awakeFromNib {
    // Initialization code
    
    
    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    
    /*
    if ([UIScreen mainScreen].bounds.size.width>=375) {
        [self.star setFrame:CGRectMake(115, 47, 82, 15)];
    }
    else
    {
        [self.star setFrame:CGRectMake(138, 47, 82, 15)];
    }
     */
    

    
    
    
    self.star.whichValue=2.0;
    [self.view_Show addSubview:self.star];
    
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
