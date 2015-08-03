//
//  SelectDateCtrl.h
//  GSAPP
//
//  Created by walter on 15/7/29.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectDateDelegate <NSObject>

- (void)getDateData:(NSString*)date;

@end

@interface SelectDateCtrl : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbl_Date;
@property (strong, nonatomic) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *txt_Date;
@property (nonatomic,weak)id <SelectDateDelegate> delegate;
@end
