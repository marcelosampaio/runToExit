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
@synthesize area0Images,area1Images,area2Images,area3Images;
@synthesize area0ImageSequenceNumber,area1ImageSequenceNumber,area2ImageSequenceNumber,area3ImageSequenceNumber;
@synthesize area0Characters,area2Characters;
@synthesize area0GeneratorTimer,area2GeneratorTimer;


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
    
    self.area0Characters=[[NSMutableArray alloc]init];
    self.area2Characters=[[NSMutableArray alloc]init];
    
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

    // define and add areas (rows) and characters into UI
    for (int i=0; i<AREA_COUNT; i++) {
        CGPoint position=CGPointMake(0, self.areaHeight*i);
        int tag;
        if (i==0) {
            tag=self.area0Tag;
        } else if (i==1) {
            tag=self.area1Tag;
        } else if (i==2) {
            tag=self.area2Tag;
        } else {
            tag=self.area3Tag;
        }
        [self addAreaAtIndex:i position:position];
        [self addCharacterAtIndex:i position:CGPointMake(0, position.y) tag:tag];
    }
    
    // Start timers
    // Area 0
    self.area0Timer=[NSTimer scheduledTimerWithTimeInterval:0.04f target:self selector:@selector(animateRow0) userInfo:nil repeats:YES];
    self.area0GeneratorTimer=[NSTimer scheduledTimerWithTimeInterval:2.9f target:self selector:@selector(auto0Generator) userInfo:nil repeats:YES];
    // Area 1
    
    // Area 2
    self.area2Timer=[NSTimer scheduledTimerWithTimeInterval:0.075f target:self selector:@selector(animateRow2) userInfo:nil repeats:YES];
    self.area2GeneratorTimer=[NSTimer scheduledTimerWithTimeInterval:3.6f target:self selector:@selector(auto2Generator) userInfo:nil repeats:YES];
    
    // Area 3
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
    // Area 1
    
    // Area 2
    [self.area2Images addObject:@"monkey_run_0"];
    [self.area2Images addObject:@"monkey_run_1"];
    [self.area2Images addObject:@"monkey_run_2"];
    [self.area2Images addObject:@"monkey_run_3"];
    [self.area2Images addObject:@"monkey_run_4"];
    [self.area2Images addObject:@"monkey_run_5"];
    [self.area2Images addObject:@"monkey_run_6"];
    [self.area2Images addObject:@"monkey_run_7"];
    
    
}

-(void)addAreaAtIndex:(int)i position:(CGPoint)position {
    // add Area to UI
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(position.x, position.y, self.areaWidth, self.areaHeight)];
    imageView.tag=50;
    imageView.alpha=0.8f;
    imageView.image=[UIImage imageNamed:@"jungle"];

    [self.view addSubview:imageView];
    
}

-(void)addCharacterAtIndex:(int)i position:(CGPoint)position tag:(int)tag {

    self.character=[[Character alloc]init];


    CGRect rect;
    UIImageView *imageView=[[UIImageView alloc]init];
    NSString *imageName=@"";
    if (i==0) {
        
        CGPoint point=CGPointMake(position.x, position.y+56+4);
        CGSize size=CGSizeMake(46.6, 56);
        rect = CGRectMake(point.x, point.y, size.width, size.height);
        
        imageName=[self.area0Images objectAtIndex:self.area0ImageSequenceNumber];
        
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:imageName];
        imageView.tag=tag;  // self.area0Tag;
        
        Character *objCharacter=[[Character alloc]initWithRectangle:imageView.frame imageName:imageName tag:imageView.tag];
        [self.area0Characters addObject:objCharacter];
        
        // increment Image Sequence Number Control
        self.area0ImageSequenceNumber++;
        if (self.area0ImageSequenceNumber>self.area0Images.count-1) {
            self.area0ImageSequenceNumber=0;
        }
        
    }else if (i==1) {
        rect=CGRectMake(self.areaWidth-46.6, position.y+56+4, 46.6, 56);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"croc_walk01"];
        imageView.tag=self.area1Tag;
        self.area1Tag++;
    }else if (i==2) {
//        rect=CGRectMake(position.x, position.y+56+4, 46.6, 56);
        CGPoint point=CGPointMake(position.x, position.y+56+4);
        CGSize size=CGSizeMake(46.6, 56);
        rect = CGRectMake(point.x, point.y, size.width, size.height);
        
        imageName=[self.area2Images objectAtIndex:self.area2ImageSequenceNumber];
        
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:imageName];
        imageView.tag=tag;  // self.area0Tag;
        
        Character *objCharacter=[[Character alloc]initWithRectangle:imageView.frame imageName:imageName tag:imageView.tag];
        [self.area2Characters addObject:objCharacter];
        
        // increment Image Sequence Number Control
        self.area2ImageSequenceNumber++;
        if (self.area2ImageSequenceNumber>self.area2Images.count-1) {
            self.area2ImageSequenceNumber=0;
        }

    }else {
        rect=CGRectMake(self.areaWidth-46.6, position.y+56+14, 46.6, 44);
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:@"bear1"];
        imageView.tag=self.area3Tag;
        self.area3Tag++;
    }

    [self.view addSubview:imageView];

}

