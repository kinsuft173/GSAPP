//
//  DoctorCommentCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/28.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"

@interface DoctorCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *txt_comment;
@property (nonatomic,strong) starView *star;

@property (weak, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lbl_value;
@property (weak, nonatomic) IBOutlet UIView *view_Show;

@end
