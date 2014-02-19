//
//  FakeURLResponse.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 18..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSURLResponse
@property NSInteger statusCode;

-(id)initWithStatusCode:(NSInteger)statusCode;
@end
