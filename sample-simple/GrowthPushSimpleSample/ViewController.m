//
//  ViewController.m
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize eventNameTextField;
@synthesize eventValueTextField;
@synthesize tagNameTextField;
@synthesize tagValueTextField;

- (IBAction)eventSend:(id)sender {
    [EasyGrowthPush trackEvent:eventNameTextField.text value:eventValueTextField.text];
}

- (IBAction)tagSend:(id)sender {
    [EasyGrowthPush setTag:tagNameTextField.text value:tagValueTextField.text];
}

- (IBAction)requestDeviceTokenEvent:(id)sender {
    [EasyGrowthPush requestDeviceToken];
}

- (IBAction)setDeviceTagsEvent:(id)sender {
    [EasyGrowthPush setDeviceTags];
}

- (IBAction)clearBadgeEvent:(id)sender {
    [EasyGrowthPush clearBadge];
}

@end