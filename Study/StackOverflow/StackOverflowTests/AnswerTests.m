//
//  AnswerTests.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 9..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Answer.h"

@interface AnswerTests : XCTestCase
{
    Answer* answer;
    Answer* otherAnswer;
}
@end

@implementation AnswerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    answer = [[Answer alloc] init];
    answer.text = @"The answer is 42";
    answer.person = [[Person alloc] initWithName:@"Grahm Lee" avatarLocation:@"http://example.com/avatar.png"];
    answer.score = 42;

    otherAnswer = [[Answer alloc] init];
    otherAnswer.text = @"I have the answer you need";
    otherAnswer.score = 42;

}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    answer = nil;
    [super tearDown];
}

-(void)testAnswerHasSomeText
{
    XCTAssertEqualObjects(answer.text, @"The answer is 42", @"Answer need to contain some text");
}

-(void)testSomeProvidedTheAnswer
{
    XCTAssertTrue([answer.person isKindOfClass:[Person class]], @"A person gave this Answer");
}

-(void)testAnswersNotAcceptedByDefault
{
    XCTAssertFalse(answer.accepted, @"Answer not accepted by default");
}

-(void)testAnswerCanBeAccepted
{
    XCTAssertNoThrow(answer.accepted =YES, @"It is possible to accept an answer");
}

-(void)testAnswerHasScore
{
    XCTAssertTrue(answer.score == 42, @"Answer is score can be retrieved");
}

-(void)testAcceptedAnswerComesBeforeUnacccepted
{
    otherAnswer.accepted = YES;
    otherAnswer.score = answer.score + 10;
    
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Accepted answer should come first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Accepted answer should come first");
}

-(void)testAnswersWithEqualScoresCompareEqually
{
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedSame, @"Both answers of equal rank");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedSame, @"Each answers of equal rank");
}

-(void)testLowerScoringAnswerComesAfterHigher
{
    otherAnswer.score = answer.score + 10;
    XCTAssertEqual([answer compare:otherAnswer], NSOrderedDescending, @"Higher score  comes first");
    XCTAssertEqual([otherAnswer compare:answer], NSOrderedAscending, @"Lower score  comes first");
}
@end
