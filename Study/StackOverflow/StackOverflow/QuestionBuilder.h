//
//  QuestionBuilder.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 14..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>

enum  {
    QuestionBuilderInvalidJSONError,
    QuestionBuilderMissingDataError
};

@interface QuestionBuilder : NSObject
@property NSString* JSON;
@property NSArray* arrayToReturn;
@property NSError* errorToSet;

-(NSArray*)questionsFromJSON:(NSString*)objectNotation error:(NSError**)error;

@end

extern NSString* QuestionBuilderErrorDomain;