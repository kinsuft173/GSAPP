//
//  starView.h
//  eCarter
//
//  Created by lijingyou on 15/7/4.
//  Copyright (c) 2015年 kinsuft173. All rights reserved.
//

#import <UIKit/UIKit.h>
#define star_0 @"btn_start_pre"
#define star_1 @"btn_start"


@interface starView : UIView

@property (strong,nonatomic)NSArray *array_Star;
@property (assign) CGFloat whichValue;

@property (weak, nonatomic) IBOutlet UIButton *img_star1;
@property (weak, nonatomic) IBOutlet UIButton *img_star2;
@property (weak, nonatomic) IBOutlet UIButton *img_star3;
@property (weak, nonatomic) IBOutlet UIButton *img_star4;
@property (weak, nonatomic) IBOutlet UIButton *img_star5;

-(void)setStarForValue:(CGFloat)value;
@end
