//
//  TopicTest.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 5..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Topic.h"

@interface TopicTest : XCTestCase
{
    Topic* newTopic;
}
@end

@implementation TopicTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    newTopic = [[Topic alloc] initWithName:@"iPhone" tag:@"iPhone"];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    newTopic = nil;
    [super tearDown];
}

-(void)testThatTopicExists
{
    XCTAssertNotNil(newTopic, @"should be able to create a Topic instance");
}

-(void)testThatTopicCanBeName
{
    XCTAssertEqualObjects(newTopic.name, @"iPhone", @"the Topic should have the name I gave it");
}

-(void)testThatTopicHasATag
{
    XCTAssertEqualObjects(newTopic.tag, @"iPhone", @"Topics need to have tags");
}

-(void)testForAListOfQuestions
{
    XCTAssertTrue([[newTopic recentQuestions] isKindOfClass:[NSArray class]], @"Topic should provide a list of recent questions");
}

-(void)testForInitiallyEmptyQuestionList
{
    XCTAssertEqual([[newTopic recentQuestions] count], (NSUInteger)0, @"No questions added yet, count shoud be zero");
}

-(void)testAddingAQuestionToTheList
{
    Question* question = [[Question alloc] init];
    [newTopic addQuestion:question];
    XCTAssertEqual([[newTopic recentQuestions] count], (NSUInteger)1, @"Add a question, and the count of questions should go up");
}

-(void)testQuestionsAreListedChronologically
{
    Question* q1 = [[Question alloc] init];
    q1.date = [NSDate distantPast];
    
    Question* q2 = [[Question alloc] init];
    q2.date = [NSDate distantFuture];
    
    [newTopic addQuestion:q1];
    [newTopic addQuestion:q2];
    
    NSArray* questions = [newTopic recentQuestions];
    Question* listedFirst = questions[0];
    Question* listedSecond = questions[1];
    
    XCTAssertEqualObjects([listedFirst.date laterDate:listedSecond.date], listedFirst.date, @"The Later question should apear first in the list");
}


-(void)testLimtOfTwentyQuestions
{
    Question* q1 = [[Question alloc] init];
    for (NSInteger i=0; i<25;i++) {
        [newTopic addQuestion:q1];
    }
    XCTAssertTrue([[newTopic recentQuestions] count] < 21, @"There should never be more than twenty questions");
}
@end
