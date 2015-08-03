//
//  NetworkManager.m
//  GSAPP
//
//  Created by 胡昆1 on 7/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "NetworkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "UserDataManager.h"
#import "SBJson.h"
#import "APService.h"

@implementation NetworkManager

+ (NetworkManager*)shareMgr
{
    static NetworkManager* instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[NetworkManager alloc] init];

    });
    
    return instance;
}

#pragma mark - 用户相关接口
- (void)server_createUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"username": @"18672354399",@"password_hash":@"$2y$13$eD.OPcraVj8wMrADnMTPpeJVDzQTncvRClQcRDt2a0gRPRW4ZKWbC"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,USER_REGESTER_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


- (void)server_fetchUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"id": @"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,USER_FETCH_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}

- (void)server_updateUserWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"email": @"xianfengshizhazha@caidigou.net"};
    
    [manager PUT:[NSString stringWithFormat:@"%@%@&%@=%@",SERVER,USER_UPDATE_URL,@"id",@"1"] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
}


#pragma mark - 广告页面

- (void)server_fetchAdvertisementWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"id": @"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,APP_AD_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


#pragma mark -- 医生

- (void)server_fetchDoctorsWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"recommended": @"0"};
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    if (![parameters objectForKey:@"expand"]) {
        
        
        [parameters setValue:@"doctorFiles" forKey:@"expand"];
    }
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,DOCTOR_FETCH_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

#pragma mark - 咨询问诊

- (void)server_createConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"doctor_id": @"1",@"patient_name":@"SDS",@"patient_sex": @"1",@"patient_age":@"1",@"patient_mobile": @"18672354399",@"patient_dept":@"SDS",@"symptom_id": @"1",@"patient_illness":@"SDS",@"anamnesis_id": @"1",@"timely":@"1",@"other_order":@"1",@"expert_id":@"1"};
    
    NSLog(@"dic_server_createConsultWithDic = %@",dic);
    
    
    
    NSMutableDictionary* dicNew = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,CONSULATION_CREATE_URL] parameters:dicNew success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        
        NSLog(@"server_createConsultWithDic===>: %@", responseObject);
        
//     [self server_jpushUserGenerate];
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
//     [self server_BasePost:dic url:[NSString stringWithFormat:@"%@%@",SERVER,ORDER_CREATE_URL]];
    
}


- (void)server_fetchConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"id": @"1",@"patient_name":@"SDS",@"patient_sex": @"1",@"patient_age":@"1",@"patient_mobile": @"18672354399",@"patient_dept":@"SDS",@"symptom_id": @"1",@"patient_illness":@"SDS",@"anamnesis_id": @"1",@"timely":@"1",@"other_order":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,CONSULATION_FETCH_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        //tst
        NSLog(@"server_fetchConsultWithDic == >JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)server_updateConsultWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{

    [self server_BasePost:dic url:[NSString stringWithFormat:@"http://115.28.85.76/study/insert2.php"]];
    [[NetworkManager shareMgr] server_jpushUserGenerate];

}



#pragma mark - 订单
- (void)server_createOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,ORDER_CREATE_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"server_createOrderWithDic: %@", responseObject);
        
        [self server_jpushDoctorGenerate];
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];

    
}

- (void)server_fetchOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,ORDER_FETCH_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"server_fetchOrderWithDic = >>JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

- (void)server_updateOrderWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
//    NSString* strId = [NSString stringWithFormat:@"%d",[[dic objectForKey:@"id"] integerValue]];
//    
    NSMutableDictionary* dicNew = [[NSMutableDictionary alloc] initWithDictionary:dic];
//
//    [dicNew removeObjectForKey:@"id"];
//    [dicNew setObject:@"184" forKey:@"id"];
//
    
    
    //test
//    NSDictionary *parameters = @{@"status":@2};
    
//    [manager PUT:[NSString stringWithFormat:@"%@%@&%@=%@",SERVER,ORDER_UPDATE_URL,@"id",strId] parameters:dicNew success:^(AFHTTPRequestOperation *operation, id responseObject){
//        
//        NSLog(@"JSON: %@", responseObject);
//        
//        if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
//            
//            [self server_jpushUserGenerate];
//            
//        }else{
//        
//            [self server_jpushDoctorGenerate];
//        
//        }
//        
//        completeHandle(responseObject);
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
    
