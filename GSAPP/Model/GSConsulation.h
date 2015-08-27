//
//  GSConsulation.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GSExpert.h"

@class Consultationfiles;
@interface GSConsulation : NSObject


@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *order_at;

@property (nonatomic, assign) NSInteger other_order;

@property (nonatomic, copy) NSString *patient_mobile;

@property (nonatomic, copy) NSString *patient_illness;

@property (nonatomic, copy) NSString *patient_address;

@property (nonatomic, assign) NSInteger doctor_id;

@property (nonatomic, copy) NSString *patient_dept;

@property (nonatomic, copy) NSString *patient_name;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *purpose;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger anamnesis_id;

@property (nonatomic, copy) NSString *anamnesis;

@property (nonatomic, copy) NSString *symptom;

@property (nonatomic, copy) NSString *patient_hospital;

@property (nonatomic, assign) NSInteger timely;

@property (nonatomic, copy) NSString *patient_city;

@property (nonatomic, assign) NSInteger symptom_id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) NSInteger patient_sex;

@property (nonatomic, copy) NSString *remark;

@property (nonatomic, assign) NSInteger patient_age;

@property (nonatomic, assign) NSInteger expert_id;

@property (nonatomic, strong) GSExpert* doctor;



///////




@property (nonatomic, strong) NSArray *consultationFiles;




@end
@interface Consultationfiles : NSObject

@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger consultation_id;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *created_at;

@end

