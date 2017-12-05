//
//  CameraManager.m
//  aaaaa
//
//  Created by huafangT on 17/7/25.
//  Copyright © 2017年 huafangT. All rights reserved.
//

#import "CameraManager.h"
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "NSObject+CurrentC.h"
@interface CameraManager()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic, strong)UIImagePickerController * pickerView;

@property (nonatomic, strong) UIViewController *currentVC;

@end

@implementation CameraManager

- (void)dealloc{
    
}

- (UIImagePickerController *)pickerView{
    if(!_pickerView){
        _pickerView = [[UIImagePickerController alloc]init];
    }
    return _pickerView;
}

- (UIViewController *)currentVC{
    if(!_currentVC){
        _currentVC = self.getCurrentViewController;
    }
    return _currentVC;
}

+ (CameraManager *)shareInstance
{
    static CameraManager * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (void)picSourceTypeCamera{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSLog(@"您的设备不支持拍照功能");
        return;
    }
    
     PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *appName = [infoDict objectForKey:@"CFBundleName"];
         NSString *message = [NSString stringWithFormat:@"请前往 -> [设置 - 隐私 - 照片 - %@ 打开访问开关", appName];
        return;
    }
    
    self.pickerView.delegate = self;
    self.pickerView.sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([self.currentVC respondsToSelector:@selector(presentViewController:animated:completion:)]){
        [self.currentVC presentViewController:_pickerView animated:YES completion:nil];
    }
}

#pragma mark -
#pragma mark imagePick Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *pickerImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [[UIApplication sharedApplication] setStatusBarStyle:0    animated:YES];
    [picker dismissViewControllerAnimated:YES completion:^void{
        if(self.imgBlock){
            self.imgBlock(pickerImage);
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
