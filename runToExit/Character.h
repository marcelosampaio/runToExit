//
//  Character.h
//  runToExit
//
//  Created by Marcelo Sampaio on 8/25/14.
//  Copyright (c) 2014 Marcelo Sampaio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Character : NSObject

@property CGRect rectangle;
@property (nonatomic,strong) NSString *imageName;
@property int tag;

-(id)initWithRectangle:(CGRect)mRectangle imageName:(NSString *)mImageName tag:(int)mTag;


@end
