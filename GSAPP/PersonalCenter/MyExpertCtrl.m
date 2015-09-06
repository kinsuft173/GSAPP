//
//  MyExpertCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/15.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "MyExpertCtrl.h"
#import "HKCommen.h"
#import "ExpertCell.h"
#import "ExpertDetailCtrl.h"
#import "NetWorkManager.h"
#import "UserDataManager.h"

@interface MyExpertCtrl ()

@property (nonatomic, strong) NSArray* arrayModel;

@end

@implementation MyExpertCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

-(void)initUI
{
    [HKCommen addHeadTitle:@"我的专家" whichNavigation:self.navigationItem];
    
    [HKCommen setExtraCellLineHidden:self.myTable];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    [self getModel];
}

- (void)getModel
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:@"favoriteDoctor,favoriteDoctor.doctorFiles",@"expand",[UserDataManager shareManager].userId,@"and[doctor_id]", nil];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    [[NetworkManager shareMgr] server_fetchFavoritesWithDic:dic completeHandle:^(NSDictionary *response) {
        
//        self.arrayModel = [[NSMutableArray alloc] init];
        
        self.arrayModel = [[response objectForKey:@"data"] objectForKey:@"items"];
        
        
        [self.myTable reloadData];
        
        [hud hide:YES];
        
    }];
    
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 143;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId = @"ExpertCell";

        ExpertCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
    
    NSDictionary* item = [[self.arrayModel objectAtIndex:indexPath.row] objectForKey:@"favoriteDoctor"];
    
    GSExpert* expert = [GSExpert objectWithKeyValues:item];
    
    cell.lblName.text = expert.name;//item[@"name"];
    cell.lblDept.text = expert.dept;//item[@"dept"];
    cell.lblDeptAndSurgery.text = expert.dept;//item[@"dept"];
    cell.lblIntro.text = expert.intro; //@"赶紧快点搞完吧快点搞完吧快点搞完吧少年们赶紧快点搞完吧快点搞完吧快点搞完吧少年们赶紧快点搞完吧快点搞完吧快点搞完吧少年们";//item[@"intro"];
    cell.lblPro.text = expert.position;//item[@"position"];
    
    for (int i = 0; i < expert.doctorFiles.count; i ++) {
        
        Doctorfiles* file = [expert.doctorFiles objectAtIndex:i];
        
        if (file.type == 1) {
            
            
            [cell.imgHeadPhoto sd_setImageWithURL:[NSURL URLWithString:file.path] placeholderImage:[UIImage imageNamed:HEADPHOTO_PLACEHOUDER]];;
            
            
        }
        
    }
    
    
    [cell.star  setStarForValue:expert.avg_score.floatValue];
    

        
        return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story=[UIStoryboard storyboardWithName:@"User" bundle:nil];
    ExpertDetailCtrl *vc=[story instantiateViewControllerWithIdentifier:@"ExpertDetailCtrl"];
    
    vc.expert = [GSExpert objectWithKeyValues:[[self.arrayModel objectAtIndex:indexPath.row] objectForKey:@"favoriteDoctor"]];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
