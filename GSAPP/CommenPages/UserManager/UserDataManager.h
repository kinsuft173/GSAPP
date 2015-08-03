//
//  UserDataManager.h
//  ksbk
//
//  Created by 胡昆1 on 12/6/14.
//  Copyright (c) 2014 cn.chutong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>

@interface UserDataManager : NSObject

@property (nonatomic, strong) NSMutableDictionary* dicModel;
@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* userType;

@property CLLocationCoordinate2D curruentCoordinate;

+ (UserDataManager*)shareManager;



@end
