//
//  PersonTest.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 6..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Person.h"

@interface PersonTest : XCTestCase
{
    Person* person;
}
@end

@implementation PersonTest

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    person = [[Person alloc] initWithName:@"Graham Lee"
                           avatarLocation:@"http://example.com/avatar.png"];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    person = nil;
    [super tearDown];
}

-(void)testThatPersonHasTheRightName
{
    XCTAssertEqualObjects(person.name, @"Graham Lee", @"person has name");
    
}

-(void)testPersonHasAnAvatarURL{
    XCTAssertEqualObjects([person.avatarURL absoluteString],
                          @"http://example.com/avatar.png",
                          @"The Person's avatar should be represented by a URL");
}
@end
