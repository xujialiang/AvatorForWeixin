//
//  ViewController.m
//  testtemp
//
//  Created by jialiang.xu on 14-8-22.
//  Copyright (c) 2014年 elliott. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DoImagePickerController.h"

@interface ViewController (){
}
@property (nonatomic,strong) NSString *username;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    self.btnSelectImage.rac_command=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        DoImagePickerController *cont = [[DoImagePickerController alloc] initWithNibName:@"DoImagePickerController" bundle:nil];
        cont.delegate = self;
        cont.nMaxCount = 1;     // larger than 1
        cont.nColumnCount = 3;  // 2, 3, or 4
        
        cont.nResultType = DO_PICKER_RESULT_UIIMAGE; // get UIImage object array : common case
        // if you want to get lots photos, you had better use DO_PICKER_RESULT_ASSET.
        
        [self presentViewController:cont animated:YES completion:nil];
        return [RACSignal empty];
    }];
    
    [[self.numbervalue rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        NSString *number=[NSString stringWithFormat:@"%.0f",((UISlider *)x).value];
        self.txtnumber.text=number;
        NSLog(@"%@",x);
    }];
    
    self.btnsave.rac_command=[[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        UIImage *image=[self getImageFromView:self.saveview];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
        
        return [RACSignal empty];
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage *)getImageFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}

#pragma mark - DoImagePickerControllerDelegate
- (void)didCancelDoImagePickerController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didSelectPhotosFromDoImagePickerController:(DoImagePickerController *)picker result:(NSArray *)aSelected
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (picker.nResultType == DO_PICKER_RESULT_UIIMAGE)
    {
        
        for (int i = 0; i < MIN(4, aSelected.count); i++)
        {
            self.avator.image=aSelected[i];
        }
    }
}
@end
