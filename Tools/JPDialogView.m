//
//  JPDialogView.m
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import "JPDialogView.h"
#import "JPHeader.h"
@implementation JPDialogView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)showDialogViewWithMsg:(NSString *)dialogMsg
{
    self.frame = CGRectMake(0, 0, 150, 60);
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    self.center = CGPointMake(win.frame.size.width/2, win.frame.size.height/2);
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.0;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 60)];
    label.text = dialogMsg;
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16.0];
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.layer.cornerRadius = 8.0;
    [self addSubview:label];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5f];
    self.alpha = 0.8;
    [UIView commitAnimations];
    [[[UIApplication sharedApplication] delegate].window addSubview:self];
}

-(void)hideDialogView:(UIView *)dialogView
{
    [UIView animateWithDuration:0.1 animations:^{
        dialogView.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            dialogView.transform = CGAffineTransformMakeScale(0.8, 0.8);
            [UIView animateWithDuration:0.2 animations:^{
                dialogView.alpha = 0;
            } completion:^(BOOL finished) {
            }];
        } completion:^(BOOL finished) {
            [dialogView removeFromSuperview];
        }];
        
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
