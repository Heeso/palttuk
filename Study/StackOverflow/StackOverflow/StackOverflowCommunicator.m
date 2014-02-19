//
//  StackOverflowCommunicator.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 13..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "StackOverflowCommunicator.h"

@implementation StackOverflowCommunicator


-(void)cancelAndDiscardURLConnection
{
    [fetchingConnection cancel];
    fetchingConnection = nil;
}

@end
