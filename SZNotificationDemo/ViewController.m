//
//  ViewController.m
//  SZNotificationDemo
//
//  Created by 陈圣治 on 15/11/4.
//  Copyright © 2015年 shengzhichen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonTapHandle:(id)sender {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:3];
    notification.alertBody = @"测试推送的快捷回复";
    notification.category = @"alert";
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
