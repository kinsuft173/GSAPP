//
//  GreatDoctorCtrl.h
//  GSAPP
//
//  Created by lijingyou on 15/7/12.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSConsulation.h"

@interface GreatDoctorCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSDictionary* dicConsultModel;
@property (nonatomic, strong) GSConsulation* consulation;

@end
