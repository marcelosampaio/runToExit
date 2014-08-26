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
@synthesize area0Characters,area1Characters,area2Characters,area3Characters;
@synthesize area0GeneratorTimer,area1GeneratorTimer,area2GeneratorTimer,area3GeneratorTimer;
@synthesize alerts;

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
    
    // Characters in the UI - not used
    self.area0Characters=[[NSMutableArray alloc]init];
    self.area1Characters=[[NSMutableArray alloc]init];
    self.area2Characters=[[NSMutableArray alloc]init];
    self.area3Characters=[[NSMutableArray alloc]init];
    
    // Alerts sent by the character when near row's end
    self.alerts=[[NSMutableDictionary alloc]init];

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
        int startX;
        if (i==0) {
            tag=self.area0Tag;
            startX=-50;
        } else if (i==1) {
            tag=self.area1Tag;
            startX=self.areaWidth+50;
        } else if (i==2) {
            tag=self.area2Tag;
            startX=-50;
        } else {
            tag=self.area3Tag;
            startX=self.areaWidth+50;
        }
        [self addAreaAtIndex:i position:position];
        [self addCharacterAtIndex:i position:CGPointMake(startX, position.y) tag:tag];
    }
    
    // Start timers
    // Area 0
    self.area0Timer=[NSTimer scheduledTimerWithTimeInterval:0.04f target:self selector:@selector(animateRow0) userInfo:nil repeats:YES];
    self.area0GeneratorTimer=[NSTimer scheduledTimerWithTimeInterval:2.9f target:self selector:@selector(auto0Generator) userInfo:nil repeats:YES];
    // Area 1
    self.area1Timer=[NSTimer scheduledTimerWithTimeInterval:0.03f target:self selector:@selector(animateRow1) userInfo:nil repeats:YES];
    self.area1GeneratorTimer=[NSTimer scheduledTimerWithTimeInterval:2.9f target:self selector:@selector(auto1Generator) userInfo:nil repeats:YES];
    // Area 2
    self.area2Timer=[NSTimer scheduledTimerWithTimeInterval:0.075f target:self selector:@selector(animateRow2) userInfo:nil repeats:YES];
    self.area2GeneratorTimer=[NSTimer scheduledTimerWithTimeInterval:3.6f target:self selector:@selector(auto2Generator) userInfo:nil repeats:YES];
    // Area 3
    self.area3Timer=[NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(animateRow3) userInfo:nil repeats:YES];
    self.area3GeneratorTimer=[NSTimer scheduledTimerWithTimeInterval:9.5f target:self selector:@selector(auto3Generator) userInfo:nil repeats:YES];
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
    [self.area1Images addObject:@"croc_walk01"];
    [self.area1Images addObject:@"croc_walk02"];
    [self.area1Images addObject:@"croc_walk03"];
    [self.area1Images addObject:@"croc_walk04"];
    // Area 2
    [self.area2Images addObject:@"monkey_run_0"];
    [self.area2Images addObject:@"monkey_run_1"];
    [self.area2Images addObject:@"monkey_run_2"];
    [self.area2Images addObject:@"monkey_run_3"];
    [self.area2Images addObject:@"monkey_run_4"];
    [self.area2Images addObject:@"monkey_run_5"];
    [self.area2Images addObject:@"monkey_run_6"];
    [self.area2Images addObject:@"monkey_run_7"];
    // Area 3
    [self.area3Images addObject:@"bear1"];
    [self.area3Images addObject:@"bear2"];
    [self.area3Images addObject:@"bear3"];
    [self.area3Images addObject:@"bear4"];
    [self.area3Images addObject:@"bear5"];
    [self.area3Images addObject:@"bear6"];
    [self.area3Images addObject:@"bear7"];
    [self.area3Images addObject:@"bear8"];
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
        // rect=CGRectMake(self.areaWidth-46.6, position.y+56+4, 46.6, 56);
        CGPoint point=CGPointMake(position.x, position.y+56+4);
        CGSize size=CGSizeMake(46.6, 56);
        rect = CGRectMake(point.x, point.y, size.width, size.height);
        
        imageName=[self.area1Images objectAtIndex:self.area1ImageSequenceNumber];
        
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:imageName];
        imageView.tag=tag;  // self.area0Tag;
        
        Character *objCharacter=[[Character alloc]initWithRectangle:imageView.frame imageName:imageName tag:imageView.tag];
        [self.area1Characters addObject:objCharacter];
        
        // increment Image Sequence Number Control
        self.area1ImageSequenceNumber++;
        if (self.area1ImageSequenceNumber>self.area1Images.count-1) {
            self.area1ImageSequenceNumber=0;
        }
        
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
//        rect=CGRectMake(self.areaWidth-46.6, position.y+56+14, 46.6, 44);

        CGPoint point=CGPointMake(position.x, position.y+60);
        CGSize size=CGSizeMake(66, 56);
        rect = CGRectMake(point.x, point.y, size.width, size.height);
        
        imageName=[self.area3Images objectAtIndex:self.area3ImageSequenceNumber];
        
        imageView=[[UIImageView alloc]initWithFrame:rect];
        imageView.image=[UIImage imageNamed:imageName];
        imageView.tag=tag;  // self.area0Tag;
        
        Character *objCharacter=[[Character alloc]initWithRectangle:imageView.frame imageName:imageName tag:imageView.tag];
        [self.area3Characters addObject:objCharacter];
        
        // increment Image Sequence Number Control
        self.area3ImageSequenceNumber++;
        if (self.area3ImageSequenceNumber>self.area3Images.count-1) {
            self.area3ImageSequenceNumber=0;
        }
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
            // Send an alert to user. The end is near
            [self checkAlertWithView:view index:0];
            
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

