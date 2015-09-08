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
    
    [self getModel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        
        
//        [cell customUI:self.array_DoctorRecommend];
        
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




