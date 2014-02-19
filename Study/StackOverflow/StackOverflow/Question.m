//
//  Question.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 5..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "Question.h"

@implementation Question
-(id)init
{
    self = [super init];
    if (self) {
        answerSet = [[NSMutableSet alloc] init];
        
    }

    return self;
}

-(id)initWithJSON:(NSDictionary*)json
{
    self = [super init];
    if (self) {
        self.questionID = [json[@"question_id"] integerValue];
        NSTimeInterval createtionTimeInterval = [json[@"creation_date"] doubleValue];
        self.date = [NSDate dateWithTimeIntervalSince1970:createtionTimeInterval];
        self.title = json[@"title"];
        self.score = [json[@"score"] integerValue];
        self.asker = [[Person alloc] initWithJSON:json[@"owner"]];
    }
    return self;
    
}

-(void)addAnswer:(Answer*)otherAnswer
{
    [answerSet addObject:otherAnswer];
}

-(NSArray*)answers{
    return [[answerSet allObjects] sortedArrayUsingSelector:@selector(compare:)];
}
@end
