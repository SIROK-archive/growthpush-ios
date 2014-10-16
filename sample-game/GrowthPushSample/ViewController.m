//
//  ViewController.m
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"

static int playerSelect = -1;
static UIImage *img1;
static UIImage *img2;
static UIImage *img3;
static NSArray *imgs;

@interface ViewController ()

@end

@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    img1 = [UIImage imageNamed:@"Rock.png"];
    img2 = [UIImage imageNamed:@"Paper.png"];
    img3 = [UIImage imageNamed:@"Scissors.png"];
    imgs = [NSArray arrayWithObjects:img1, img2, img3, nil];
    self.enemySelectImage.animationImages = imgs;
    self.enemySelectImage.animationDuration = 0.4;
    [self.enemySelectImage startAnimating];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)rockSelect:(id)sender {
    playerSelect = 0;
}

- (IBAction)paperSelect:(id)sender {
    playerSelect = 1;
}

- (IBAction)scissorsSelect:(id)sender {
    playerSelect = 2;
}

- (IBAction)selectRPS:(id)sender {
    self.playerSelectImage.image = imgs[playerSelect];
    self.resultLabel.text = @"VS";
    [self.enemySelectImage startAnimating];
}

- (Result)resultsCall:(Call)playerCall
         computerCall:(Call)computerCall {
    static Result results[3][3] = {{Tie, Loss, Win}, {Win, Tie, Loss}, {Loss, Win, Tie}};
    return results[playerCall][computerCall];
}

- (IBAction)playGame:(id)sender {
    [self.enemySelectImage stopAnimating];
    if( playerSelect != -1 ) {
        int enemySelect = rand() % 3;
        Result result = [self resultsCall:playerSelect
                             computerCall:enemySelect];
        switch (result) {
            case Win:
                self.resultLabel.text = @"勝ち";
                break;
            case Loss:
                self.resultLabel.text = @"負け";
                break;
            case Tie:
                self.resultLabel.text = @"引き分け";
                break;
            default:
                break;
        }
        self.enemySelectImage.image = imgs[enemySelect];
    }
}

@end
