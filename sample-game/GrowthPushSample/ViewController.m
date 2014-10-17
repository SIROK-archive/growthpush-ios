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

- (NSString *)resultsCall:(int)playerCall
             computerCall:(int)computerCall {
    NSString *results[3][3] = {{@"引き分け", @"負け", @"勝ち"},{@"勝ち", @"引き分け", @"負け"},{@"負け", @"勝ち", @"引き分け"}};
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
        self.resultLabel.text = [self resultsCall:playerSelect
                                     computerCall:enemySelect];
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
