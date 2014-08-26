//
//  ViewController.h
//  runToExit
//
//  Created by Marcelo Sampaio on 8/24/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "Character.h"

@interface ViewController : UIViewController

// Objects
@property (nonatomic,strong) Settings *settings;
@property (nonatomic,strong) Character *character;


// area (row) size
@property float areaWidth;
@property float areaHeight;

// area 0 control
@property (nonatomic,strong) NSTimer *area0GeneratorTimer;
@property (nonatomic,strong) NSTimer *area0Timer;
@property int area0Tag;
@property int area0ImageSequenceNumber;
// area 1 control
@property (nonatomic,strong) NSTimer *area1GeneratorTimer;
@property (nonatomic,strong) NSTimer *area1Timer;
@property int area1Tag;
@property int area1ImageSequenceNumber;
// area 2 control
@property (nonatomic,strong) NSTimer *area2GeneratorTimer;
@property (nonatomic,strong) NSTimer *area2Timer;
@property int area2Tag;
@property int area2ImageSequenceNumber;
// area 3 control
@property (nonatomic,strong) NSTimer *area3GeneratorTimer;
@property (nonatomic,strong) NSTimer *area3Timer;
@property int area3Tag;
@property int area3ImageSequenceNumber;

// Character in UI
@property (nonatomic,strong) NSMutableArray *area0Characters;
@property (nonatomic,strong) NSMutableArray *area1Characters;
@property (nonatomic,strong) NSMutableArray *area2Characters;
// Characters images for animation
@property (nonatomic,strong) NSMutableArray *area0Images;
@property (nonatomic,strong) NSMutableArray *area1Images;
@property (nonatomic,strong) NSMutableArray *area2Images;
@property (nonatomic,strong) NSMutableArray *area3Images;



@end
