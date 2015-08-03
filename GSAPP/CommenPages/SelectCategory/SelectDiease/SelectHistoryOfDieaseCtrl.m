//
//  SelectCategoryCtrl.m
//  GSAPP
//
//  Created by kinsuft173 on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "SelectHistoryOfDieaseCtrl.h"
#import "CategoryCell.h"
#import "HKCommen.h"
#import "NetworkManager.h"

@interface SelectHistoryOfDieaseCtrl ()

@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property (nonatomic, strong) IBOutlet NSArray* arrayModel;

@end

@implementation SelectHistoryOfDieaseCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self getModel];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initUI
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [HKCommen setExtraCellLineHidden:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins: UIEdgeInsetsZero];
    }
    
    [HKCommen addHeadTitle:@"选择病史" whichNavigation:self.navigationItem];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)getModel
{
    [[NetworkManager shareMgr] server_fetchAnamnesisWithDic:nil completeHandle:^(NSDictionary *response) {
        
        self.arrayModel = [[NSMutableArray alloc] init];
        
        NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
        
        if (resultArray.count != 0) {
            
            self.arrayModel = resultArray;
            
        }
        
        [self.tableView reloadData];
        
    }];
    
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
    return 44;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* cellId1 = @"CategoryCell";
    
    CategoryCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
    
    if (!cell) {
        
        NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:cellId1 owner:self options:nil];
        
        cell = [topObjects objectAtIndex:0];
        
    }
    
    cell.lblCategory.text =[[self.arrayModel objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    return cell;
    
}

#pragma tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController popViewControllerAnimated:YES];
    
    [self.delegate handleHistoryOfDieaseSelectedWithDic:[self.arrayModel objectAtIndex:indexPath.row]];
}


@end
