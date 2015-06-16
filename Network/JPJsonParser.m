//
//  JPJsonParser.m
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import "JPJsonParser.h"

@implementation JPJsonParser
+ (NSDictionary *)dictionaryByParseData:(NSMutableData *)data
{
    NSError *error = nil;
    NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData: data
                                                              options: NSJSONReadingMutableContainers
                                                                error: &error];
    if (error) {
        return nil;
    }
    return resultDic;
}

@end
