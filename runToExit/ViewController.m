//
//  ViewController.m
//  runToExit
//
//  Created by Marcelo Sampaio on 8/24/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize settings,areaHeight,areaWidth;


#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Settings
    [self setUp];
    
    
}

#pragma mark - UI Setup
-(void)setUp {
    self.settings=[[Settings alloc]init];
    self.areaWidth=self.view.frame.size.width;
    self.areaHeight=self.view.frame.size.height/AREA_COUNT;
    
    float temp=0.00f;
    
    for (int i=0; i<AREA_COUNT; i++) {
        if (i==0) {
            [self addAreaWithIndex:i y:temp];
        } else {
            [self addAreaWithIndex:i y:temp];
        }
        temp=temp+self.areaHeight;
    }
    
}

-(void)addAreaWithIndex:(int)i y:(float)y {
    // add Area to UI
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.areaWidth, self.areaHeight)];
    imageView.tag=900;
    imageView.alpha=0.8f;
    imageView.image=[UIImage imageNamed:@"jungle"];

    [self.view addSubview:imageView];
    
    // add character to area
    [self addCharacterIndex:i yPosition:y];
    
}

-(void)addCharacterIndex:(int)i yPosition:(float)y {
    NSLog(@"## add Character in area %d  yPosition=%f",i,y);
    CGRect rect;
    UIImageView *imageView=[[UIImageView alloc]init];
    if (i==0) {
        rect=CGRectMake(0, y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"monkey_run_1"];
    }else if (i==1) {
        rect=CGRectMake(self.areaWidth-46.6, y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"croc_walk01"];
    }else if (i==2) {
        rect=CGRectMake(0, y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"monkey_walk_1"];
    }else {
        rect=CGRectMake(self.areaWidth-46.6, y+56+14, 46, 44);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"bear1"];
    }
    
    imageView.tag=1000;
    
    [self.view addSubview:imageView];
}


#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
