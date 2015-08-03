//
//  OrderCommitCtrl.h
//  GSAPP
//
//  Created by lijingyou on 15/7/18.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSOrder.h"

@interface OrderCommitCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSDictionary* dicModel;
@property (nonatomic, strong) GSOrder *orderGS;

@end
