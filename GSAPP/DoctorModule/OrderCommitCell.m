//
//  OrderCommitCell.m
//  GSAPP
//
//  Created by lijingyou on 15/7/19.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "OrderCommitCell.h"

@implementation OrderCommitCell

- (void)awakeFromNib {
    // Initialization code
    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    
    [self.star setFrame:CGRectMake(0, 0, 82, 15)];
    
    self.star.whichValue=2.0;
    [self.viewForStar addSubview:self.star];
    
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
