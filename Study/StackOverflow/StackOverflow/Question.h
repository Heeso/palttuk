//
//  Question.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 5..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Answer.h"

@interface Question : NSObject
{
    NSMutableSet* answerSet;
}
@property NSDate* date;
@property NSString* title;
@property NSInteger score;
@property NSInteger questionID;
@property Person* asker;

@property (readonly) NSArray* answers;

-(id)initWithJSON:(NSDictionary*)json;
-(void)addAnswer:(Answer*)otherAnswer;
@end
