//
//  JPBaseRequester.h
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JPBaseRequester;
@protocol JPBaseRequestDelegate <NSObject>
- (void)requester:(JPBaseRequester *)requester didFinishRequestWithData:(NSMutableData *)requestData;
- (void)requester:(JPBaseRequester *)requester didFailRequestWithError:(NSError *)error;
@end

@interface JPBaseRequester : NSObject


@property (nonatomic, retain) NSMutableData *requestData;
@property (nonatomic, retain) NSURLConnection *connection;

@property (nonatomic, assign) id <JPBaseRequestDelegate> delegate;

- (void)startPostRequestWithURL:(NSURL *)url bodyString:(NSString *)bodyStr;



@end
