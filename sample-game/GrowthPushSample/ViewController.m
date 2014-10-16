//
//  ViewController.m
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"

static NSString *playerSelect = nil;
static NSString *enemySelect = nil;

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    UIImage *img1 = [UIImage imageNamed:@"Rock.png"];
    UIImage *img2 = [UIImage imageNamed:@"Paper.png"];
    UIImage *img3 = [UIImage imageNamed:@"Scissors.png"];
    NSArray *imgs = [NSArray arrayWithObjects:img1, img2, img3, nil];
    self.enemySelectImage.animationImages = imgs;
    self.enemySelectImage.animationDuration = 0.4;
    [self.enemySelectImage startAnimating];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rockSelect:(id)sender {
    playerSelect = @"Rock";
}

- (IBAction)paperSelect:(id)sender {
    playerSelect = @"Paper";
}

- (IBAction)scissorsSelect:(id)sender {
    playerSelect = @"Scissors";
}

- (IBAction)selectRPS:(id)sender {
    self.playerSelectImage.image = [UIImage imageNamed:playerSelect];
    self.resultLabel.text = @"VS";
    [self.enemySelectImage startAnimating];
}

- (IBAction)playGame:(id)sender {
    [self.enemySelectImage stopAnimating];
    if( playerSelect != nil ) {
        int enemyRandom = rand() % (3);
        switch (enemyRandom) {
            case 0:
                enemySelect = @"Rock";
                break;
            case 1:
                enemySelect = @"Paper";
                break;
            case 2:
                enemySelect = @"Scissors";
                break;
            default:
                break;
        }
        self.enemySelectImage.image = [UIImage imageNamed:enemySelect];
        if(playerSelect == enemySelect) {
            //Tie
            self.resultLabel.text = @"引き分け";
        }else{
            if([playerSelect isEqual: @"Rock"] && [enemySelect isEqual:@"Scissors"]) {
                //Win
                self.resultLabel.text = @"勝ち";
            }else if([playerSelect isEqual: @"Paper"] && [enemySelect isEqual:@"Rock"]) {
                //Win
                self.resultLabel.text = @"勝ち";
            }else if([playerSelect isEqual: @"Scissors"] && [enemySelect isEqual:@"Paper"]) {
                //Win
                self.resultLabel.text = @"勝ち";
            }else{
                //make
                self.resultLabel.text = @"負け";
            }
        }
    }
}

@end
