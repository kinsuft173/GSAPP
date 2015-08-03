//
//  AppDelegate.m
//  GSAPP
//
//  Created by 胡昆1 on 6/4/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "AppDelegate.h"
#import "APService.h"
#import "NetworkManager.h"
#import "APIKey.h"
#import <MAMapKit/MAMapKit.h>
#import "HKMapManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "UserDataManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)configureAPIKey
{
    NSLog(@"[NSBundle mainBundle].bundleIdentifier = %@",[NSBundle mainBundle].bundleIdentifier);
    
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
    
//    [WXApi registerApp:APP_ID withDescription:@"demo 2.0"];
    
}


- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configureAPIKey];
    [HKMapManager shareMgr];
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidSetup:)            name:kJPFNetworkDidSetupNotification     object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidClose:)            name:kJPFNetworkDidCloseNotification     object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidRegister:)         name:kJPFNetworkDidRegisterNotification  object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidLogin:)            name:kJPFNetworkDidLoginNotification     object:nil];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:)   name:kJPFNetworkDidReceiveMessageNotification object:nil];
        [defaultCenter addObserver:self selector:@selector(networkDidError:)   name:kJPFServiceErrorNotification object:nil];
    
//    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
//                                                   UIRemoteNotificationTypeSound |
//                                                   UIRemoteNotificationTypeAlert)
//                                       categories:nil];
    

    // Required
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
#else
    //categories 必须为nil
    [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                   UIRemoteNotificationTypeSound |
                                                   UIRemoteNotificationTypeAlert)
                                       categories:nil];
#endif
    // Required
    
    [APService setupWithOption:launchOptions];
//    [[NetworkManager shareMgr] server_BaseGet:nil url:nil];
    
//    [[NetworkManager shareMgr] server_testJson];
    
//    [[NetworkManager shareMgr] server_createUserWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_fetchUserWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_updateUserWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_fetchAdvertisementWithDic:nil completeHandle:^(NSDictionary * dic) {
//            ;
//        }];
    
//    [[NetworkManager shareMgr] server_fetchDoctorsWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_createConsultWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];

//    [[NetworkManager shareMgr] server_createOrderWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_fetchOrderWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_updateOrderWithDic:@{@"id":@185,@"status":@8} completeHandle:^(NSDictionary * dic) {
//            ;
//        }];
//
//            [[NetworkManager shareMgr] server_fetchConsultWithDic:nil completeHandle:^(NSDictionary * dic) {
//                ;
//            }];
    
//        [[NetworkManager shareMgr] server_fetchAnamnesisWithDic:nil completeHandle:^(NSDictionary * dic) {
//            ;
//        }];
    
//    [[NetworkManager shareMgr] server_fetchCategoryWithDic:nil completeHandle:^(NSDictionary * dic) {
//            ;
//    }];
    
    
//    [[NetworkManager shareMgr] server_fetchCityWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_createEvaluateWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_fetchEvaluateWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_fetchExpertiseWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_createFavoritesWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
//    [[NetworkManager shareMgr] server_fetchRepineWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];

//    [[NetworkManager shareMgr] server_fetchSymptomWithDic:nil completeHandle:^(NSDictionary * dic) {
//        ;
//    }];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    //    [APService stopLogPageView:@"aa"];
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an
    // incoming phone call or SMS message) or when the user quits the application
    // and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down
    // OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate
    // timers, and store enough application state information to restore your
    // application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called
    // instead of applicationWillTerminate: when the user quits.
    
    //[[UIApplication sharedApplication] setApplicationIconBadgeNumber:1];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the
    // application was inactive. If the application was previously in the
    // background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if
    // appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {

    NSLog(@"%@", [NSString stringWithFormat:@"Device Token: %@", deviceToken]);
    [APService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [APService handleRemoteNotification:userInfo];
    NSLog(@"收到通知:%@", [self logDic:userInfo]);
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil];

}

//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo
//fetchCompletionHandler:
//(void (^)(UIBackgroundFetchResult))completionHandler {
//    [APService handleRemoteNotification:userInfo];
//    NSLog(@"收到通知:%@", [self logDic:userInfo]);
//    
//    completionHandler(UIBackgroundFetchResultNewData);
//}

- (void)application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [APService showLocalNotificationAtFront:notification identifierKey:nil];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}


- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}


//KJP
- (void)networkDidSetup:(NSNotification *)notification
{

    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"networkDidSetup%@", userInfo);
}


- (void)networkDidClose:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"networkDidClose为%@", userInfo);
    
}
- (void)networkDidRegister:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"networkDidRegister%@", userInfo);
    
}
- (void)networkDidLogin:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"networkDidLogin为%@", userInfo);
    
}

- (void)networkDidError:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"networkDidError%@", userInfo);
    
}

-(void)messegeReceived:(NSDictionary*)userInfo
{
    NSLog(@"messegeReceived = %@",userInfo);
    
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter postNotificationName:@"sdsd" object:nil userInfo:userInfo];
    
}

- (void)networkDidReceiveMessage:(NSNotification *)notification
{
    NSDictionary * userInfo = [notification userInfo];
    
    NSLog(@"获得的用户数据为%@", userInfo);
    
    if ([[userInfo objectForKey:@"content"] isEqualToString:@"user"]) {
        
        if ([[UserDataManager shareManager].userId isEqualToString:@"1"]) {
            
            [self performSelector:@selector(goPushNotify) withObject:nil afterDelay:5];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil];
 
            
        }
        
    }else{
    
        if ([[UserDataManager shareManager].userId isEqualToString:@"2"]) {
            
            [self performSelector:@selector(goPushNotify) withObject:nil afterDelay:5];
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil];
            
            
        }
    
    }

}

- (void)goPushNotify
{

            [[NSNotificationCenter defaultCenter] postNotificationName:@"notify" object:nil];

}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    NSLog(@"url.host = %@",url.host);
    
    
    if ([url.host isEqualToString:@"safepay"]) {
        

        
        
        if ([url.host isEqualToString:@"safepay"]) {
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                      standbyCallback:^(NSDictionary *resultDic) {
                                                          NSLog(@"result1 = %@",resultDic);
                                                      }];
            
        }
        
        
        return YES;
        
    }
    
    
    return YES;
}







@end
