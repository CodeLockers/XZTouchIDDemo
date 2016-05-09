//
//  ViewController.m
//  XZTouchIDDemo
//
//  Created by 徐章 on 16/5/9.
//  Copyright © 2016年 徐章. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)touchIDBtn_Pressed:(id)sender {
    
#warning IOS7不支持第三方APP使用TouchID
    
    //初始化上下文对象
    LAContext *context = [[LAContext alloc] init];
    //错误对象
    NSError *error = nil;
    //首先使用canEvaluatePolicy 判断设备支持状态
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"TouchID 测试" reply:^(BOOL success, NSError * _Nullable error) {
           
            if (success) {
                NSLog(@"TouchID认证成功");
            
            }else{
                
                switch (error.code) {
                    case LAErrorSystemCancel:
                        NSLog(@"切换到其他APP，系统取消验证Touch ID");
                        break;
                    
                    case LAErrorUserCancel:
                        NSLog(@"用户取消验证Touch ID");
                        break;
                        
                    case LAErrorUserFallback:
                        NSLog(@"用户选择输入密码");
                        break;
                    default:
                        break;
                }
            }
            
        }];
    }
    else{
    
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
                NSLog(@"设备Touch ID不可用，用户未录入");
                break;
            case LAErrorPasscodeNotSet:
                NSLog(@"系统未设置密码");
                break;
            case LAErrorTouchIDNotAvailable:
                NSLog(@"设备Touch ID不可用，例如未打开");
                break;
            default:
                break;
        }
    }
}

@end
