//
//  UserMainUiCtrl.m
//  GSAPP
//
//  Created by 胡昆1 on 6/10/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "UserMainUiCtrl.h"
#import "HKCommen.h"

#define BANNER_COUNT 3
#define DOCTOR_RECOMMEND_COUNT 20
#define DOCTOR_RECOMMEND_Cell_WIDTH 100

#define DOCTOR_RECOMMEND_RATIO 169/320
#define DOCTOR_RECOMMEND_CELL_RATIO 0.4

@interface UserMainUiCtrl ()

@property (nonatomic, strong) IBOutlet UIScrollView* scrollViewBanner;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollViewRecommend;

@end

@implementation UserMainUiCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self initUI];
    
//    [self scrollViewSetImages];
    
}

- (void)initUI
{
    
    self.scrollViewBanner.contentSize = CGSizeMake(SCREEN_WIDTH*(BANNER_COUNT+1), SCREEN_WIDTH*DOCTOR_RECOMMEND_RATIO);
    self.scrollViewRecommend.contentSize = CGSizeMake(DOCTOR_RECOMMEND_Cell_WIDTH*DOCTOR_RECOMMEND_COUNT, SCREEN_WIDTH*DOCTOR_RECOMMEND_CELL_RATIO);
    
}

- (void)scrollViewSetImages
{
    for (int i = 0; i < BANNER_COUNT + 1; i++) {
        
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_WIDTH*DOCTOR_RECOMMEND_RATIO)];
        
        [self.scrollViewBanner addSubview:imageView];
        
        imageView.image = [UIImage imageNamed:[NSString  stringWithFormat:@"bg%d.png",i%BANNER_COUNT]];
        
    }
    
    for (int i = 0; i < DOCTOR_RECOMMEND_COUNT; i++) {
        
        
        UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(DOCTOR_RECOMMEND_Cell_WIDTH*i,0, DOCTOR_RECOMMEND_Cell_WIDTH,SCREEN_WIDTH*DOCTOR_RECOMMEND_CELL_RATIO)];
        
        [self.scrollViewRecommend addSubview:imageView];
        
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"bg%d.png",i%4]];
        
    }


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
