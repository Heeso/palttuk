//
//  Topic.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 5..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "Topic.h"
@interface Topic()
@property NSArray* questions;
@end

@implementation Topic
-(id)initWithName:(NSString*)newName tag:(NSString*)tagName{
    self = [super init];
    if (self) {
        _name = [newName copy];
        _tag = [tagName copy];
        _questions = [[NSArray alloc] init];
    }
    return self;
}

-(NSArray*)recentQuestions{
    return [self sortQuestionsLatestFirst:_questions];
}

-(NSArray*)sortQuestionsLatestFirst:(NSArray*)questionList
{
    return [questionList sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        Question* q1 = (Question*)obj1;
        Question* q2 = (Question*)obj2;
        return [q2.date compare:q1.date];
    }];
}

-(void)addQuestion:(Question*)question{
    NSArray* newQuestions = [_questions arrayByAddingObject:question];
    newQuestions = [self sortQuestionsLatestFirst:newQuestions];

    if ([newQuestions count] > 20) {

        newQuestions = [newQuestions subarrayWithRange:NSMakeRange(0, 20)];
    }
    _questions = newQuestions;
}
@end
