//
//  BTLEPeripheralManager.h
//  BTLE Transfer
//
//  Created by heeso on 13. 10. 14..
//  Copyright (c) 2013년 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BTLEPeripheralManager : NSObject

+(BTLEPeripheralManager*)sharedInstance;
-(void)startAdvertise;

-(void)stopAdvertise;

@end
