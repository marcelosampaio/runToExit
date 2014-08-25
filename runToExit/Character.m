//
//  Character.m
//  runToExit
//
//  Created by Marcelo Sampaio on 8/25/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import "Character.h"




@implementation Character

@synthesize rectangle,imageName,tag;


#pragma mark - Initialization
-(id)initWithRectangle:(CGRect)mRectangle imageName:(NSString *)mImageName tag:(int)mTag {
    self = [super init];
    if (self) {
        rectangle=mRectangle;
        imageName=mImageName;
        tag=mTag;
    }
    return self;
}

@end
