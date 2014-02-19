//
//  StackOverflowManager.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "StackOverflowManager.h"

NSString* StackOverflowManagerError = @"StackOverflowManagerError";
NSString* StackOverflowManagerSearchFailedError = @" StackOverflowManagerSearchFailedError";

@implementation StackOverflowManager

-(void)setDelegate:(id<StackOverflowManagerDelegate>)newDelegate
{
    if (newDelegate
        && ![newDelegate conformsToProtocol:@protocol(StackOverflowManagerDelegate)])
    {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol" userInfo:nil] raise];
    }
    _delegate = newDelegate;
}

-(void)fetchQuestionsOnTopic:(Topic*)topic
{
    [_communicator searchForQuestionsWithTag:topic.tag];
}

-(void)searchingForQuestionsFailedWithError:(NSError *)error
{
    NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    NSError* reportableError = [NSError errorWithDomain:StackOverflowManagerError code:StackOverflowManagerQuestionsSearchCode userInfo:errorInfo];
    [_delegate fetchingQuestionsFailedWithError:reportableError];
}

-(void)receivedQuestionsJSON:(NSString*)jsonString
{
    NSError* error = nil;
    NSArray* questions = [self.questionBuilder questionsFromJSON:jsonString error:&error];
    if (questions == nil) {
        NSDictionary* errorInfo = nil;
        if (error) {
            errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
        }
        
        NSError* reportableError = [NSError errorWithDomain:StackOverflowManagerSearchFailedError
                                                       code:StackOverflowManagerErrorQuestionSearchCode
                                                   userInfo:[NSDictionary dictionaryWithObject:errorInfo forKey:NSUnderlyingErrorKey]];
        [_delegate fetchingQuestionsFailedWithError:reportableError];
    }
    else{
        [_delegate didReceiveQuestions:questions];
    }
}

@end
