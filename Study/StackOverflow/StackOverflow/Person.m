//
//  Person.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 6..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "Person.h"

@implementation Person

-(id)initWithName:(NSString*)name avatarLocation:(NSString*)location{
    self = [super init];
    if (self) {
        _name = [name copy];
        _avatarURL = [NSURL URLWithString:location];
        
    }
    return self;
}

-(id)initWithJSON:(NSDictionary*)json
{
    self = [super init];
    if (self) {
        _name = json[@"display_name"];

        
        
    }
    return self;
}
@end