//    [self server_BasePost:dic url:[NSString stringWithFormat:@"%@%@",SERVER,ORDER_UPDATE_URL]];
    //自己的服务
    [self server_BasePost:dic url:[NSString stringWithFormat:@"http://115.28.85.76/study/insert.php"]];
    
    if ([[dic objectForKey:@"status"] integerValue] == 3) {
        
     [[NetworkManager shareMgr] server_jpushUserGenerate];
        
    }else{
    
     [[NetworkManager shareMgr] server_jpushDoctorGenerate];
        
    }
    
}

//病史

- (void)server_fetchAnamnesisWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,ANAMNESIS_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


//分类
- (void)server_fetchCategoryWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,CATEGORY_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//城市
- (void)server_fetchCityWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    //    NSDictionary *parameters = @{@"doctor_id":@"1",@"order_doctor_id":@"2",@"consultation_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,CITY_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//评价
- (void)server_createEvaluateWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"doctor_id":@"1",@"evaluated_doctor_id":@"2",@"order_id":@"1",@"score":@"4",@"content":@"显峰号恶心啊"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,EVALUATE_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


- (void)server_fetchEvaluateWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
        NSDictionary *parameters = @{@"order_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,EVALUATE_FETCH_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


//专长
- (void)server_fetchExpertiseWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"order_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,EXPERTISE_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//收藏
- (void)server_createFavoritesWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //test
  NSDictionary *parameters = @{@"doctor_id":@"1",@"favorite_doctor_id":@"2"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,FAVORITES_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


- (void)server_fetchFavoritesWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //test
    //    NSDictionary *parameters = @{@"doctor_id":@"1",@"favorite_doctor_id":@"2"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,FAVORITES_FETCH_URL] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//投诉
- (void)server_fetchRepineWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
    NSDictionary *parameters = @{@"doctor_id":@"1",@"repined_doctor_id":@"1",@"order_id":@"1",@"content":@"11111"};
    
    [manager POST:[NSString stringWithFormat:@"%@%@",SERVER,REPINE_CREATE_URL] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}

//症状
- (void)server_fetchSymptomWithDic:(NSDictionary*)dic completeHandle:(CompleteHandle)completeHandle
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //test
//    NSDictionary *parameters = @{@"doctor_id":@"1"};
    
    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER,REPINE_FETCH_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"JSON: %@", responseObject);
        
        completeHandle(responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


//#pragma mark- 独立的操作几个接口
//- (void)server_getRecombinationSelectOrderWithArrayParams:(NSArray*)arrayDic
//{
//
//    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    
//    AFHTTPRequestOperation *operation1 = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    
//    [operation1 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
//    
//    
//    
//    
//    
//    NSURL *url2 = [NSURL URLWithString:@"http://www.sohu.com"];
//    
//    NSURLRequest *request2 = [NSURLRequest requestWithURL:url2];
//    
//    AFHTTPRequestOperation *operation2 = [[AFHTTPRequestOperation alloc] initWithRequest:request2];
//    
//    [operation2 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"Response2: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
//    
//    NSURL *url3 = [NSURL URLWithString:@"http://www.sina.com"];
//    
//    NSURLRequest *request3 = [NSURLRequest requestWithURL:url3];
//    
//    AFHTTPRequestOperation *operation3 = [[AFHTTPRequestOperation alloc] initWithRequest:request3];
//    
//    [operation3 setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
////        NSLog(@"Response3: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
//    
//    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
//    
//    [operation2 addDependency:operation1];
//    
//    [operation1 addDependency:operation3];
//    
//    [operationQueue addOperations:@[operation1, operation2, operation3] waitUntilFinished:NO];
//    
//
//
//}

#pragma mark -临时的jpush测试接口

- (void)server_jpushUserGenerate
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER_JPUSH,@"PushExpert.php"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
//        
//        NSLog(@"JSON: %@", responseObject);
//        
////        completeHandle(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];
    
    NSString* strUrl = [NSString stringWithFormat:@"%@%@",SERVER_JPUSH,@"PushExpert.php"];
    
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"getUrl = %@",strUrl);
    
    NSURL* url = [NSURL URLWithString:strUrl];
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:url
                                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                  timeoutInterval:60.0];
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    
    if (error == nil)
    {
        // Parse data here
        NSString* myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"myString = %@ ",myString);
    }
    else
        
    {
        
        NSLog(@"网络出错？");
        
        
    }
    
}

