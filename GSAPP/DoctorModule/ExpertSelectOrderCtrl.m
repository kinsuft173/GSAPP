//
//  ExpertSelectOrderCtrl.m
//  GSAPP
//
//  Created by 胡昆1 on 7/17/15.
//  Copyright (c) 2015 cn.kinsuft. All rights reserved.
//

#import "ExpertSelectOrderCtrl.h"
#import "ComplainCell.h"
#import "HKCommen.h"
#import "ConsultationInfoCtrl.h"
#import "NetworkManager.h"
#import "GSConsulation.h"
#import "UserDataManager.h"

@interface ExpertSelectOrderCtrl ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTable;
@property (nonatomic, strong) NSMutableArray* arrayPrivateConsulation;
@property (nonatomic, strong) NSMutableArray* arrayPublicConsulation;

@end

@implementation ExpertSelectOrderCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    
    [self getModel];
}

-(void)initUI
{
    [HKCommen addHeadTitle:@"高手请接招" whichNavigation:self.navigationItem];
    
    [HKCommen setExtraCellLineHidden:self.myTable];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"updateConsulation" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getModel) name:@"notify" object:nil];
}

- (void)getModel
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    //私人的咨询
    NSDictionary* dicPrivate = [NSDictionary dictionaryWithObjectsAndKeys:[UserDataManager shareManager].userId,@"ConsultationSearch[expert_id]", @"1",@"ConsultationSearch[status]",nil];
    
    
    [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPrivate completeHandle:^(NSDictionary *response) {
        
        self.arrayPrivateConsulation = [[NSMutableArray alloc] init];
        
        NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
        
        if (resultArray.count != 0) {
            
            [self.arrayPrivateConsulation addObjectsFromArray:resultArray];
            
        }
        
//        [self.myTable reloadData];
        
        //公共的咨询
        
        NSDictionary* dicPublic = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"ConsultationSearch[anamnesis_id]",@"1",@"ConsultationSearch[status]", nil];
        
        [[NetworkManager shareMgr] server_fetchConsultWithDic:dicPublic completeHandle:^(NSDictionary *response) {
            
            self.arrayPublicConsulation = [[NSMutableArray alloc] init];
            
            NSArray* resultArray = [[response objectForKey:@"data"] objectForKey:@"items"];
            
            for (int i = 0; i < resultArray.count; i++) {
                
                BOOL isHas = NO;
                
                for (int j = 0; j < self.arrayPrivateConsulation.count; j++) {
                    
                    NSDictionary* dicPrivateItem = [self.arrayPrivateConsulation objectAtIndex:j];
                    
                    if ([[dicPrivateItem objectForKey:@"id"] isEqualToValue:[[resultArray objectAtIndex:i] objectForKey:@"id"]]) {
                        
                        isHas = YES;
                        
                        break;
                        
                    }
                    
               }
                
                if(isHas == NO){
                
                    [self.arrayPublicConsulation addObject:[resultArray objectAtIndex:i]];
                    
                }
                
            }
            
            [hud hide:YES];
            [self.myTable reloadData];
            
        }];
        
        
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
    //return self.arrayPrivateConsulation.count + self.arrayPublicConsulation.count;
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (section == 0) {
        
        //return  self.arrayPrivateConsulation.count*2;
        return self.arrayPrivateConsulation.count*2;
        
    }else{
    
        //return self.arrayPublicConsulation.count*2;
        return self.arrayPublicConsulation.count*2;
    
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        if (indexPath.row==5) {
            return 0;
        }
        else if (indexPath.row % 2 !=0) {
            return 11.0;
        }
        else
        {
            return 104;
        }
        
    }
    else 
    {
        if (indexPath.row==9) {
            return 0;
        }
        else if (indexPath.row % 2 !=0) {
            return 11.0;
        }
        else
        {
            return 104;
        }
    }
    
    
    
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* CellId = @"ComplainCell";
    static NSString* EmptyId=@"EmptyCell";
    
    //  self.arrayPrivateConsulation.count*2
    
    //return self.arrayPublicConsulation.count*2;
    
    if (indexPath.section==0) {
        
        if (indexPath.row % 2!=0) {
            EmptyCell* cell = [tableView dequeueReusableCellWithIdentifier:EmptyId];
            
            if (!cell) {
                
                NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:EmptyId owner:self options:nil];
                
                cell = [topObjects objectAtIndex:0];
                
            }
            
            return cell;
        }

        else
        {
            ComplainCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            
            if (!cell) {
                
                NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
                
                cell = [topObjects objectAtIndex:0];
                
            }
            
            GSConsulation* consulation = [GSConsulation objectWithKeyValues:[self.arrayPrivateConsulation objectAtIndex:indexPath.row/2]];
            cell.lblBingshi.text = consulation.patient_illness;//[NSString stringWithFormat:@"%d",consulation.  ];
            cell.lblDescription.text = consulation.remark;
            cell.lblZhengzhuan.text = [NSString stringWithFormat:@"%ld", consulation.symptom_id];
            
            
            [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_consultation"]];
            cell.lbl_treat.text=@"会诊";
            
            return cell;
        }
        
        
    }
    else
    {
        
        if (indexPath.row % 2!=0) {
            EmptyCell* cell = [tableView dequeueReusableCellWithIdentifier:EmptyId];
            
            if (!cell) {
                
                NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:EmptyId owner:self options:nil];
                
                cell = [topObjects objectAtIndex:0];
                
            }
            
            return cell;
        }
        
        else
        {
            ComplainCell* cell = [tableView dequeueReusableCellWithIdentifier:CellId];
            
            if (!cell) {
                
                NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CellId owner:self options:nil];
                
                cell = [topObjects objectAtIndex:0];
                
            }
            [cell.imgOfDisease setImage:[UIImage imageNamed:@"list_surgery"]];
            cell.lbl_treat.text=@"会诊手术";
            
            GSConsulation* consulation = [GSConsulation objectWithKeyValues:[self.arrayPublicConsulation objectAtIndex:indexPath.row/2]];
            cell.lblBingshi.text = consulation.patient_illness;//[NSString stringWithFormat:@"%d",consulation.  ];
            cell.lblDescription.text = consulation.remark;
            cell.lblZhengzhuan.text = [NSString stringWithFormat:@"%ld", consulation.symptom_id];
            
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    return 52.0;
}

