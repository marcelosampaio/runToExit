//
//  IntroViewController.m
//  runToExit
//
//  Created by Marcelo Sampaio on 8/28/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "IntroViewController.h"

@interface IntroViewController ()

@end

@implementation IntroViewController

@synthesize backgroundMusicPlayer1,backgroundMusicPlayer2,backgroundMusicPlayer3;

#pragma mark UIView Life Cycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Start Game SoundTrack
    [self playRainForest];
    [self playCongoDrums];
    [self playElephant];

    
    // Disable UINAvigation Title Bar
    [self.navigationController.navigationBar setHidden:YES];
}


#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden {
    return YES;
}

#pragma mark - Backgroung Sound
-(void)playRainForest {
    // configure Sound Track
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"rainForest" withExtension:@"mp3"];
    
    
    self.backgroundMusicPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer1.numberOfLoops = -1;
    [self.backgroundMusicPlayer1 prepareToPlay];
    [self.backgroundMusicPlayer1 play];
}
-(void)playCongoDrums {
    // configure Sound Track
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"congoDrummer" withExtension:@"mp3"];
    
    
    self.backgroundMusicPlayer2 = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer2.numberOfLoops = -1;
    [self.backgroundMusicPlayer2 prepareToPlay];
    [self.backgroundMusicPlayer2 play];
}

-(void)playElephant {
    NSError *error;
    NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"elephant" withExtension:@"mp3"];
    
    
    self.backgroundMusicPlayer3 = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:&error];
    self.backgroundMusicPlayer3.numberOfLoops = 0;
    [self.backgroundMusicPlayer3 prepareToPlay];
    [self.backgroundMusicPlayer3 play];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"startGame"]) {
        [self playElephant];
    }
}

@end
