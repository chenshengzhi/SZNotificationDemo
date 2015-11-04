//
//  AppDelegate.m
//  SZNotificationDemo
//
//  Created by 陈圣治 on 15/11/4.
//  Copyright © 2015年 shengzhichen. All rights reserved.
//

#import "AppDelegate.h"
#import "SZNotificationLogFormatter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupDDLog];
    
    [self setupNotificationSettings];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    DDLogWarn(@"%@", notificationSettings);
}

#pragma mark - 本地通知委托 -
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler {
    DDLogWarn(@"%@---------%@",identifier, notification);
    completionHandler();
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)())completionHandler {
    DDLogWarn(@"%@\n---------%@\n---------%@",identifier, notification, responseInfo);
    completionHandler();
}

#pragma mark - 远程通知委托 -
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler {
    DDLogWarn(@"%@---------%@",identifier, userInfo);
    completionHandler();
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(nullable NSString *)identifier forRemoteNotification:(nonnull NSDictionary *)userInfo withResponseInfo:(nonnull NSDictionary *)responseInfo completionHandler:(nonnull void (^)())completionHandler {
    DDLogWarn(@"%@\n---------%@\n---------%@",identifier, userInfo, responseInfo);
    completionHandler();
}

#pragma mark - 配置 -
- (void)setupDDLog {
    SZNotificationLogFormatter *formarter = [[SZNotificationLogFormatter alloc] init];
    [DDTTYLogger sharedInstance].logFormatter = formarter;
    [DDASLLogger sharedInstance].logFormatter = formarter;
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
}

- (void)setupNotificationSettings {
    //接受按钮
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"acceptAction";
    acceptAction.title = @"接受";
    acceptAction.activationMode = UIUserNotificationActivationModeForeground;
    //拒绝按钮
    UIMutableUserNotificationAction *rejectAction = [[UIMutableUserNotificationAction alloc] init];
    rejectAction.identifier = @"rejectAction";
    rejectAction.title = @"拒绝";
    rejectAction.activationMode = UIUserNotificationActivationModeBackground;
    rejectAction.authenticationRequired = YES;
    rejectAction.destructive = YES;
    //输入框
    UIMutableUserNotificationAction *inputButton = [[UIMutableUserNotificationAction alloc] init];
    inputButton.identifier = @"input";
    inputButton.title = @"回复";
    inputButton.behavior = UIUserNotificationActionBehaviorTextInput;
    inputButton.activationMode = UIUserNotificationActivationModeBackground;
    inputButton.authenticationRequired = YES;
    
    UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
    categorys.identifier = @"alert";
    NSArray *actions = @[
//                          acceptAction,
//                          rejectAction,
                         inputButton
                         ];
    [categorys setActions:actions forContext:UIUserNotificationActionContextMinimal];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:[NSSet setWithObjects:categorys, nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}
@end
