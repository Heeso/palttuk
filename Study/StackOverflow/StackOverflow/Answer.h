//
//  Answer.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 9..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Person.h"

@interface Answer : NSObject
{
    NSMutableSet* answerSet;
}

@property (strong) NSString* text;
@property (strong) Person* person;
@property (assign) NSInteger score;
@property (assign, getter = isAccepted) BOOL accepted;

-(NSComparisonResult)compare:(Answer*)otherAnswer;

@end