- (UIView * )tableView:(UITableView * )tableView
viewForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        UIView *view=[[UIView alloc]init];
        [view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 52.0)];
        view.backgroundColor=[UIColor clearColor];
        
        UILabel *lbl_Middle=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5-60-10, 19.0, 120, 16)];
        lbl_Middle.textAlignment=UITextAlignmentCenter;
        [lbl_Middle setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width*0.5-10, 26.0)];
        [lbl_Middle setText:@"预约我的订单"];
        [lbl_Middle setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        lbl_Middle.font=[UIFont systemFontOfSize:15.0];
        
        UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-10, 1)];
        [leftView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5+lbl_Middle.frame.size.width*0.5-10, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-10, 1)];
        [rightView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        [view addSubview:lbl_Middle];
        [view addSubview:leftView];
        [view addSubview:rightView];
        
        return view;
    }
    else
    {
        UIView *view=[[UIView alloc]init];
        [view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 52.0)];
        view.backgroundColor=[UIColor clearColor];
        
        UILabel *lbl_Middle=[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5-60-10, 19.0, 120, 16)];
        lbl_Middle.textAlignment=UITextAlignmentCenter;
        [lbl_Middle setCenter:CGPointMake([UIScreen mainScreen].bounds.size.width*0.5-10, 26.0)];
        [lbl_Middle setText:@"符合我专长的订单"];
        [lbl_Middle setTextColor:[UIColor colorWithRed:79.0/255.0 green:193.0/255.0 blue:233.0/255.0 alpha:1.0]];
        lbl_Middle.font=[UIFont systemFontOfSize:15.0];
        
        UIView *leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-20, 1)];
        [leftView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        UIView *rightView=[[UIView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*0.5+lbl_Middle.frame.size.width*0.5-5, 26.0, [UIScreen mainScreen].bounds.size.width*0.5-lbl_Middle.frame.size.width*0.5-20, 1)];
        [rightView setBackgroundColor:[UIColor colorWithRed:160.0/255.0 green:160.0/255.0 blue:160.0/255.0 alpha:0.4]];
        
        [view addSubview:lbl_Middle];
        [view addSubview:leftView];
        [view addSubview:rightView];
        
        return view;
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row%2 != 0) {
        
        return;
    }
    
    GSConsulation* consulation;
    
    if (indexPath.section == 0) {
        
        consulation = [GSConsulation objectWithKeyValues:[self.arrayPrivateConsulation objectAtIndex:indexPath.row/2]];
    }else{
        
        consulation = [GSConsulation objectWithKeyValues:[self.arrayPublicConsulation objectAtIndex:indexPath.row/2]];
    }
    
    
    ConsultationInfoCtrl* vc = [[ConsultationInfoCtrl alloc] initWithNibName:@"ConsultationInfoCtrl" bundle:nil];
    
    vc.consulation = consulation;
    
    
    [self.navigationController pushViewController:vc animated:YES];
    

}


@end
