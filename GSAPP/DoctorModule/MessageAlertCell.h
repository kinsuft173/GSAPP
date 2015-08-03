//
//  MessageAlertCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/23.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageAlertCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img_goNext;
@property (weak, nonatomic) IBOutlet UILabel *lbl_hintOfMessage;

@property (weak, nonatomic) IBOutlet UITextView *txtIntro;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (nonatomic, strong) IBOutlet UIImageView* imgHeadPhoto;



@end
