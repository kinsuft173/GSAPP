//
//  GSExpert.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Doctorfiles;
@interface GSExpert : NSObject


//@property (nonatomic, assign) NSInteger recommended;
//
//@property (nonatomic, copy) NSString *hospital;
//
//@property (nonatomic, copy) NSString *position;
//
//@property (nonatomic, assign) NSInteger city_id;
//
//@property (nonatomic, assign) NSInteger status;
//
//@property (nonatomic, copy) NSString *title;
//
//@property (nonatomic, assign) NSInteger user_id;
//
//@property (nonatomic, copy) NSString *weixin;
//
//@property (nonatomic, copy) NSString *current_address;
//
//@property (nonatomic, copy) NSString *dept;
//
//@property (nonatomic, assign) NSInteger score_times;
//
//@property (nonatomic, assign) NSInteger sex;
//
//@property (nonatomic, copy) NSString *avg_score;
//
//@property (nonatomic, copy) NSString *intro;
//
//@property (nonatomic, copy) NSString *latitude;
//
//@property (nonatomic, copy) NSString *updated_at;
//
//@property (nonatomic, copy) NSString *name;
//
//@property (nonatomic, copy) NSString *consultation_operation_fee;
//
//@property (nonatomic, assign) NSInteger type;
//
//@property (nonatomic, copy) NSString *consultation_fee;
//
//@property (nonatomic, assign) NSInteger expertise;
//
//@property (nonatomic, assign) NSInteger id;
//
//@property (nonatomic, copy) NSString *email;
//
//@property (nonatomic, copy) NSString *longitude;
//
//@property (nonatomic, assign) long long mobile;
//
//@property (nonatomic, assign) long long identity;
//
//@property (nonatomic, assign) NSInteger expertise_id;
//
//@property (nonatomic, assign) NSInteger certified;
//
//@property (nonatomic, copy) NSString *created_at;
//
//@property (nonatomic, assign) NSInteger qq;
//
//@property (nonatomic, assign) NSInteger category_id;
//
//@property (nonatomic, copy) NSString *address;


@property (nonatomic, assign) NSInteger certified;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *hospital;

@property (nonatomic, assign) NSInteger score_times;

@property (nonatomic, strong) NSArray *doctorFiles;

@property (nonatomic, copy) NSString *current_address;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *dept;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger recommended;

@property (nonatomic, copy) NSString *weixin;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, assign) NSInteger sex;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *avg_score;

@property (nonatomic, copy) NSString *position;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger expertise_id;

@property (nonatomic, copy) NSString *longitude;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *expertise;

@property (nonatomic, copy) NSString *consultation_fee;

@property (nonatomic, assign) NSInteger user_id;

@property (nonatomic, copy) NSString *updated_at;

@property (nonatomic, copy) NSString *qq;

@property (nonatomic, copy) NSString *consultation_operation_fee;

@property (nonatomic, assign) NSInteger city_id;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *category_id;

@property (nonatomic, copy) NSString *identity;

@property (nonatomic, copy) NSString *latitude;

@end

@interface Doctorfiles : NSObject

@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, assign) NSInteger doctor_id;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *created_at;



@end
