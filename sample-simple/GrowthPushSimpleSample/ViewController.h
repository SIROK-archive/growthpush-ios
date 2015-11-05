//
//  ViewController.h
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *eventNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *eventValueTextField;
@property (strong, nonatomic) IBOutlet UITextField *tagNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *tagValueTextField;

- (IBAction)eventSend:(id)sender;
- (IBAction)tagSend:(id)sender;

- (IBAction)requestDeviceTokenEvent:(id)sender;
- (IBAction)setDeviceTagsEvent:(id)sender;
- (IBAction)clearBadgeEvent:(id)sender;

@end