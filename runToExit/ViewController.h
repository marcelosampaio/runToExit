//
//  ViewController.h
//  runToExit
//
//  Created by Marcelo Sampaio on 8/24/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) Settings *settings;

// area (row) size
@property float areaWidth;
@property float areaHeight;


@end
