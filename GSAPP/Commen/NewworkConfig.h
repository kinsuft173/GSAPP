//
//  NewworkConfig.h
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#ifndef GSAPP_NewworkConfig_h
#define GSAPP_NewworkConfig_h


#define SERVER    @"http://120.24.80.159/gszx/api/web/?r="
#define SERVER_JPUSH    @"http://115.28.85.76/JPush/examples/"
#define SERVER_VERIFY @"http://120.24.80.159/gszx/api/web/?r=user/verify-code"

#pragma mark - 网络接口回调类型
typedef void (^CompleteHandle)(NSDictionary*);
typedef void (^FailHandle)();

#pragma mark - 网络相关url

//用户部分
#define USER_REGESTER_URL @"user/signup"

//用户部分
//#define USER_REGESTER_URL @"user/create"
#define USER_FETCH_URL @"user/view"
#define USER_UPDATE_URL @"user/update-password"

//广告部分
#define APP_AD_URL @"advertisement/index"

//医生
#define DOCTOR_FETCH_URL  @"expert/index"
#define NOMAL_DOCTOR_FETCH_URL  @"doctor/index"

#define DOCTOR_CREATE_URL  @"doctor/create"
#define DOCTOR_UPDATA_URL  @"doctor/update"
#define EXPERT__CREATE_URL  @"expert/create"
#define EXPERT_UPDATA_URL  @"expert/update"
//咨询问诊
#define CONSULATION_CREATE_URL @"consultation/create"
#define CONSULATION_FETCH_URL @"consultation/index"
#define CONSULATION_UPDATA_URL @"consultation/update"
#define CONSULATION_FETCH_FILE_CREATE_URL @"consultation-file/create"
#define Doctor_FETCH_FILE_CREATE_URL @"doctor-file/create"
//订单创建
#define ORDER_CREATE_URL @"order/create"
#define ORDER_FETCH_URL @"order/index"
#define ORDER_UPDATE_URL @"order/update"



//病史
#define ANAMNESIS_FETCH_URL @"anamnesis/index"

//分类
#define CATEGORY_FETCH_URL @"category/index"

//城市
#define CITY_FETCH_URL @"city/index"

//评价
#define EVALUATE_CREATE_URL @"evaluate/create"
#define EVALUATE_FETCH_URL @"evaluate/index"

//专长
#define EXPERTISE_FETCH_URL @"expertise/index"

//收藏
#define FAVORITES_FETCH_URL @"favorite/index"
#define FAVORITES_CREATE_URL @"favorite/create"
//投死
#define REPINE_CREATE_URL @"repine/create"
#define REPINE_FETCH_URL @"repine/index"

//症状
#define SYMPOM_FETCH_URL @"symptom/index"

#endif
