//
//  JPScanViewController.m
//  ScanQRCode
//
//  Created by YYQ on 14-8-25.
//  Copyright (c) 2014年 YYQ. All rights reserved.
//

#import "JPScanViewController.h"
#import "JPHeader.h"

@interface JPScanViewController ()
{
    UIButton *openFlashLightButton;
}

@end

@implementation JPScanViewController

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
    
    [self setupCamera];
    
    UIView *alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:alphaView];
    [alphaView setBackgroundColor:[UIColor colorWithWhite:0.688 alpha:0.700]];

	UIButton * cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setBackgroundColor:[UIColor colorWithRed:0.866 green:0.148 blue:0.285 alpha:0.700]];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    cancleButton.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    [cancleButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancleButton];
    
    openFlashLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [openFlashLightButton setFrame:CGRectMake(20, 100, 50, 30)];
    [openFlashLightButton setTitle:@"开灯" forState:UIControlStateNormal];
    [openFlashLightButton setBackgroundColor:[UIColor colorWithRed:0.926 green:0.956 blue:0.584 alpha:0.600]];
    [self.view addSubview:openFlashLightButton];
    [openFlashLightButton addTarget:self action:@selector(openFlashlight) forControlEvents:UIControlEventTouchUpInside];
    
//    no "pick_bg" icon
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 100, self.view.frame.size.width - 10 * 2, self.view.frame.size.width - 10 * 2)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(50, 110, 220, 2)];
    _line.image = [UIImage imageNamed:@"line_scan"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(upAndDownAnimation) userInfo:nil repeats:YES];
    
}
-(void)upAndDownAnimation
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(50, 110+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}
-(void)backAction
{
    [timer invalidate];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    // support QRCode Type   ----  AVMetadataObjectTypeQRCode
    _output.metadataObjectTypes =@[AVMetadataObjectTypeQRCode];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspect;
    _preview.frame =CGRectMake(0,0,320,self.view.frame.size.height);//(20,110,280,280);
    [self.view.layer insertSublayer:self.preview atIndex:1];
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{

    NSString *stringValue = @"";
    if ([metadataObjects count] != 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
    }
//    [self performSelector:@selector(backAction) withObject:nil afterDelay:5];
//    Get message , go back right now
    [self backAction];
    [_session stopRunning];

    [JPSoundPlayer playSoundWAVWithName:@"qrcode_found"];
    [((JPMainViewController *)self.delegate).scanResultLabel setText:stringValue];
//    [self.delegate postRequestWithParameter:stringValue];
}

-(void)openFlashlight
{
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device.torchMode == AVCaptureTorchModeOff) {
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOn];
        [device unlockForConfiguration];
        [openFlashLightButton setTitle:@"关灯" forState:UIControlStateNormal];
    }else{
        [device lockForConfiguration:nil];
        [device setTorchMode:AVCaptureTorchModeOff];
        [device unlockForConfiguration];
        [openFlashLightButton setTitle:@"开灯" forState:UIControlStateNormal];
    }
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
