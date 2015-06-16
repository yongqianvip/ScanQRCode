//
//  JPSoundPlayer.m
//  ScanQRCode
//
//  Created by YYQ on 14-8-26.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import "JPSoundPlayer.h"
#import <AVFoundation/AVFoundation.h>

@implementation JPSoundPlayer



+(void)playSoundWAVWithName:(NSString *)soundName
{
    SystemSoundID soundID;
    NSString *strSoundFilePath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:strSoundFilePath]) {
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:strSoundFilePath],&soundID);
        AudioServicesPlaySystemSound(soundID);
    }else{
        NSLog(@"error, file not found: %@", strSoundFilePath);
    }
}



@end
