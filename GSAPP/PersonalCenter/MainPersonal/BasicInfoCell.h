//
//  BasicInfoCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicInfoCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lblName;
@property (nonatomic, strong) IBOutlet UILabel *lblProffeision;
@property (nonatomic, strong) IBOutlet UILabel *lblHospital;
@property (nonatomic, strong) IBOutlet UIImageView *imgHeadPhoto;

@end
