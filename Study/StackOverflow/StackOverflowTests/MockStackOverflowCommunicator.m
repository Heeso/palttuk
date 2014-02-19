//
//  MockStackOverflowCommunicator.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "MockStackOverflowCommunicator.h"

@implementation MockStackOverflowCommunicator
{
    BOOL wasAskedToFetchQuestions;
}

-(void)searchForQuestionsWithTag:(NSString*)tag
{
    wasAskedToFetchQuestions = YES;
}

-(BOOL)wasAskedToFetchQuestions
{
    return wasAskedToFetchQuestions;
}

@end