- (void)server_jpushDoctorGenerate
{
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:[NSString stringWithFormat:@"%@%@",SERVER_JPUSH,@"PushUser.php"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
//        
//        NSLog(@"JSON: %@", responseObject);
//        
//        //completeHandle(responseObject);
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        NSLog(@"Error: %@", error);
//        
//    }];

    NSString* strUrl = [NSString stringWithFormat:@"%@%@",SERVER_JPUSH,@"PushUser.php"];
    
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"getUrl = %@",strUrl);
    
    NSURL* url = [NSURL URLWithString:strUrl];
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:url
                                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                  timeoutInterval:60.0];
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    
    if (error == nil)
    {
        // Parse data here
        NSString* myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"myString = %@ ",myString);
    }
    else
        
    {
        
        NSLog(@"网络出错？");
        
        
    }

    
}


- (void)server_testJson
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; //很重要，去掉就容易遇到错误，暂时还未了解更加详细的原因
    //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager GET:[NSString stringWithFormat:@"http://192.168.1.23/2ti/json/biz/customer/reset_password?email=wuziqiu1986@outlook.com"] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        
        NSLog(@"server_testJson: %@", responseObject);
        
        //completeHandle(responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
    }];
    
}


- (NSDictionary*)server_BaseGet:(NSDictionary*)dic url:(NSString*)ctUrl
{
    NSString* strUrl = [NSString stringWithFormat:@"%@%@",SERVER_JPUSH,@"PushUser.php"];
    
    strUrl = [strUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"getUrl = %@",strUrl);
    
    NSURL* url = [NSURL URLWithString:strUrl];
    NSURLRequest * urlRequest = [[NSURLRequest alloc] initWithURL:url
                                                      cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                  timeoutInterval:60.0];
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:urlRequest
                                          returningResponse:&response
                                                      error:&error];
    
    
    if (error == nil)
    {
        // Parse data here
        NSString* myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"myString = %@ ",myString);
    }
    else
        
    {
        
        NSLog(@"网络出错？");
        

    }
    return nil;
}


- (NSDictionary*)server_BasePost:(NSMutableDictionary*)dic url:(NSString*)ctUrl
{

    //download from server
    NSString* strUrl = ctUrl;//[NSString stringWithFormat:@"%@/base/addAppointmentOrder?", SERVER];
    
    if(dic == nil)
        return nil;
    
    //download from server
    //NSString* strUrl = [NSString stringWithFormat:@"%@/base/addArchiveRecord", SERVER];
    
    
    NSString *BoundaryConstant = @"bP8bMGL3HEiJbMKsS289FSuSKw9Kq8iklhSPysQ";
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:strUrl]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    
    NSString *contentType = [[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",BoundaryConstant];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];


    
    for (NSString *key in [dic allKeys])
    {

        
        
        id value = dic[key];
        if (([value isKindOfClass:[NSString class]] && ((NSString*)value).length == 0) ||
            value == [NSNull null] )
        {
            continue;
        }
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", key] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"%@\r\n", value] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", BoundaryConstant] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    
    
    [request setHTTPBody:body];
    [request setHTTPMethod:@"POST"];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    
    NSURLResponse *response;
    NSError *error;
    
    NSLog(@"Post Request = %@",request);
    
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    
    
    
    if (error == nil)
    {
        // Parse data here
        NSString* myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        NSLog(@"myString = %@",myString);
        
        
        
        
        //debug
        //NSLog(@"server_addAppointmentOrder=> %@", myString);
        
        // parse
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        
        // parse the JSON string into an object - assuming json_string is a NSString of JSON data
        NSDictionary *object = [parser objectWithString:myString];
        
        // check result
        NSNumber* status = [object objectForKey:@"status"];
        
        
        
        if([status intValue] == 200)
        {
            return object;
        }
        else{
            
            
        }
        
    }
    else
    {
        

        
        
        
        
    }
    
    return nil;
}


- (void)setTags:(NSString *)tag
{
    
//    if ([tag isEqualToString:@"1"]) {
//        
//        tag = @"9";
//    }else{
//    
//        tag = @"10";
//    }

    [APService setTags:nil alias:tag callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}




@end
