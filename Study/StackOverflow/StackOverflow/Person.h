//
//  Person.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 6..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (readonly) NSString* name;
@property (readonly) NSURL* avatarURL;

-(id)initWithName:(NSString*)name avatarLocation:(NSString*)avatarURL;
-(id)initWithJSON:(NSDictionary*)json;
@end
