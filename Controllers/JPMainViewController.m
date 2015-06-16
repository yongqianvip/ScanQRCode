//
//  JPMainViewController.m
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import "JPMainViewController.h"
#import "JPHeader.h"
#import "QBPopupMenu.h"
#import "RKNotificationHub.h"
#import <CoreLocation/CoreLocation.h>
@interface JPMainViewController ()<JPBaseRequestDelegate,CLLocationManagerDelegate>
{
    UIButton *scanBtn;
    JPBaseRequester *scanRequester;
    UILabel *_requestResultLabel;
    UIActivityIndicatorView *toScanActivityIndicator;

    UIActivityIndicatorView *resultActivityIndicator;
    CLLocationManager *_locationManager;
}


@end

@implementation JPMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatScanButton];
    [self creatShowMessageLable];
    [self.view setBackgroundColor:[self colorWithHexColorString:@"#eaecee"]];
    
    
}

-(void)creatScanButton
{
    scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn setFrame:CGRectMake(85, self.view.frame.size.height - (IPHONE5?200:170), 150, 150)];
    [scanBtn setImage:[UIImage imageNamed:@"start_scan"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(startScanQR) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:scanBtn];
    
    toScanActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:                         UIActivityIndicatorViewStyleWhiteLarge];
    [toScanActivityIndicator setColor:[UIColor colorWithRed:0.880 green:0.419 blue:0.503 alpha:1.000]];
    [toScanActivityIndicator setFrame:CGRectMake(0, 0, 30, 30)];
    toScanActivityIndicator.center = CGPointMake(scanBtn.frame.size.width/2, scanBtn.frame.size.height/2);
    toScanActivityIndicator.hidden = YES;
    [scanBtn addSubview:toScanActivityIndicator];
    
}
-(void)startScanQR
{
    [JPSoundPlayer playSoundWAVWithName:@"press"];
    [toScanActivityIndicator startAnimating];
    [self performSelector:@selector(gotoScan) withObject:nil afterDelay:0.1];
    [_requestResultLabel setText:@""];
}

-(void)gotoScan
{
    RKNotificationHub *hud = [[RKNotificationHub alloc]initWithView:scanBtn];
    [hud increment];
    [hud pop];
    [hud setCircleColor:[UIColor colorWithRed:0.98 green:0.66 blue:0.2 alpha:1]
             labelColor:[UIColor whiteColor]];

    hud.count = 3;
    
//    QBPopupMenuItem *item = [QBPopupMenuItem itemWithTitle:@"Text" target:self action:@selector(action:)];
////    QBPopupMenuItem *item2 = [QBPopupMenuItem itemWithImage:[UIImage imageNamed:@"image"] target:self action:@selector(action:)];
//    QBPopupMenuItem *item2 = [QBPopupMenuItem itemWithTitle:@"Text2" target:self action:@selector(action:)];
//
//    QBPopupMenu *popupMenu = [[QBPopupMenu alloc] initWithItems:@[item, item2]];
//    
//    //    [popupMenu showInView:self.view targetRect:... animated:YES];
//    [popupMenu showInView:self.view targetRect:scanBtn.frame animated:YES];

//    
//    JPScanViewController *scanVC = [[JPScanViewController alloc]init];
//    scanVC.delegate = self;
//    [self.navigationController presentViewController:scanVC animated:YES completion:^{
//        [toScanActivityIndicator stopAnimating];
//    }];
}
-(void)action:(QBPopupMenuItem *)item{
    
}
-(void)creatShowMessageLable
{
    UILabel *textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    [textLabel1 setText:@"二维码信息:"];
    [textLabel1 setFont:[UIFont boldSystemFontOfSize:18.0]];
    [self.view addSubview:textLabel1];

    self.scanResultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, textLabel1.frame.origin.y + textLabel1.frame.size.height, self.view.frame.size.width,IPHONE5?160:90)];
    [_scanResultLabel setBackgroundColor:[self colorWithHexColorString:@"#eaecee"]];
    [_scanResultLabel setNumberOfLines:0];
    [_scanResultLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_scanResultLabel];
    
    UILabel *textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _scanResultLabel.frame.origin.y +_scanResultLabel.frame.size.height + 10, self.view.frame.size.width, 30)];
    [textLabel2 setText:@"扫描结果:"];
    [textLabel2 setFont:[UIFont boldSystemFontOfSize:18.0]];
    [self.view addSubview:textLabel2];
    
    _requestResultLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,textLabel2.frame.origin.y + textLabel2.frame.size.height, self.view.frame.size.width, 70)];
    [_requestResultLabel setBackgroundColor:[UIColor clearColor]];
