//
//  FindExpertCtrl.m
//  GSAPP
//
//  Created by kinsuft173 on 15/6/20.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "FindExpertCtrl.h"
#import "ExpertCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"
#import "MJRefresh.h"
#import "SelectCityCtrl.h"
#import "SelectSpeticalCtrl.h"
#import "SelectCategoryCtrl.h"
#import "HKMapCtrl.h"
#import "GSExpert.h"
#import "ExpertDetailCtrl.h"
#import "HKMapManager.h"

@interface FindExpertCtrl ()<UITableViewDataSource,UITableViewDelegate,SlectCityDelegate,SlectSpecialDelegate,SlectCategoryDelegate,SlectMapDelegate>


@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet UIView* viewMask1;

@property (nonatomic, strong) NSMutableArray* arrayModel;
@property (nonatomic, strong) NSDictionary* dicParams;

@end

@implementation FindExpertCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initUI];
    [self getModel];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    [rightButton setFrame:CGRectMake(0, 0, 60, 100)];
    [rightButton setTitle:@"智能排序" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(goAutoSort:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=item;
    
    [HKCommen setExtraCellLineHidden:self.tableView];
    
  //  [HKCommen addBoardToView:self.viewMask1 WithSuperView:self.view withWidth:SCREEN_WIDTH -20  withInset:64];
   // [HKCommen addBoardToView:self.tableView WithSuperView:self.view withWidth:SCREEN_WIDTH -20  withInset:64];
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleMapSelectedWithDic) name:@"refreshDoctors" object:nil];
}

- (void)getModel
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    [[NetworkManager shareMgr] server_fetchDoctorsWithDic:self.dicParams completeHandle:^(NSDictionary *response) {
        
        self.arrayModel = [[NSMutableArray alloc] init];
        
        NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
        
        if (resultArray.count != 0) {
            
            [self.arrayModel addObjectsFromArray:resultArray];
            
        }
        
        [self.tableView reloadData];
        
        [hud hide:YES];
        
    }];

}

-(void)reOrder
{
    

}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(GSExpert*)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    ExpertDetailCtrl* vc = segue.destinationViewController;
    
    vc.expert = sender;
    
}

#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    if ([HKMapManager shareMgr].isShouldFresh == YES) {
//        
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        
//        hud.mode = MBProgressHUDModeIndeterminate;
//        hud.labelText = @"正在加载...";
//        
//        NSMutableDictionary* dic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"50",@"distance",[NSNumber numberWithFloat:[HKMapManager shareMgr].floatUserCurrentLongitude],@"latitude", [NSNumber numberWithFloat:[HKMapManager shareMgr].floatUserCurrentLongitude], @"longitude",nil];
//        
//        [[NetworkManager shareMgr] server_fetchDoctorsWithDic:dic completeHandle:^(NSDictionary *response) {
//            
//            self.arrayModel = [[NSMutableArray alloc] init];
//            
//            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
//            
//            if (resultArray.count != 0) {
//                
//                [self.arrayModel addObjectsFromArray:resultArray];
//                
//            }
//            
//            [self.tableView reloadData];
//            
//            [hud hide:YES];
//            
//            [HKMapManager shareMgr].isShouldFresh == NO;
//            
//        }];
//        
//    }

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.arrayModel.count;
    return self.arrayModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 143;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString* cellId = @"ExpertCell";
    
    ExpertCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if (!cell) {
        
        NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:cellId owner:self options:nil];
        
        cell = [topObjects objectAtIndex:0];
        
    }
    
    NSDictionary* item = [self.arrayModel objectAtIndex:indexPath.row];
    
    GSExpert* expert = [GSExpert objectWithKeyValues:item];
    
    cell.lblName.text = expert.name;//item[@"name"];
    cell.lblDept.text = expert.dept;//item[@"dept"];
    cell.lblDeptAndSurgery.text = expert.dept;//item[@"dept"];
    cell.lblIntro.text = expert.intro; //@"赶紧快点搞完吧快点搞完吧快点搞完吧少年们赶紧快点搞完吧快点搞完吧快点搞完吧少年们赶紧快点搞完吧快点搞完吧快点搞完吧少年们";//item[@"intro"];
    cell.lblPro.text = expert.position;//item[@"position"];
    
    cell.imgHeadPhoto.image = [UIImage imageNamed:HEADPHOTO_PLACEHOUDER];
    cell.imgHeadPhoto.layer.cornerRadius = 4.0;
    cell.imgHeadPhoto.layer.masksToBounds = YES;
    
    for (int i = 0; i < expert.doctorFiles.count; i ++) {
        
        Doctorfiles* file = [expert.doctorFiles objectAtIndex:i];
        
        if (file.type == 1) {
            
            
            [cell.imgHeadPhoto sd_setImageWithURL:[NSURL URLWithString:file.path] placeholderImage:[UIImage imageNamed:HEADPHOTO_PLACEHOUDER]];
            
            
        }
        
    }
   
    
    [cell.star  setStarForValue:expert.avg_score.floatValue];
    

    return cell;
}

