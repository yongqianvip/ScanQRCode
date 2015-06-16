//
//  JPHeader.h
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//


#import "JPBaseRequester.h"
#import "JPJsonParser.h"
#import "JPAppDelegate.h"
#import "JPMainViewController.h"
#import "JPScanViewController.h"
#import "JPDialogView.h"
#import "JPSoundPlayer.h"

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)


#define kGetVerificationInfoURL [NSURL URLWithString:@"http://115.28.163.208/index.php/Api/Station/getVerificationInfo"]
#define kGetVerificationInfoBody(parameter)  [NSString stringWithFormat: @"verificationCode=%@",parameter]





