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
@property (nonatomic,strong) NSTimer *area0Timer;
@property int area0Tag;


@end
