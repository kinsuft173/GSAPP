//
//  CTTabbarCtrl.m
//  ksbk
//
//  Created by 胡昆1 on 1/4/15.
//  Copyright (c) 2015 cn.chutong. All rights reserved.
//

#import "CTTabbarCtrl.h"
#import "CTCommon.h"
#import "ICSDrawerController.h"

@interface CTTabbarCtrl ()<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property (nonatomic, assign) BOOL screensaverLaunched;

@end

@implementation CTTabbarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTabBarItemUI];
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
    UIImage* firstItemUnSelected    = [UIImage imageNamed:@"FirstPage.png"];
    UIImage* firstItemSelected      = [UIImage imageNamed:@"FirstPageS.png"];

    
    UIImage* secondItemUnSelected   = [UIImage imageNamed:@"SecondPage.png"];
    UIImage* secondItemSelected     = [UIImage imageNamed:@"SecondPageS.png"];
    
    
    UIImage* thirdItemUnSelected    = [UIImage imageNamed:@"zixunPage"];
    UIImage* thirdItemSelected      = [UIImage imageNamed:@"zixunPageS"];
    
    
    UIImage* zeroItemUnSelected     = [UIImage imageNamed:@"LastPage.png"];
    UIImage* zeroItemSelected       = [UIImage imageNamed:@"LastPageS.png"];
    
    UIImage* searchItemUnSelected     = [UIImage imageNamed:@"searchN"];
    UIImage* searchItemSelected       = [UIImage imageNamed:@"searchY"];
    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:0];

    
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:1];

    
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:2];

    
    UITabBarItem *tabBarItem0 = [self.tabBar.items objectAtIndex:4];
    
    UITabBarItem *tabBarItemSearch = [self.tabBar.items objectAtIndex:3];

    
    firstItemSelected = [firstItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secondItemSelected = [secondItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    thirdItemSelected = [thirdItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    zeroItemSelected = [zeroItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    searchItemSelected = [searchItemSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    if (IOS7) {
        tabBarItem1.selectedImage = firstItemSelected;
        tabBarItem2.selectedImage = secondItemSelected;
        tabBarItem3.selectedImage = thirdItemSelected;
        tabBarItem0.selectedImage = zeroItemSelected;
        tabBarItemSearch.selectedImage = searchItemSelected;
        
    }
    
//        [tabBarItem1 setFinishedSelectedImage:firstItemSelected withFinishedUnselectedImage:firstItemUnSelected];
//        [tabBarItem2 setFinishedSelectedImage:secondItemSelected withFinishedUnselectedImage:secondItemUnSelected];
//        [tabBarItem3 setFinishedSelectedImage:thirdItemSelected withFinishedUnselectedImage:thirdItemUnSelected];
//        [tabBarItem0 setFinishedSelectedImage:zeroItemSelected withFinishedUnselectedImage:zeroItemUnSelected];
//    }
    
    //set tabbarItems font
    for (UITabBarItem* item in self.tabBar.items) {
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        [item setImageInsets:insets];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"Helvetica" size:11.0], UITextAttributeFont,[CTCommon getColor:@"666666"],UITextAttributeTextColor, nil]
                            forState:UIControlStateNormal];
        
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"Helvetica" size:11.0], UITextAttributeFont,[CTCommon getColor:@"e7373c"],UITextAttributeTextColor, nil]
                            forState:UIControlStateSelected];
    }
    
    
//    [self setSelectedIndex:0];
    
    
//    
//    UIImage *backgroundImage = [UIImage imageNamed:@"daohang_bg.png"];
//    
//    [UITabBar appearance].backgroundImage = backgroundImage;
    
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

#pragma mark - ICSDrawerControllerPresenting

- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}

#pragma mark - Open drawer button

- (void)openDrawer:(id)sender
{
    [self.drawer open];
}



@end
