//
//  GSRepine.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSRepine : NSObject

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, assign) NSInteger doctor_id;

@property (nonatomic, assign) NSInteger repined_doctor_id;

@property (nonatomic, assign) NSInteger order_id;

@end