#pragma tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = [self.arrayModel objectAtIndex:indexPath.row];
    
    GSExpert* expert = [GSExpert objectWithKeyValues:item];
    
    
    [self performSegueWithIdentifier:@"goExpertDetails" sender:expert];
}


#pragma mark - go other select pages

- (IBAction)goSelectCity:(UIButton*)sender
{
    SelectCityCtrl* vc = [[SelectCityCtrl alloc] initWithNibName:@"SelectCityCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)goSelectLocation:(UIButton*)sender
{
    HKMapCtrl* vc  = [[HKMapCtrl alloc]  initWithNibName:@"HKMapCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)goScoreSort:(id)sender
{
    self.dicParams = [NSDictionary dictionaryWithObjectsAndKeys:@"-avg_score",@"sort",@"doctorFiles",@"expand", nil];
    
    [self getModel];

}

- (IBAction)goAutoSort:(id)sender
{
   // self.dicParams = [NSDictionary dictionaryWithObjectsAndKeys:@"-avg_score",@"sort",@"doctorFiles",@"expand", nil];
    self.dicParams = nil;
    [self getModel];
}

- (IBAction)goSelectSpecial:(UIButton*)sender
{
    SelectSpeticalCtrl* vc = [[SelectSpeticalCtrl alloc] initWithNibName:@"SelectSpeticalCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (IBAction)goSelectCategory:(UIButton*)sender
{
    SelectCategoryCtrl* vc = [[SelectCategoryCtrl alloc] initWithNibName:@"SelectCategoryCtrl" bundle:nil];
    
    vc.hidesBottomBarWhenPushed = YES;
    vc.delegate = self;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

- (void)handleCitySelectedWithDic:(NSDictionary *)dic
{
    self.dicParams = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"name"],@"andLike[city]",@"doctorFiles",@"expand",nil];

    [self getModel];
}

- (void)handleSpecialSelectedWithDic:(NSDictionary *)dic
{
    self.dicParams = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"name"],@"andLike[expertise]",@"doctorFiles",@"expand",nil];
    
    [self getModel];
}

- (void)handleCategorySelectedWithDic:(NSDictionary *)dic
{
    self.dicParams = [NSDictionary dictionaryWithObjectsAndKeys:dic[@"name"],@"andLike[dept]",@"doctorFiles",@"expand",nil];
    
    [self getModel];
}

- (void)handleMapSelectedWithDic
{
//    self.dicParams = nil;
    
    
    
// http://115.28.85.76/gszx/api/web/?r=expert/index-by-coordinate&expand=doctorFiles   
    
    self.dicParams = [NSDictionary dictionaryWithObjectsAndKeys:@"50",@"distance",[NSNumber numberWithFloat:[HKMapManager shareMgr].floatUserCurrentLatitude],@"latitude",[NSNumber numberWithFloat:[HKMapManager shareMgr].floatUserCurrentLongitude],@"longitude",@"1",@"map",nil];

    [self getModel];

}




@end
