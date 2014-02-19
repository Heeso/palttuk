//
//  InspectableStackOverflowCommunicator.m
//  StackOverflow
//
//  Created by Heeso KIM on 2014. 2. 18..
//  Copyright (c) 2014년 Heeso KIM. All rights reserved.
//

#import "InspectableStackOverflowCommunicator.h"
NSString* kStackOverflowServerAddress = @"http://api.stackoverflow.com/1.1";

@implementation InspectableStackOverflowCommunicator
{
    NSURL* fetchingURL;
}

-(void)fetchContentAtURL:(NSURL*)url
{
    fetchingURL = url;
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [fetchingConnection cancel];
    fetchingConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

-(NSURLConnection*)currentURLConnection
{
    return fetchingConnection;
}


-(void)searchForQuestionsWithTag:(NSString *)tag
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/search?tagged=%@&pagesize=20", kStackOverflowServerAddress, tag]]];
}

-(NSURL*)URLToFetch
{
    return fetchingURL;
}

-(void)downlaodInformationForQuestionWithID:(NSInteger)questionID
{
    [self fetchContentAtURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/questions/%d?body=true", kStackOverflowServerAddress, questionID]]];
}


@end
