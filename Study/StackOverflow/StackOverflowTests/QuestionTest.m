//
//  QuestionTest.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 5..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Question.h"


@interface QuestionTest : XCTestCase
{
    Question* question;
    Answer* lowScoreAnswer;
    Answer* highScoreAnswer;
}
@end

@implementation QuestionTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    question = [[Question alloc] init];
    question.date = [NSDate distantPast];
    question.title = @"Do iPhones also dream of electric sheep?";
    question.score = 42;
    
    
    Answer* accepted = [[Answer alloc] init];
    accepted.score = 1;
    accepted.accepted = YES;
    [question addAnswer:accepted];
     
    lowScoreAnswer = [[Answer alloc] init];
    lowScoreAnswer.score = -4;
    [question addAnswer:lowScoreAnswer];

    highScoreAnswer = [[Answer alloc] init];
    highScoreAnswer.score = 4;
    [question addAnswer:highScoreAnswer];
                       
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    question        = nil;
    lowScoreAnswer  = nil;
    highScoreAnswer = nil;
    [super tearDown];
}

-(void)testQuestionsHasADate
{
    NSDate* testDate = [NSDate distantPast];
    question.date = testDate;
    
    XCTAssertTrue([question.date isKindOfClass:[NSDate class]], @"Question needs to provide its date");
}

-(void)testQuestionsKeepScore
{
    XCTAssertEqual(question.score, 42, @"Question needs to provide its date");
}

-(void)testQuestionHasATitle
{
    XCTAssertEqualObjects(question.title, @"Do iPhones also dream of electric sheep?");
}

-(void)testQuestionCanHaveAnswersAdded{
    Answer* myAnswer = [[Answer alloc] init];
    XCTAssertNoThrow([question addAnswer:myAnswer], @"Must be able to add answers");
}

-(void)testAcceptedAnswerIsFirst{
    XCTAssertTrue([[question.answers objectAtIndex:0] isAccepted], @"Accepted answer comes first");
}

-(void)testHighScoreAnswerBeforeLow
{
    NSArray* answers = question.answers;
    NSInteger highIndex = [answers indexOfObject:highScoreAnswer];
    NSInteger lowIndex = [answers indexOfObject:lowScoreAnswer];
    
    XCTAssertTrue(highIndex < lowIndex, @"High-scoring answer comes first");
}
@end
