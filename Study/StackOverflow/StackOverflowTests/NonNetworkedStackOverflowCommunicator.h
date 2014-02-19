//
//  NonNetworkedStackOverflowCommunicator.h
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 18..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackOverflowCommunicator.h"

@protocol NonNetworkedStackOverflowCommunicatorDelegate <NSObject>



@end

@interface NonNetworkedStackOverflowCommunicator : StackOverflowCommunicator

@property (weak) id<NonNetworkedStackOverflowCommunicatorDelegate> delegate;
@end
