//
//  QuestionBuilder.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 14..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "QuestionBuilder.h"
#import "StackOverflowManager.h"

NSString* QuestionBuilderErrorDomain = @"QuestionBuilderErrorDomain";

@implementation QuestionBuilder
-(NSArray*)questionsFromJSON:(NSString*)objectNotation error:(NSError**)error
{
    NSParameterAssert(objectNotation != nil);
    self.JSON = objectNotation;
    
    NSData* unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError* localError = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation
                                                    options:0
                                                      error:&localError];
    NSDictionary* parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        if (error != NULL) {
            *error = [NSError errorWithDomain:QuestionBuilderErrorDomain code:QuestionBuilderMissingDataError userInfo:nil];
        }
        return nil;
    }
    

    
    NSMutableArray* questions = [[NSMutableArray alloc] init];
    for (NSDictionary* questionJSON in parsedObject[@"questions"]) {
        Question* question = [[Question alloc] initWithJSON:questionJSON];
        [questions addObject:question];
    }

    self.arrayToReturn = questions;
    
    if (self.arrayToReturn == nil)
    {
        NSDictionary* userInfo = [NSDictionary dictionaryWithObject:objectNotation
                                                             forKey:NSUnderlyingErrorKey];

        if (error != NULL) {
            *error = [NSError errorWithDomain:StackOverflowManagerSearchFailedError
                                         code:StackOverflowManagerErrorQuestionSearchCode
                                     userInfo:userInfo];
        }
        return nil;
    }
    return self.arrayToReturn;
}

@end
