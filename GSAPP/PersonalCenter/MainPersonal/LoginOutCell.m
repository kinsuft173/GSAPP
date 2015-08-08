//
//  LoginOutCell.m
//  UserManager
//
//  Created by walter on 14-9-3.
//  Copyright (c) 2014年 Stanford. All rights reserved.
//

#import "LoginOutCell.h"
#import "UtilityManager.h"
#import "HKCommen.h"

@implementation LoginOutCell

- (void)awakeFromNib
{
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
    
    self.backgroundColor = [HKCommen getColor:@"e6e6e6"];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.3; //定义按的时间
    [self.btnLoginOut addGestureRecognizer:longPress];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)logOut:(id)sender
{
    [self.delegate logOut];
}

-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    
    /*
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        self.maskView3.backgroundColor = [CTCommon getColor:@"d02127"];
    }
    else if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        self.maskView3.backgroundColor = [CTCommon getColor:@"ff0033"];
    }
     */
}

@end
