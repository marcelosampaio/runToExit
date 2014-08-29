//
//  IntroViewController.h
//  runToExit
//
//  Created by Marcelo Sampaio on 8/28/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface IntroViewController : UIViewController {
    SystemSoundID soundId;
}

// backgorund music
@property (strong,nonatomic) AVAudioPlayer *backgroundMusicPlayer1;
@property (strong,nonatomic) AVAudioPlayer *backgroundMusicPlayer2;
@property (strong,nonatomic) AVAudioPlayer *backgroundMusicPlayer3;


@end
