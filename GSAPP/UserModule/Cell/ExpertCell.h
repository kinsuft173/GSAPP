//
//  ExpertCell.h
//  GSAPP
//
//  Created by kinsuft173 on 15/6/20.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "starView.h"

@interface ExpertCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *view;
@property (nonatomic,strong) starView *star;
@property (weak, nonatomic) IBOutlet UIView *viewForStar;

@property (nonatomic, strong) IBOutlet UILabel* lblName;
@property (nonatomic, strong) IBOutlet UILabel* lblPro;
@property (nonatomic, strong) IBOutlet UILabel* lblIntro;
@property (nonatomic, strong) IBOutlet UILabel* lblDept;
@property (nonatomic, strong) IBOutlet UILabel* lblDeptAndSurgery;

@property (nonatomic, strong) IBOutlet UIImageView* imgHeadPhoto;

@end
