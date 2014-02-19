//
//  QuestionBuilderTests.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 16..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QuestionBuilder.h"
#import "Question.h"

@interface QuestionBuilderTests : XCTestCase
@end

static NSString* questionJSONFileName = @"TextFileForTestQuestionsJSONParsing.txt";

@implementation QuestionBuilderTests
{
    QuestionBuilder* questionBuilder;
    Question* question;
    NSArray* questions;
    
}
- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    questionBuilder = [[QuestionBuilder alloc] init];

    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSString *path = [bundle pathForResource:@"JSONTextFile" ofType:@""];
    NSString* jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    jsonString = [jsonString stringByTrimmingCharactersInSet:
                  [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    questions = [questionBuilder questionsFromJSON:jsonString error:nil];

    question = questions[0];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    questionBuilder = nil;
    [super tearDown];
}

-(void)testThatNilIsNotAnAcceptableParameter
{
    XCTAssertThrows([questionBuilder questionsFromJSON:nil error:NULL], @"Lack of data should have been handled elsewhere");
    
}

-(void)testNilReturnedWhenStringIsNotJSON
{
    XCTAssertNil([questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"This parameter should not be parsable");
}

-(void)testErrorSetWhenStringIsNotJSON
{
    NSError* error = nil;
    [questionBuilder questionsFromJSON:@"Not JSON" error:&error];
    XCTAssertNotNil(error, @"An error occurred, we should be told");
}

-(void)testPassingNullErrorDoesNotCauseCrash
{
    XCTAssertNoThrow([questionBuilder questionsFromJSON:@"Not JSON" error:NULL], @"Using a NULL error parameter should not be a problem");
}

-(void)testRealJSONWithoutQuestiosnArrayIsError
{
    NSString* jsonString = @"\"{noquestions\": true}";
    XCTAssertNil([questionBuilder questionsFromJSON:jsonString error:NULL], @"No questions to parse in this JSON");
}

-(void)testQuestionCreatedFromJSONHasProertiesPresentedInJSON{
    XCTAssertEqual(question.questionID, 21768242, @"The Question ID should match the data we sent");
    XCTAssertEqual([question.date timeIntervalSince1970], (NSTimeInterval)1392336040, @"The date of the question should match the data");
    XCTAssertEqualObjects(question.title, @"iOS 7 UIWebView 304 cache bug, blank pages", @"Title should match the provided data");
    XCTAssertEqual(question.score, 2, @"Score should match the data");
//    Person* asker = question.asker;
}


@end

