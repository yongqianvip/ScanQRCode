//
//  JPBaseRequester.m
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import "JPBaseRequester.h"

@implementation JPBaseRequester

- (void)startPostRequestWithURL:(NSURL *)url bodyString:(NSString *)bodyStr;
{
    self.requestData = [NSMutableData dataWithCapacity: 1];
    NSData *postData = [bodyStr dataUsingEncoding: NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody: postData];
    if (self.connection == nil) {
        self.connection = [[NSURLConnection alloc] initWithRequest: request delegate: self];
    }
    NSLog(@"\n--------------------  RequestURL --------------------\n%@%@\n-----------------------------------------------------",url,bodyStr);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_requestData appendData: data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (self.delegate != nil) {
        //        网络请求失败回调
        [self.delegate requester: self didFailRequestWithError: error];
    }
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.delegate != nil) {
        //        网络请求成功回调
        [self.delegate requester: self didFinishRequestWithData: _requestData];
    }
}
-(void)cancelAllRequest
{
    [self.connection cancel];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    NSLog(@"_____UIApplicationDidEnterBackgroundNotification________\ncancel all request ");
}

@end
