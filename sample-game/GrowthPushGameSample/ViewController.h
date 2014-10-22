//
//  ViewController.h
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)selectRPS:(id)sender;
- (IBAction)playGame:(id)sender;

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentTag;
@property (strong, nonatomic) IBOutlet UIImageView *playerSelectImage;
@property (strong, nonatomic) IBOutlet UIImageView *enemySelectImage;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end
