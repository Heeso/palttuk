//
//  StackOverflowCommunicatorTests.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 18..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InspectableStackOverflowCommunicator.h"
#import "NonNetworkedStackOverflowCommunicator.h"
#import "MockStackOverflowManager.h"
#import "FakeURLResponse.h"

@interface StackOverflowCommunicatorTests : XCTestCase

@end

@implementation StackOverflowCommunicatorTests
{
    InspectableStackOverflowCommunicator*   communicator;
    NonNetworkedStackOverflowCommunicator*  nnCommunicator;
    MockStackOverflowManager*               manager;
    FakeURLResponse*                        fourOhFourResponse;
    NSData*                                 receivedData;
}
- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    communicator = [[InspectableStackOverflowCommunicator alloc] init];
    nnCommunicator = [[NonNetworkedStackOverflowCommunicator alloc] init];
    manager = [[MockStackOverflowManager alloc] init];

    nnCommunicator.delegate = manager;
    fourOhFourResponse = [[FakeURLResponse alloc] initWithStatusCode:404];
    receivedData = [@"Result" dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [communicator cancelAndDiscardURLConnection];
    communicator        = nil;
    nnCommunicator      = nil;
    manager             = nil;
    fourOhFourResponse  = nil;
    receivedData        = nil;
    [super tearDown];
}

-(void)testFillingInQuestionBodyCallsQuestionAPI
{
    [communicator downlaodInformationForQuestionWithID:12345];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/questions/12345?body=true", @"Use the question API to get the body for a question");
}

-(void)testSearchingForQuestionsOnTopicCallsTopicApi
{

    [communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertEqualObjects([[communicator URLToFetch] absoluteString], @"http://api.stackoverflow.com/1.1/search?tagged=ios&pagesize=20", @"Use the search API to find quetions with a particular tag");
}

-(void)testSearchingForQuestionsCreatesURLConnection
{
    [communicator searchForQuestionsWithTag:@"ios"];
    XCTAssertNotNil([communicator currentURLConnection], @"There should be a URL connection in-flight now.");
    [communicator cancelAndDiscardURLConnection];
}

-(void)testReceivingResponseDiscardExistingData
{
    nnCommunicator.receivedData = [@"Hello" dataUsingEncoding:NSUTF8StringEncoding];
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:nil];
    XCTAssertEqual([nnCommunicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

-(void)testReceivingResponseWith404StatusPassesErrorToDelegate
{
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse*)fourOhFourResponse];
    XCTAssertEqual([manager topicFailureErrorCode], 404, @"Fetch failure was passed through to delegate");
}

-(void)testNoErrorReceivedOn200Status
{
    FakeURLResponse* twoHundredResponse = [[FakeURLResponse alloc] initWithStatusCode:200];
    [nnCommunicator searchForQuestionsWithTag:@"ios"];
    [nnCommunicator connection:nil didReceiveResponse:(NSURLResponse*)twoHundredResponse];
    XCTAssertFalse([manager topicFailureErrorCode] == 200, @"No need for error on 200 response");
}



@end
