//
//  GSOrder.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "GSConsulation.h"
#import "GSExpert.h"
#import <Foundation/Foundation.h>

@interface GSOrder : NSObject


@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger consultation_id;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) NSInteger doctor_id;

@property (nonatomic, assign) NSInteger order_doctor_id;

@property (nonatomic, assign) NSInteger type;


@property (nonatomic, strong) GSConsulation*  consultation;
@property (nonatomic, strong) GSExpert*        orderDoctor;
@property (nonatomic, strong) GSExpert*        doctor;

@end
