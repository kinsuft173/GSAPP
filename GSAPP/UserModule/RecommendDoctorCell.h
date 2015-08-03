//
//  RecommendDoctorCell.h
//  GSAPP
//
//  Created by lijingyou on 15/7/11.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKCommen.h"

@protocol goDetail <NSObject>

-(void)pushToDetailView:(NSInteger)tag;

@end

@interface RecommendDoctorCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *DoctorRecommed_Scroll;
@property (nonatomic,weak) id<goDetail> delegate;
-(void)customUI:(NSMutableArray*)array;
@end
