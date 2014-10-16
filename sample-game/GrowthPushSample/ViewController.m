//
//  ViewController.m
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"

static int playerSelect = -1;
static int enemySelect = -1;
static NSArray *imgs = nil;

@interface ViewController ()
@end

@implementation ViewController
@synthesize segmentTag;

- (void) viewDidLoad {
    [super viewDidLoad];
    [EasyGrowthPush setDeviceTags];
    imgs = [NSArray arrayWithObjects:[UIImage imageNamed:@"Rock.png"],
                                    [UIImage imageNamed:@"Paper.png"],
                                    [UIImage imageNamed:@"Scissors.png"], nil];
    self.enemySelectImage.animationImages = imgs;
    self.enemySelectImage.animationDuration = 0.4;
    [self.enemySelectImage startAnimating];
}

- (void) viewDidUnload {
    imgs = nil;
    [super viewDidUnload];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (Result)resultsCall:(Call)playerCall
         computerCall:(Call)computerCall {
    static Result results[3][3] = {{Tie, Loss, Win}, {Win, Tie, Loss}, {Loss, Win, Tie}};
    return results[playerCall][computerCall];
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

- (IBAction)playGame:(id)sender {
    [self.enemySelectImage stopAnimating];
    if( playerSelect != -1 ) {
        enemySelect = rand() % 3;
        self.enemySelectImage.image = imgs[enemySelect];
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
        
        /*
         * Event Post
         */
        [EasyGrowthPush trackEvent:@"GameResult" value:self.resultLabel.text];
        
        /*
         * Tag Post
         */
        [EasyGrowthPush setTag:@"Gender" value:[segmentTag titleForSegmentAtIndex:segmentTag.selectedSegmentIndex]];
    }
}

@end
