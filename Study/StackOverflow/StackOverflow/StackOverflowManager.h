//
//  StackOverflowManager.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"
#import "Topic.h"
#import "QuestionBuilder.h"

@protocol StackOverflowManagerDelegate<NSObject>
-(void)fetchingQuestionsFailedWithError:(NSError *)error;
-(void)didReceiveQuestions:(NSArray*)questions;
@end

@interface StackOverflowManager : NSObject
@property (weak, nonatomic) id<StackOverflowManagerDelegate> delegate;
@property StackOverflowCommunicator* communicator;
@property QuestionBuilder* questionBuilder;
@property NSError* fetchError;

-(void)fetchQuestionsOnTopic:(Topic*)topic;
-(void)searchingForQuestionsFailedWithError:(NSError *)error;
-(void)receivedQuestionsJSON:(NSString*)jsonString;
@end

extern NSString* StackOverflowManagerError;
extern NSString* StackOverflowManagerSearchFailedError;
enum{
    StackOverflowManagerQuestionsSearchCode,
    StackOverflowManagerErrorQuestionSearchCode
};