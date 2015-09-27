//
//  ExpertCell.m
//  GSAPP
//
//  Created by kinsuft173 on 15/6/20.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ExpertCell.h"


@implementation ExpertCell

- (void)awakeFromNib {
    // Initialization code
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    
    [self.star setFrame:CGRectMake(0, 0, 82, 15)];
    
    self.star.whichValue=2.0;
    [self.viewForStar addSubview:self.star];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
