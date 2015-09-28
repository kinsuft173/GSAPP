//
//  MainDoctorPageCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/11.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "MainDoctorPageCtrl.h"
#import "AdvertisementCell.h"
#import "ChoiceOfDoctorCell.h"
#import "RecommendDoctorCell.h"
#import "MainDoctorPageCtrl.h"
#import "NetworkManager.h"
#import "UserDataManager.h"
#import "ExpertSelectOrderCtrl.h"
#import "GSExpert.h"
#import "HKMapManager.h"

#define TabbarItemNums 4.0

@interface MainDoctorPageCtrl ()
@property (strong,nonatomic)NSMutableArray *array_advertisement;
@property (strong,nonatomic)NSMutableArray * array_DoctorRecommend;
@end

@implementation MainDoctorPageCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.array_advertisement=[[NSMutableArray alloc] initWithObjects:@"bg0",@"bg1",@"bg2",@"bg3", nil];
//    self.array_DoctorRecommend=[[NSMutableArray alloc] initWithObjects:@"bg0",@"bg1",@"bg2",@"bg3",@"bg1",@"bg2", nil];
    
    [HKCommen addHeadTitle:@"高手" whichNavigation:self.navigationItem];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redCircleShowing) name:kBandgeNotification object:nil];
    
    [self getModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)redCircleShowing
{
    [self.myTable reloadData];
    
    if ([HKMapManager  shareMgr].messageNumber.integerValue == 0) {
        
//        CTTabbarCtrl* vc = self.tabBarController;
        
        [self removeBadgeOnItemIndex:2];
        
        
    }else{
        
//        CTTabbarCtrl* vc = self.tabBarController;
        
        [self showBadgeOnItemIndex:2];
        
    }
}

- (void)showBadgeOnItemIndex:(int)index{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 3;//圆形
    badgeView.backgroundColor = [UIColor redColor];//颜色：红色
    CGRect tabFrame = self.tabBarController.tabBar.frame;
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width) + 5;
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 6, 6);//圆形大小为10
    [self.tabBarController.tabBar addSubview:badgeView];
}


//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.tabBarController.tabBar.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}




- (void)getModel
{
    [[NetworkManager shareMgr] server_fetchAdvertisementWithDic:nil completeHandle:^(NSDictionary *responseBanner) {
       

        
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"recommended", nil];
        
        [[NetworkManager shareMgr] server_fetchDoctorsWithDic:dic completeHandle:^(NSDictionary * responeseDoc) {
            
            self.array_advertisement = [[responseBanner objectForKey:@"data"] objectForKey:@"items"];

            self.array_DoctorRecommend = [[responeseDoc objectForKey:@"data"] objectForKey:@"items"];
            
            NSLog(@"array_DoctorRecommend = %@",[self.array_DoctorRecommend class]);

            [self.myTable reloadData];

        }];
    
        
    }];
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 3;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 209;
    }
    else if (indexPath.section==1)
    {
        
        if ([UIScreen mainScreen].bounds.size.width>=375) {
            return 181;
        }
        else
        {
            return 161;
        }
    }
    else if (indexPath.section==2)
    {
        return 165;
    }
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId_first = @"AdvertisementCell";
    static NSString* CellId_second = @"ChoiceOfDoctorCell";
    static NSString* CellId_third = @"RecommendDoctorCell";

    if (indexPath.section==0) {
        
        AdvertisementCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId_first];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId_first owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        [cell customUI:self.array_advertisement];


        
        return cell;
    }
    
    else if (indexPath.section==1)
    {
    
        ChoiceOfDoctorCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId_second];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId_second owner:self options:nil];
            
            if ([[UserDataManager shareManager].userType isEqualToString:ExpertType]) {
                
                if ([UIScreen mainScreen].bounds.size.width>=375) {
                    cell = [topObjects objectAtIndex:1];
                }
                else
                {
                cell = [topObjects objectAtIndex:2];
                }
                
                [cell.btnToOrder addTarget:self action:@selector(goOrder:) forControlEvents:UIControlEventTouchUpInside];
                
            }else{
                
                if ([UIScreen mainScreen].bounds.size.width>=375) {
                    cell = [topObjects objectAtIndex:0];
                }
                else
                {
                    cell = [topObjects objectAtIndex:3];
                }
            
            }
            
            [cell.btnDiagnose addTarget:self action:@selector(goDoctor:) forControlEvents:UIControlEventTouchUpInside];
            [cell.btnDiagnoseAndShoushu addTarget:self action:@selector(goDoctor:) forControlEvents:UIControlEventTouchUpInside];
            
            
        }
        
        return cell;
    }
    else if (indexPath.section==2)
    {
    
        RecommendDoctorCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId_third];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId_third owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        
        
        [cell customUI:self.array_DoctorRecommend];
        
        cell.delegate=self;
        
        return cell;
    }
    
    return nil;

}

-(void)pushToDetailView:(NSInteger)index
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"User" bundle:nil];
    ExpertDetailCtrl *vc=[story instantiateViewControllerWithIdentifier:@"ExpertDetailCtrl"];
    
    NSDictionary* item = [self.array_DoctorRecommend objectAtIndex:index];
    
    GSExpert* expert = [GSExpert objectWithKeyValues:item];
    
    vc.expert = expert;
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)goDoctor:(id)sender
{
    self.tabBarController.selectedIndex = 1;
}


- (void)goOrder:(id)sender
{
    ExpertSelectOrderCtrl* vc = [[ExpertSelectOrderCtrl alloc] initWithNibName:@"ExpertSelectOrderCtrl" bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end




