//
//  QuestionCreationTests.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StackOverflowManager.h"
#import "MockStackOverflowManagerDelegate.h"

#import "Topic.h"
#import "MockStackOverflowCommunicator.h"
#import "FakeQuestionBuilder.h"


@interface QuestionCreationWorkflowTests : XCTestCase
@end

@implementation QuestionCreationWorkflowTests
{
@private
    StackOverflowManager* mgr;
    MockStackOverflowManagerDelegate* delegate;
    NSError* underlyingError;
    FakeQuestionBuilder* questionBuilder;

}

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    mgr = [[StackOverflowManager alloc] init];
    delegate = [[MockStackOverflowManagerDelegate alloc] init];
    mgr.delegate = delegate;
    underlyingError = [NSError errorWithDomain:@"Test domain" code:0 userInfo:nil];
    questionBuilder = [[FakeQuestionBuilder alloc] init];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    mgr = nil;
    delegate = nil;
    underlyingError = nil;
    
    [super tearDown];
}

-(void)testNonConformingObjectCannotBeDelegate{
    XCTAssertThrows(mgr.delegate = (id<StackOverflowManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate as doesn't" @" conform to the delegate protocol");
}

-(void)testConformingObjectCanbeDelegate{
    id<StackOverflowManagerDelegate> newDelegate = [[MockStackOverflowManagerDelegate alloc] init];
    XCTAssertNoThrow(mgr.delegate = newDelegate, @"Object conforming to the delegate protocol should be used" @" as the delegate");
}

-(void)testManagerAcceptNilAsADelegate
{
    XCTAssertNoThrow(mgr.delegate = nil, @"It should be acceptable to use nil as an object's delegate");
}

-(void)testAskingForQuestionsMeansRequestingData{
    MockStackOverflowCommunicator* communicator = [[MockStackOverflowCommunicator alloc] init];
    mgr.communicator = communicator;
    Topic* topic = [[Topic alloc] initWithName:@"iPhone" tag:@"iphone"];
    [mgr fetchQuestionsOnTopic:topic];
    XCTAssertTrue([communicator wasAskedToFetchQuestions], @"The communicator should need to fetch data");
}

-(void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError], @"Error should be at the correct level of abstraction");
}

-(void)testErrorReturnedToDelegateDocumentsUnderlyingError{
    [mgr searchingForQuestionsFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

-(void)testQuestionJSONIsPassedToQuestionBuilder
{
    FakeQuestionBuilder* builder = [[FakeQuestionBuilder alloc] init];
    mgr.questionBuilder = builder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON", @"Downlaod JSON is sent to the builder");
    mgr.questionBuilder = nil;
}

-(void)testDelegateNotifiedOfErrorWhenQuestionBuilderFails{
    questionBuilder.arrayToReturn = nil;
    questionBuilder.errorToSet = underlyingError;
    mgr.questionBuilder = questionBuilder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The delegate should have found out about the error");
    mgr.questionBuilder = nil;
}

-(void)testEmtpyArrayIsPassedToDelegate
{
    questionBuilder.arrayToReturn = [NSArray array];
    mgr.questionBuilder = questionBuilder;
    [mgr receivedQuestionsJSON:@"Fake JSON"];
    XCTAssertTrue([delegate.receivedQuestions count] == 0, @"Returning an empty array is not an error");
}
@end
