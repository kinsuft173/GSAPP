//
//  ExpertCertificationViewController.m
//  GSAPP
//
//  Created by kinsuft173 on 15/9/6.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ExpertCertificationViewController.h"
#import "NetWorkManager.h"

@interface ExpertCertificationViewController ()

@property (nonatomic ,strong) IBOutlet UIImageView* img;

@end

@implementation ExpertCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.img sd_setImageWithURL:self.strUrl
                         placeholderImage:[UIImage imageNamed:@"loading-ios"] options:SDWebImageContinueInBackground];
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
