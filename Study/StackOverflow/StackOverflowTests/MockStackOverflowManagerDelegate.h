//
//  MockStackOverflowManagerDelegate.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowManager.h"

@interface MockStackOverflowManagerDelegate : NSObject<StackOverflowManagerDelegate>
@property NSError* fetchError;
@property NSArray* receivedQuestions;

@end
