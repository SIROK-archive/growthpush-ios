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

- (void) viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void) viewDidUnload {
    [self setEventNameTextField:nil];
    [self setEventValueTextField:nil];
    [self setTagNameTextField:nil];
    [self setTagValueTextField:nil];
    [super viewDidUnload];
}
- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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