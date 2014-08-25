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
@synthesize character,area0Tag,area0Timer,area1Tag,area1Timer,area2Tag,area2Timer,area3Tag,area3Timer;
@synthesize area0Characters,area1Characters,area2Characters,area3Characters;
@synthesize area0Images,area1Images,area2Images,area3Images;
@synthesize area0ImageSequenceNumber,area1ImageSequenceNumber,area2ImageSequenceNumber,area3ImageSequenceNumber;



#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Settings
    [self setUp];
    
    
}

#pragma mark - UI Setup
-(void)setUp {

    // Settings
    self.settings=[[Settings alloc]init];
    self.areaWidth=self.view.frame.size.width;
    self.areaHeight=self.view.frame.size.height/AREA_COUNT;

    // set up images for animations
    [self setUpImagesForAnimations];
    
    // tags
    self.area0Tag=1000;
    self.area1Tag=2000;
    self.area2Tag=3000;
    self.area3Tag=4000;
    
    // Image Sequence Numbers
    self.area0ImageSequenceNumber=0;
    self.area1ImageSequenceNumber=0;
    self.area2ImageSequenceNumber=0;
    self.area3ImageSequenceNumber=0;
    
    // Characters in the UI
    self.area0Characters=[[NSMutableArray alloc]init];
    self.area1Characters=[[NSMutableArray alloc]init];
    self.area2Characters=[[NSMutableArray alloc]init];
    self.area3Characters=[[NSMutableArray alloc]init];

    // define and add areas (rows) and characters into UI
    for (int i=0; i<AREA_COUNT; i++) {
        [self addAreaAtIndex:i yPosition:self.areaHeight*i];
        [self addCharacterAtIndex:i yPosition:self.areaHeight*i];
    }
    
    // Start timers
    self.area0Timer=[NSTimer scheduledTimerWithTimeInterval:0.02f target:self selector:@selector(animateRow0) userInfo:nil repeats:YES];

}

-(void)setUpImagesForAnimations {
    // Images for animation
    self.area0Images=[[NSMutableArray alloc]init];
    self.area1Images=[[NSMutableArray alloc]init];
    self.area2Images=[[NSMutableArray alloc]init];
    self.area3Images=[[NSMutableArray alloc]init];
    // Area 0
    [self.area0Images addObject:@"monkey_run_0"];
    [self.area0Images addObject:@"monkey_run_1"];
    [self.area0Images addObject:@"monkey_run_2"];
    [self.area0Images addObject:@"monkey_run_3"];
    [self.area0Images addObject:@"monkey_run_4"];
    [self.area0Images addObject:@"monkey_run_5"];
    [self.area0Images addObject:@"monkey_run_6"];
    [self.area0Images addObject:@"monkey_run_7"];
    
}

-(void)addAreaAtIndex:(int)i yPosition:(float)y {
    // add Area to UI
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, y, self.areaWidth, self.areaHeight)];
    imageView.tag=50;
    imageView.alpha=0.8f;
    imageView.image=[UIImage imageNamed:@"jungle"];

    [self.view addSubview:imageView];
    
}

-(void)addCharacterAtIndex:(int)i yPosition:(float)y {

    self.character=[[Character alloc]init];

    CGRect rect;
    UIImageView *imageView=[[UIImageView alloc]init];
    NSString *imageName=@"";
    if (i==0) {
        
        CGPoint point=CGPointMake(0, y+56+4);
        CGSize size=CGSizeMake(46.6, 56);
        rect = CGRectMake(point.x, point.y, size.width, size.height);
        
        imageName=[self.area0Images objectAtIndex:self.area0ImageSequenceNumber=0];
        
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:imageName];
        imageView.tag=self.area0Tag;
        
        // create character object
        self.character=[[Character alloc]initWithRectangle:rect imageName:imageName tag:self.area0Tag];
        [area0Characters addObject:self.character];
        
        // increment tag control
        self.area0Tag++;
        // increment Image Sequence Number Control
        self.area0ImageSequenceNumber++;
        if (self.area0ImageSequenceNumber>7) {
            self.area0ImageSequenceNumber=0;
        }
        
    }else if (i==1) {
        rect=CGRectMake(self.areaWidth-46.6, y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"croc_walk01"];
        imageView.tag=self.area1Tag;
        self.area1Tag++;
    }else if (i==2) {
        rect=CGRectMake(0, y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"monkey_walk_1"];
        imageView.tag=self.area2Tag;
        self.area2Tag++;
    }else {
        rect=CGRectMake(self.areaWidth-46.6, y+56+14, 46.6, 44);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"bear1"];
        imageView.tag=self.area3Tag;
        self.area3Tag++;
    }

    [self.view addSubview:imageView];
    NSLog(@"added Character to UI   i=%d    tag=%d",i,imageView.tag);
}

#pragma mark - Timer Methods
-(void)animateRow0 {

    NSMutableArray *deleted=[[NSMutableArray alloc]init];
    Character *characterDeleted=[[Character alloc]init];
    
    // Remove character from area 0
    for (UIView *view in self.view.subviews) {
        if (view.tag>=1000 && view.tag<=1999) {
            
            characterDeleted=[[Character alloc]initWithRectangle:view.frame imageName:@"name" tag:view.tag];
            [deleted addObject:characterDeleted];
            
            // remove character in area 0
            [view removeFromSuperview];
        }
    }
    
    // Add character in a new point with a new animation image
    for (Character *objDeleted in deleted) {
        NSLog(@"point X=%f Y=%f     size Width=%f Height%f",objDeleted.rectangle.origin.x,objDeleted.rectangle.origin.y,objDeleted.rectangle.size.width,objDeleted.rectangle.size.height);
    }
    
    
}


#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
