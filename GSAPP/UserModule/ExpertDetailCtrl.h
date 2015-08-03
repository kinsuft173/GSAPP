//
//  ExpertDetailCtrl.h
//  GSAPP
//
//  Created by kinsuft173 on 15/6/20.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"
#import "DiagnoseInfoCtrl.h"
#import "GSExpert.h"
#import "starView.h"

@interface ExpertDetailCtrl : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *myTable;
//@property (strong, nonatomic) NSDictionary* dicModel;
@property (nonatomic, strong) GSExpert* expert;

@end
