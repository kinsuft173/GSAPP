//
//  User.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GSExpert.h"

@interface User : NSObject


@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, assign) NSInteger status;

@property (nonatomic, strong) GSExpert *doctor;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *username;

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSString *updated_at;


@end

