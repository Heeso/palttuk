//
//  InspectableStackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 18..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"

@interface InspectableStackOverflowCommunicator : StackOverflowCommunicator<NSURLConnectionDelegate>

-(NSURL*)URLToFetch;
-(void)downlaodInformationForQuestionWithID:(NSInteger)questionID;
-(NSURLConnection*)currentURLConnection;
@end

extern NSString* kStackOverflowServerAddress;