//    [_requestResultLabel setBackgroundColor:[self colorWithHexColorString:@"#eaecee"]];
    [_requestResultLabel setNumberOfLines:0];
    [_requestResultLabel setFont:[UIFont systemFontOfSize:14.0]];
    [_requestResultLabel setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:_requestResultLabel];

    resultActivityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:                         UIActivityIndicatorViewStyleWhiteLarge];
    [resultActivityIndicator setColor:[UIColor colorWithRed:0.880 green:0.419 blue:0.503 alpha:1.000]];
    [resultActivityIndicator setFrame:CGRectMake(0, 0, 30, 30)];
    resultActivityIndicator.center = self.view.center; //CGPointMake(_requestResultLabel.frame.size.width/2, _requestResultLabel.frame.size.height/2);
    resultActivityIndicator.hidden = YES;
    [self.view addSubview:resultActivityIndicator];
    
}

-(UIColor *)colorWithHexColorString:(NSString *)hexColorString
{
    if ([hexColorString length] <6){//长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString=[hexColorString lowercaseString];
    if ([tempString hasPrefix:@"0x"]){//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }else if ([tempString hasPrefix:@"#"]){//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6){
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:1.0f];
}


-(void)postRequestWithParameter:(NSString *)parameter
{
    [resultActivityIndicator startAnimating];
    if (scanRequester != nil) {
        [scanRequester.connection cancel];
    }
    scanRequester = [[JPBaseRequester alloc] init];
    scanRequester.delegate = self;
    [scanRequester startPostRequestWithURL:kGetVerificationInfoURL bodyString:kGetVerificationInfoBody(parameter)];
}

- (void)requester:(JPBaseRequester *)requester didFinishRequestWithData:(NSMutableData *)requestData
{
    [resultActivityIndicator stopAnimating];
    NSDictionary *resultDic = [JPJsonParser dictionaryByParseData: requestData];
    NSLog(@"返回结果%@",resultDic);
    int status = [[resultDic objectForKey:@"status"]intValue];
    if (status) {
        NSString *message = [resultDic objectForKey:@"info"];
        UIAlertView *fail = [[UIAlertView alloc]initWithTitle:@"成功" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [fail show];
    }else{
        NSString *message = [resultDic objectForKey:@"info"];
        UIAlertView *fail = [[UIAlertView alloc]initWithTitle:@"失败" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [fail show];
    }
    [_requestResultLabel setText:[resultDic objectForKey:@"info"]];

}
- (void)requester:(JPBaseRequester *)requester didFailRequestWithError:(NSError *)error
{
    [resultActivityIndicator stopAnimating];
    [self netWorkError:[error code] alertTitle:@"" errorDescription:[error description]];
}
-(void)netWorkError:(NSInteger)errorCode alertTitle:(NSString *)title errorDescription:(NSString *)description
{
    NSString *message = nil;
    switch (errorCode) {
        case -1:
            message = @"未知错误";
            break;
        case -1000:
            message = @"无效链接";//NSURLErrorBadURL
            break;
        case -1009:
            message = @"当前网络不可用\n请检查网络连接";
            break;
        default:
            message = @"网络请求失败";//[NSString stringWithFormat:@"未知错误,%d,%@",errorCode ,description];
            break;
    }
    JPDialogView *dialogView = [[JPDialogView alloc]init];
    [dialogView showDialogViewWithMsg:message];
    [dialogView performSelector:@selector(hideDialogView:) withObject:dialogView afterDelay:1.5];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
