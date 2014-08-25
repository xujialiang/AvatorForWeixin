//
//  ViewController.h
//  testtemp
//
//  Created by jialiang.xu on 14-8-22.
//  Copyright (c) 2014年 elliott. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnSelectImage;
@property (weak, nonatomic) IBOutlet UIImageView *avator;
@property (weak, nonatomic) IBOutlet UISlider *numbervalue;
@property (weak, nonatomic) IBOutlet UILabel *txtnumber;
@property (weak, nonatomic) IBOutlet UIButton *btnsave;
@property (weak, nonatomic) IBOutlet UIView *saveview;

@end
