//
//  ViewController.m
//  GrowthPushSample
//
//  Created by Kataoka Naoyuki on 2014/04/22.
//  Copyright (c) 2014年 SIROK, Inc. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSUInteger, playerSelect) {
    selectNone = -1,
    selectRock = 0,
    selectPaper = 1,
    selectScissors = 2,
    NumberOFSelect = 3
};
static NSInteger nPlayerSelect = -1;
static NSInteger enemySelect = -1;
static NSArray *imgs = nil;

@interface ViewController ()
@end

@implementation ViewController
@synthesize segmentTag;

- (void) viewDidLoad {
    [super viewDidLoad];
    imgs = [NSArray arrayWithObjects:[UIImage imageNamed:@"Rock.png"],
                                    [UIImage imageNamed:@"Paper.png"],
                                    [UIImage imageNamed:@"Scissors.png"], nil];
    self.enemySelectImage.animationImages = imgs;
    self.enemySelectImage.animationDuration = 0.4;
    [self.enemySelectImage startAnimating];
}

- (NSString *)resultsCall:(NSInteger)playerCall computerCall:(NSInteger)computerCall {
    static NSString *results[3][3] = {{@"tie", @"loss", @"win"},{@"win", @"tie", @"loss"},{@"loss", @"win", @"tie"}};
    return results[playerCall][computerCall];
}

- (IBAction)selectRPS:(id)sender {
    nPlayerSelect = [sender tag];
    self.playerSelectImage.image = imgs[nPlayerSelect];
    self.resultLabel.text = @"VS";
    [self.enemySelectImage startAnimating];
}

- (IBAction)playGame:(id)sender {
    [self.enemySelectImage stopAnimating];
    if( nPlayerSelect == selectNone )
        return;
    
    enemySelect = rand() % NumberOFSelect;
    self.enemySelectImage.image = imgs[enemySelect];
    self.resultLabel.text = [self resultsCall:nPlayerSelect computerCall:enemySelect];
    
    // Event, Tag Post
    [EasyGrowthPush trackEvent:@"GameResult" value:self.resultLabel.text];
    [EasyGrowthPush setTag:@"Gender" value:[segmentTag titleForSegmentAtIndex:segmentTag.selectedSegmentIndex]];
}

@end
