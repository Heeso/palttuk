//
//  Answer.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 9..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "Answer.h"

@implementation Answer

-(NSComparisonResult)compare:(Answer*)otherAnswer{
    if (self.accepted && otherAnswer.accepted == NO) {
        return NSOrderedAscending;
    }
    else if(self.accepted == NO && otherAnswer.accepted){
        return NSOrderedDescending;
    }
    
    if (self.score > otherAnswer.score) {
        return NSOrderedAscending;
    }
    
    if (self.score < otherAnswer.score) {
        return NSOrderedDescending;
    }
    return NSOrderedSame;
}
@end
