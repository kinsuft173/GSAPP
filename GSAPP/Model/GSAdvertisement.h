//
//  GSAdvertisement.h
//  GSAPP
//
//  Created by kinsuft173 on 15/7/24.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSAdvertisement : NSObject


@property (nonatomic, assign) NSInteger status;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *path;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *uri;



@end
