//
//  MockStackOverflowManagerDelegate.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "MockStackOverflowManagerDelegate.h"

@implementation MockStackOverflowManagerDelegate
-(void)fetchingQuestionsFailedWithError:(NSError *)error{
    self.fetchError = error;
}

-(void)didReceiveQuestions:(NSArray*)questions
{
    self.receivedQuestions = questions;
}

@end
