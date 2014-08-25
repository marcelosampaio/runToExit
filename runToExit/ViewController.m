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
@synthesize character,area0Tag,area0Timer;


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
    
    // define and add areas (rows) to UI
    float y=0.00f;
    for (int i=0; i<AREA_COUNT; i++) {
        [self addAreaWithIndex:i y:y];
        [self addCharacterIndex:i yPosition:self.areaHeight*i];
        y=y+self.areaHeight;
    }
}



-(void)addAreaWithIndex:(int)i y:(float)y {
    // add Area to UI
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.areaWidth, self.areaHeight)];
    imageView.tag=900;
    imageView.alpha=0.8f;
    imageView.image=[UIImage imageNamed:@"jungle"];

    [self.view addSubview:imageView];
//    
//    // add character to area
//    [self addCharacterIndex:i yPosition:y];
    
}

-(void)addCharacterIndex:(int)i yPosition:(float)y {

    self.character=[[Character alloc]init];
    
    CGRect rect;
    UIImageView *imageView=[[UIImageView alloc]init];
    if (i==0) {
//        rect=CGRectMake(0, y+56+4, 46.6, 56);
        CGPoint point=CGPointMake(0, y+56+4);
        CGSize size=CGSizeMake(46.6, 56);
        rect = CGRectMake(point.x, point.y, size.width, size.height);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"monkey_run_1"];
        imageView.tag=self.area0Tag;
        self.area0Tag++;
        
    }else if (i==1) {
        rect=CGRectMake(self.areaWidth-46.6, y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"croc_walk01"];
    }else if (i==2) {
        rect=CGRectMake(0, y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"monkey_walk_1"];
    }else {
        rect=CGRectMake(self.areaWidth-46.6, y+56+14, 46.6, 44);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"bear1"];
    }

    [self.view addSubview:imageView];
}

#pragma mark - Timer Methods
-(void)animateRow0 {
    NSLog(@"animating row 0.");
}

#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
