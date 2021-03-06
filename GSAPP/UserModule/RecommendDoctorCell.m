//
//  RecommendDoctorCell.m
//  GSAPP
//
//  Created by lijingyou on 15/7/11.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "RecommendDoctorCell.h"
#import <UIImageView+WebCache.h>
#import "GSExpert.h"
#import "MJExtension.h"

@implementation RecommendDoctorCell

- (void)awakeFromNib {
    
    // Initialization code
    if ([self.contentView respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        self.contentView.preservesSuperviewLayoutMargins = NO;
    }
}

-(void)customUI:(NSMutableArray *)array
{
    if (self.DoctorRecommed_Scroll.tag == 1001 || array.count == 0) {
        
        return;
        
    }
    
    self.DoctorRecommed_Scroll.tag = 1001;
    
    
    
    self.DoctorRecommed_Scroll.contentSize = CGSizeMake(DOCTOR_RECOMMEND_Cell_WIDTH*array.count, SCREEN_WIDTH*DOCTOR_RECOMMEND_CELL_RATIO);
    
    for (int i = 0; i < array.count; i++) {
        
        NSDictionary* item = [array objectAtIndex:i];
        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(DOCTOR_RECOMMEND_Cell_WIDTH*i,0, DOCTOR_RECOMMEND_Cell_WIDTH,SCREEN_WIDTH*0.4)];
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 70,70)];
        imageView.layer.cornerRadius = 4.0;
        imageView.layer.masksToBounds = YES;
        
        UILabel *lbl_name=[[UILabel alloc]initWithFrame:CGRectMake(16, 80, 37, 12)];
        lbl_name.font=[UIFont systemFontOfSize:12.0];
        [lbl_name setTextColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]];
    //    [lbl_name setText:item[@"name"]];
        if([[item[@"name"] class] isSubclassOfClass:[NSString class]]){
        
            lbl_name.text = item[@"name"];
        
        }
        
        UILabel *lbl_position=[[UILabel alloc]initWithFrame:CGRectMake(10, 96, 50, 12)];
        lbl_position.font=[UIFont systemFontOfSize:12.0];
        [lbl_position setTextColor:[UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0]];
      //  [lbl_position setText:item[@"address"]];
        
        if ([[item[@"address"] class] isSubclassOfClass:[NSString class]]) {
            
            lbl_position.text = item[@"address"];
            
        }
        
        if ([item objectForKey:@"doctorFiles"]) {
            
            NSArray* array = [item objectForKey:@"doctorFiles"];
        
            
            if (array.count != 0) {
                
                NSLog(@"URL = %@",[[[item objectForKey:@"doctorFiles"] objectAtIndex:0] objectForKey:@"path"]);
                
                NSArray* files = [item objectForKey:@"doctorFiles"];
                
                for (int i = 0; i < files.count; i ++) {
                    
                    Doctorfiles* file = [Doctorfiles  objectWithKeyValues:[files objectAtIndex:i]];
                    
                    if (file.type == 1) {
                        
                        
                        [imageView sd_setImageWithURL:file.path
                                             placeholderImage:[UIImage imageNamed:HEADPHOTO_PLACEHOUDER] options:SDWebImageContinueInBackground];
                    }
                    
                }
            }
            

            
        }
        
     
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
       
        CGRect rect = view.frame;
        rect.origin.x = 0;
        button.frame = rect;

        [button addTarget:self action:@selector(goToDoctorDetail:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        
        [view addSubview:imageView];
        [view addSubview:lbl_name];
        [view addSubview:lbl_position];
        [view addSubview:button];

        
        [self.DoctorRecommed_Scroll addSubview:view];
        
        
    }
}

-(void)test
{
    NSLog(@"测试");
}

-(void)goToDoctorDetail:(UIButton*)btn
{
    [self.delegate pushToDetailView:btn.tag];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
