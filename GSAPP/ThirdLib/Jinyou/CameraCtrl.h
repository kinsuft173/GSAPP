//
//  CameraCtrl.h
//  testCamera
//
//  Created by lijingyou on 15/7/26.
//  Copyright (c) 2015年 lijingyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VPImageCropperViewController.h"

@protocol CarmeraDelegate <NSObject>

-(void)getImage:(UIImage *)image whichNum:(NSUInteger)count;

@end

@interface CameraCtrl : UIImagePickerController
@property (nonatomic,strong)UIImage *myImage;
@property (assign) NSUInteger count;
@property (weak,nonatomic)id<CarmeraDelegate> cameraDelegate;
@end
