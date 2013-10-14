//
//  BTLECentralManager.h
//  BTLE Transfer
//
//  Created by heeso on 13. 10. 14..
//  Copyright (c) 2013년 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol BTLECentralManagerDelegate <NSObject>

-(void)responseString:(NSString*)response;

@end

@interface BTLECentralManager : NSObject
@property (nonatomic, assign) id<BTLECentralManagerDelegate> delegate;


+(BTLECentralManager*)sharedInstance;

-(void)stopScan;
@end
