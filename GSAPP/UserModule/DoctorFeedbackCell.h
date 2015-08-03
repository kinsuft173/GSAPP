//
//  DoctorFeedbackCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/11.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"

@interface DoctorFeedbackCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *txt_Comment;
@property (strong,nonatomic) starView *star;
@property (weak, nonatomic) IBOutlet UIView *view;
-(void)initWithDict:(CGFloat)value;
@end
