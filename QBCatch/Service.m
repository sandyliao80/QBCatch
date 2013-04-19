//
//  Service.m
//  QBCatch
//
//  Created by ello on 13-4-16.
//  Copyright (c) 2013年 ello. All rights reserved.
//

#import "Service.h"
#import "common.h"
@implementation Service

@synthesize receiveDelegate = _receiveDelegate;
@synthesize request = _request;

- (void)sendServiceRequest:(int)requestID
{
    _request.delegate = self;
    switch (requestID) {
        case GET_8H_HOT:
            [self send8HotRequest];
            break;
            
        default:
            break;
    }
    
}

//获取8小时热门列表
- (void)send8HotRequest
{
    NSURL *url = [NSURL URLWithString:@"http://m2.qiushibaike.com/article/list/week?count=30&page=1"];
    _request = [ASIHTTPRequest requestWithURL:url];
    [_request setDelegate:self];
    [_request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSLog(@"requestFinished");
    NSLog(@"responseHeaders:%@",request.responseHeaders);
    NSLog(@"responseData:%@",request.responseData);
    NSDictionary *dictionary = [[NSDictionary alloc] init];
    [_receiveDelegate receiveData:dictionary];
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"requestFailed");
}

- (void)dealloc
{
    _request = nil;
    [super dealloc];
}

@end
