//
//  JPDialogView.h
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPDialogView : UIView


-(void)showDialogViewWithMsg:(NSString *)dialogMsg;
-(void)hideDialogView:(UIView *)dialogView;

@end
