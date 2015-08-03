//
//  ConsultationInfoCtrl.h
//  GSAPP
//
//  Created by lijingyou on 15/7/17.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSConsulation.h"

@interface ConsultationInfoCtrl : UIViewController

@property (nonatomic, strong) NSDictionary* dicModel;
@property (weak, nonatomic) IBOutlet UIImageView *img_left;

@property (weak, nonatomic) IBOutlet UIImageView *img_middle;

@property (weak, nonatomic) IBOutlet UIImageView *img_right;


@property (strong, nonatomic) GSConsulation* consulation;

@end


