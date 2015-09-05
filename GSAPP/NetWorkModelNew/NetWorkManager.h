//
//  NetworkManager.h
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKCommen.h"
#import "MBProgressHUD.h"
#import "MJExtension.h"

#define NET_SUCCESS 200
typedef void (^HKSignInResponse)(BOOL);

@interface NetworkManager : NSObject

+ (NetworkManager*)shareMgr;


//用户部分
- (void)server_createUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_fetchUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_updateUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//普医生
- (void)server_fetchNomalDoctorsWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//广告部分
- (void)server_fetchAdvertisementWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//医生部分
- (void)server_fetchDoctorsWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_createDoctorsWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
//咨询问诊
//- (void)server_createConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_createConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle failHandle:(FailHandle)failHandle;
- (void)server_fetchConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_updateConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
//订单
- (void)server_createOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_fetchOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_updateOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//病史
- (void)server_fetchAnamnesisWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//分类
- (void)server_fetchCategoryWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//城市
- (void)server_fetchCityWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//评价
- (void)server_createEvaluateWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_fetchEvaluateWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//专长
- (void)server_fetchExpertiseWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//收藏
- (void)server_createFavoritesWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_fetchFavoritesWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//投诉
- (void)server_fetchRepineWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_createRepineWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
//症状
- (void)server_fetchSymptomWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//验证码
- (void)server_fetchVerifyCodeWithDic:(NSDictionary*)dic  completeHandle:(CompleteHandle)completeHandle;

//用户注册
- (void)server_registerWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
//- (void)server_upDateUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//用户登录
- (void)signInWithUsername:(NSString *)username
                  password:(NSString *)password
                      type:(NSInteger )type
                  complete:(HKSignInResponse)completeBlock;

//用户修改资料
- (void)server_updateDoctorWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_updateExpertWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
//- (void)server_updateUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//上传文件
- (void)server_createConsulationImageWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;
- (void)server_createDoctorImageWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle;

//临时的jpush接口
//- (void)server_jpushUserGenerate;
//
//- (void)server_jpushDoctorGenerate;
- (void)server_testJson;
- (NSDictionary*)server_BaseGet:(NSDictionary*)dic url:(NSString*)ctUrl;

- (void)server_jpushDoctorGenerate;
- (void)server_jpushUserGenerate;

- (void)setTags:(NSString*)tag;
@end
