//
//  FakeURLResponse.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 18..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "FakeURLResponse.h"

@implementation FakeURLResponse
-(id)initWithStatusCode:(NSInteger)statusCode
{
    self = [super init];
    if (self) {
        self.statusCode = statusCode;
    }
    return self;
}
@end
