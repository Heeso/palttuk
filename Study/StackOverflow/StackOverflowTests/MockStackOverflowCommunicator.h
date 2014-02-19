//
//  MockStackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"
#import "Topic.h"

@interface MockStackOverflowCommunicator : StackOverflowCommunicator

-(BOOL)wasAskedToFetchQuestions;

@end
