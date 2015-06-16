//
//  JPJsonParser.h
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JPJsonParser : NSObject
+ (NSDictionary *)dictionaryByParseData:(NSMutableData *)data;

@end
