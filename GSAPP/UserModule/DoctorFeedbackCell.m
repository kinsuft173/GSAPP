//
//  DoctorFeedbackCell.m
//  GSAPP
//
//  Created by lijingyou on 15/7/11.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "DoctorFeedbackCell.h"

@implementation DoctorFeedbackCell

- (void)awakeFromNib {
    // Initialization code
    
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
    
    self.txt_Comment.layer.borderWidth=1.4;
    self.txt_Comment.layer.borderColor=[UIColor colorWithRed:165.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:0.8].CGColor;
    
    self.star=[[[NSBundle mainBundle]loadNibNamed:@"starView" owner:self options:nil] objectAtIndex:0];
    
    if ([UIScreen mainScreen].bounds.size.width>=375) {
        [self.star setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/6.5, 16, 82, 15)];
    }
    else
    {
        [self.star setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/4.5, 16, 82, 15)];
    }
    
    [self.star.img_star1 addTarget:self action:@selector(touchStar:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.star.img_star2 addTarget:self action:@selector(touchStar:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.star.img_star3 addTarget:self action:@selector(touchStar:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.star.img_star4 addTarget:self action:@selector(touchStar:) forControlEvents:UIControlEventTouchUpInside];
    
    //[self.star addGestureRecognizer:gesture];
    
    [self.view addSubview:self.star];
}


-(void)touchStar:(UIButton *)sender
{
    //NSLog(@"标志%ld",sender.tag);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTable" object:nil];
    
    
    
    CGFloat value=sender.tag;
    self.star.whichValue=value;
    [self.view addSubview:self.star];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initWithDict:(CGFloat)value
{
    self.star.whichValue=value;
}

@end