#pragma mark - Timer Methods
-(void)animateRow0 {

    NSMutableArray *deleted=[[NSMutableArray alloc]init];
    Character *characterDeleted=[[Character alloc]init];
    NSString *imageName=[self.area0Images objectAtIndex:self.area0ImageSequenceNumber];
//
    // Remove character from area 0
    for (UIView *view in self.view.subviews) {
        if (view.tag>=1000 && view.tag<=1999) {

            if (view.center.x<=self.areaWidth+25) {
                characterDeleted=[[Character alloc]initWithRectangle:view.frame imageName:imageName tag:view.tag];
                [deleted addObject:characterDeleted];
            }
            // remove character in area 0
            [view removeFromSuperview];
    
        }
    }
    
    // Add character in a new point with a new animation image
    for (Character *objDeleted in deleted) {

        NSLog(@"point X=%f Y=%f     size Width=%f Height%f  image=%@",objDeleted.rectangle.origin.x,objDeleted.rectangle.origin.y,objDeleted.rectangle.size.width,objDeleted.rectangle.size.height,objDeleted.imageName);
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:objDeleted.rectangle];
        imageView.tag=objDeleted.tag;
        imageView.image=[UIImage imageNamed:objDeleted.imageName];
        
        
        CGPoint newCenter=CGPointMake(objDeleted.rectangle.origin.x+2.20f,self.areaHeight*0);
        imageView.center=newCenter;

        
        [self addCharacterAtIndex:0 position:newCenter tag:objDeleted.tag];
        
        
    }
    // remove all objects from deleted
    [deleted removeAllObjects];
    
    
}


// Animate row 2
-(void)animateRow2 {
    
    NSMutableArray *deleted=[[NSMutableArray alloc]init];
    Character *characterDeleted=[[Character alloc]init];
    NSString *imageName=[self.area2Images objectAtIndex:self.area2ImageSequenceNumber];
    //
    // Remove character from area 2
    for (UIView *view in self.view.subviews) {
        if (view.tag>=3000 && view.tag<=3999) {
            
            if (view.center.x<=self.areaWidth+25) {
                characterDeleted=[[Character alloc]initWithRectangle:view.frame imageName:imageName tag:view.tag];
                [deleted addObject:characterDeleted];
            }
            // remove character in area 2
            [view removeFromSuperview];
            
        }
    }
    
    // Add character in a new point with a new animation image
    for (Character *objDeleted in deleted) {
        
        NSLog(@"(2) point X=%f Y=%f     size Width=%f Height%f  image=%@",objDeleted.rectangle.origin.x,objDeleted.rectangle.origin.y,objDeleted.rectangle.size.width,objDeleted.rectangle.size.height,objDeleted.imageName);
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:objDeleted.rectangle];
        imageView.tag=objDeleted.tag;
        imageView.image=[UIImage imageNamed:objDeleted.imageName];
        
        
        CGPoint newCenter=CGPointMake(objDeleted.rectangle.origin.x+1.90f,self.areaHeight*2);
        imageView.center=newCenter;
        
        
        [self addCharacterAtIndex:2 position:newCenter tag:objDeleted.tag];
        
        
    }
    // remove all objects from deleted
    [deleted removeAllObjects];
    
    
}




-(void)auto0Generator {
    // Manual random delay
    int random=arc4random() %3;
    if (random==0) {
        return;
    }

    self.area0Tag++;
    if (self.area0Tag>=1990) {
        self.area0Tag=1000;
    }
    [self addCharacterAtIndex:0 position:CGPointMake(-50, self.areaHeight*0) tag:self.area0Tag];
}

-(void)auto2Generator {
    // Manual random delay
    int random=arc4random() %2;
    if (random==0) {
        return;
    }
    
    self.area2Tag++;
    if (self.area2Tag>=3990) {
        self.area2Tag=3000;
    }
    [self addCharacterAtIndex:2 position:CGPointMake(-50, self.areaHeight*2) tag:self.area2Tag];
}


#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
