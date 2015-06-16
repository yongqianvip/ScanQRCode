//
//  JPMainViewController.h
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPMainViewController : UIViewController

@property (nonatomic ,strong)UILabel *scanResultLabel;


-(void)postRequestWithParameter:(NSString *)parameter;


@end
