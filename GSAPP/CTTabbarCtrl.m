//
//  CTTabbarCtrl.m
//  ksbk
//
//  Created by 胡昆1 on 1/4/15.
//  Copyright (c) 2015 cn.chutong. All rights reserved.
//

#import "CTTabbarCtrl.h"
#import "HKCommen.h"

@interface CTTabbarCtrl ()

@property (nonatomic, assign) BOOL screensaverLaunched;

@end

@implementation CTTabbarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTabBarItemUI];
    [self configNav];
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
- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];

    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    if (!self.screensaverLaunched) {
//        self.screensaverLaunched = YES;
//        [self performSegueWithIdentifier:@"segue_screensaver" sender:nil];
//    }
}

- (void)setTabBarItemUI
{

    UIImage* firstItemSelected      = [UIImage imageNamed:@"tab_home_pre"];


    UIImage* secondItemSelected     = [UIImage imageNamed:@"tab_experts_pre"];
    

    UIImage* thirdItemSelected      = [UIImage imageNamed:@"tab_message_pre"];
    

    

    UIImage* searchItemSelected       = [UIImage imageNamed:@"tab_center_pre"];
    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];

    
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];

    
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];
    
    UITabBarItem *tabBarItemSearch = [self.tabBar.items objectAtIndex:3];

    
    firstItemSelected = [firstItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondItemSelected = [secondItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdItemSelected = [thirdItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchItemSelected = [searchItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    

    tabBarItem1.selectedImage = firstItemSelected;
    tabBarItem2.selectedImage = secondItemSelected;
    tabBarItem3.selectedImage = thirdItemSelected;

    tabBarItemSearch.selectedImage = searchItemSelected;
    

    
    //set tabbarItems font
    for (UITabBarItem* item in self.tabBar.items) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [item setImageInsets:insets];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"Helvetica" size:13.0], UITextAttributeFont,[HKCommen getColor:@"666666"],UITextAttributeTextColor, nil]
                            forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"Helvetica" size:13.0], UITextAttributeFont,[HKCommen getColor:@"4fc1e9"],UITextAttributeTextColor, nil]
                            forState:UIControlStateSelected];
    }
    
    
}


- (void)configNav
{
    

    [[UINavigationBar appearance] setBarTintColor:[HKCommen getColor:@"4fc1e9"]];
    if (IOS8) {
//        [[UINavigationBar appearance] setTranslucent:NO];
    }
    
//    [[UINavigationBar appearance] setTranslucent:NO];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    [UINavigationBar appearance].titleTextAttributes =  [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

#pragma mark - Configuring the view’s layout behavior

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}



@end
