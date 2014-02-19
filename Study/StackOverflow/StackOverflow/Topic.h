//
//  Topic.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 5..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface Topic : NSObject

@property (readonly) NSString* name;
@property (readonly) NSString* tag;


-(id)initWithName:(NSString*)newName tag:(NSString*)tagName;
-(NSArray*)recentQuestions;

-(void)addQuestion:(Question*)question;
@end
