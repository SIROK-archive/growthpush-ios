//
//  ViewController.h
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    Rock = 0, Paper = 1, Scissors = 2
} Call;

typedef enum {
    Win = 0, Loss = 1, Tie = 2
} Result;

@interface ViewController : UIViewController

- (IBAction)rockSelect:(id)sender;
- (IBAction)paperSelect:(id)sender;
- (IBAction)scissorsSelect:(id)sender;
- (IBAction)selectRPS:(id)sender;
- (IBAction)playGame:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *playerSelectImage;
@property (strong, nonatomic) IBOutlet UIImageView *enemySelectImage;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

@end
