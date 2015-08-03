//
//  ConsultationInfoCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/17.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ConsultationInfoCtrl.h"
#import "HKCommen.h"
#import "NetworkManager.h"

@interface ConsultationInfoCtrl ()

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;

@end

@implementation ConsultationInfoCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.scrollView.contentSize = CGSizeMake( SCREEN_WIDTH, 1300);
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

- (IBAction)confirm:(id)sender
{
    [[NetworkManager shareMgr] server_updateOrderWithDic:nil completeHandle:^(NSDictionary * dic) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
}

- (IBAction)confuse:(id)sender
{
    [[NetworkManager shareMgr] server_updateOrderWithDic:nil completeHandle:^(NSDictionary * dic) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];


}

@end