// Animate row 1
-(void)animateRow1 {
    
    NSMutableArray *deleted=[[NSMutableArray alloc]init];
    Character *characterDeleted=[[Character alloc]init];
    NSString *imageName=[self.area1Images objectAtIndex:self.area1ImageSequenceNumber];
    //
    // Remove character from area 1
    for (UIView *view in self.view.subviews) {
        if (view.tag>=2000 && view.tag<=2999) {
            // Send an alert to user. The end is near
            [self checkAlertWithView:view index:1];
            
            if (view.center.x>=-25) {
                characterDeleted=[[Character alloc]initWithRectangle:view.frame imageName:imageName tag:view.tag];
                [deleted addObject:characterDeleted];
            }
            // remove character in area 0
            [view removeFromSuperview];
            
        }
    }
    
    // Add character in a new point with a new animation image
    for (Character *objDeleted in deleted) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:objDeleted.rectangle];
        imageView.tag=objDeleted.tag;
        imageView.image=[UIImage imageNamed:objDeleted.imageName];
        
        CGPoint newCenter=CGPointMake(objDeleted.rectangle.origin.x-2.20f,self.areaHeight*1);
        imageView.center=newCenter;
        
        [self addCharacterAtIndex:1 position:newCenter tag:objDeleted.tag];
        
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
            // Send an alert to user. The end is near
            [self checkAlertWithView:view index:2];
            
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

// Animate row 3
-(void)animateRow3 {
    
    NSMutableArray *deleted=[[NSMutableArray alloc]init];
    Character *characterDeleted=[[Character alloc]init];
    NSString *imageName=[self.area3Images objectAtIndex:self.area3ImageSequenceNumber];
    //
    // Remove character from area 3
    for (UIView *view in self.view.subviews) {
        if (view.tag>=4000 && view.tag<=4999) {
            // Send an alert to user. The end is near
            [self checkAlertWithView:view index:3];
            
            if (view.center.x>=-25) {
                characterDeleted=[[Character alloc]initWithRectangle:view.frame imageName:imageName tag:view.tag];
                [deleted addObject:characterDeleted];
            }
            // remove character in area 0
            [view removeFromSuperview];
            
        }
    }
    
    // Add character in a new point with a new animation image
    for (Character *objDeleted in deleted) {
        
        UIImageView *imageView=[[UIImageView alloc]initWithFrame:objDeleted.rectangle];
        imageView.tag=objDeleted.tag;
        imageView.image=[UIImage imageNamed:objDeleted.imageName];
        
        CGPoint newCenter=CGPointMake(objDeleted.rectangle.origin.x-1.60f,self.areaHeight*3);
        imageView.center=newCenter;
        
        [self addCharacterAtIndex:3 position:newCenter tag:objDeleted.tag];
        
        
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

-(void)auto1Generator {
    // Manual random delay
    int random=arc4random() %3;
    if (random==0) {
        return;
    }
    
    self.area1Tag++;
    if (self.area1Tag>=2990) {
        self.area0Tag=2000;
    }
    [self addCharacterAtIndex:1 position:CGPointMake(self.areaWidth+46.6, self.areaHeight*1) tag:self.area1Tag];
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


-(void)auto3Generator {
    // Manual random delay
    int random=arc4random() %4;
    if (random>0) {
        return;
    }
    
    self.area3Tag++;
    if (self.area1Tag>=4990) {
        self.area0Tag=4000;
    }
    [self addCharacterAtIndex:3 position:CGPointMake(self.areaWidth+46.6, self.areaHeight*1) tag:self.area3Tag];
}

#pragma mark - Working Methods
-(void)checkAlertWithView:(UIView *)view index:(int)i {
    BOOL alert=NO;
    if (i==0 || i==2) {
        if (view.center.x>=self.view.frame.size.width-100) {
            // Store tag in alert dictionary
            NSString *tagString=[self.alerts objectForKey:[NSString stringWithFormat:@"%d",view.tag]];
            if ([tagString intValue]==view.tag) {
                return;
            }
            [self.alerts setObject:[NSString stringWithFormat:@"%d",view.tag] forKey:[NSString stringWithFormat:@"%d",view.tag]];
            // Execute alert procedures
            alert=YES;
        }
    } else {
        if (view.center.x<=100) {
            // Store tag in alert dictionary
            NSString *tagString=[self.alerts objectForKey:[NSString stringWithFormat:@"%d",view.tag]];
            if ([tagString intValue]==view.tag) {
                return;
            }
            [self.alerts setObject:[NSString stringWithFormat:@"%d",view.tag] forKey:[NSString stringWithFormat:@"%d",view.tag]];
            // Execute alert procedures
            alert=YES;
        }
    }
    
    // Alert
    if (alert) {
        [self sendAlertAtIndex:i view:view];
    }
}

-(void)sendAlertAtIndex:(int)i view:(UIView *)view {
    CGPoint point;
    CGSize size;

    if (i==0 || i==2) {
        point=CGPointMake(self.areaWidth-20, self.areaHeight*i);
        size=CGSizeMake(22, self.areaHeight-20);
    } else {
        point=CGPointMake(0, self.areaHeight*i);
        size=CGSizeMake(22, self.areaHeight-20);
    }
    
    
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(point.x,point.y,size.width, size.height)];
    imageView.image=[UIImage imageNamed:@"stone"];
    imageView.tag=22;
    [self.view addSubview:imageView];
}

#pragma mark - Status Bar
-(BOOL)prefersStatusBarHidden {
    return YES;
}

@end
