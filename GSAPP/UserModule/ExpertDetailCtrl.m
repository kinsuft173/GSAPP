//
//  ExpertDetailCtrl.m
//  GSAPP
//
//  Created by kinsuft173 on 15/6/20.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "ExpertDetailCtrl.h"
#import "DoctorDetailCell.h"
#import "DoctorFeedbackCell.h"
#import "NetWorkManager.h"
#import "UserDataManager.h"
#import "DoctorCommentCell.h"
#import "CommentTitleCell.h"
#import "GSEvaluate.h"
#import "ExpertCertificationViewController.h"

@interface ExpertDetailCtrl ()
@property (assign)BOOL isIntroExpand;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) starView *star;
@property (nonatomic,strong) NSArray *contentArray;
@property (nonatomic,strong) NSArray *arrayComment;

@end

@implementation ExpertDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.content = self.expert.intro;
//    self.content = @"nibRegistered是我做的一个判断，判断当前cell有没有加入到tableview中作为tableview的行对象，承与UITabllifestylecell是我自定义的一个继承与UI入到tableview中作为tableview的行对象，承与UITablli";
//    self.expert.intro = self.content;
    
    self.contentArray=[NSArray arrayWithObjects:@"医术高明",@"医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明",@"医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明医术高明",@"医术高明医术高明医术高明医术高明", nil];
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setFrame:CGRectMake(0, 0, 30, 50)];
    [rightButton setImage:[UIImage imageNamed:@"btn_collection"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(collect) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightButton ];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(goReloadTable)  name:@"ReloadTable"  object:nil];
    
    [self getComments];
    
    
}

- (void)getComments
{
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.expert.id
                                                                      ],@"and[evaluated_doctor_id]",@"doctor,doctor.doctorFiles",@"expand",@"1",@"status",nil];
    
    [[NetworkManager shareMgr] server_fetchEvaluateWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        NSLog(@"获取的专家评论数据====>%@",dic);
        
        if ([[dic objectForKey:@"success"] integerValue] == 1) {
            
            self.arrayComment  = [[dic objectForKey:@"data"] objectForKey:@"items"];
            
            [self goReloadTable];

            
        }
        
    }];
    
    
}

-(void)goReloadTable
{
    NSLog(@"刷新屏幕");
    [self.myTable reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isIntroExpand = NO;
}

-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)heightForIntroCellWithWidth:(CGFloat)width WithContent:(NSString*)content
{
    if (self.isIntroExpand == YES) {
        
        CGFloat lblHeight = [HKCommen compulateTheHightOfAttributeLabelWithWidth:width WithContent:content WithFontSize:13];
        
        NSLog(@"lblHeight = %f",lblHeight);
        
        if (lblHeight < 48) {
            
            return 283;
            
        }else{
        
            return lblHeight + 236;
            
        }
        
    }else{
        
        return 283;
    }
}

- (CGFloat)heightForConetentCellWithWidth:(CGFloat)width WithContent:(NSString*)content
{


    UITextView *text=[[UITextView alloc]initWithFrame:CGRectMake(0, 0, width, 20)];
    text.text=content;
    CGRect textFrame=[[text layoutManager]usedRectForTextContainer:[text textContainer]];
    CGFloat height = textFrame.size.height;
    
    NSLog(@"textView的高度：%f",height);
    return height+100;
}


#pragma tableble datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        
        
        return 1;
        
        
        
    }else if (section == 1){
        
        
        return 1;
        
    
    }else if(section == 2 ){
    
    
        return self.arrayComment.count;
    
    }
    
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {

            return [self heightForIntroCellWithWidth:(self.view.frame.size.width) WithContent:self.content];
       
      
    }
    else if (indexPath.section==1)
    {
        return 32;
    }
    else if (indexPath.section==2)
    {
        
        
       // CGFloat lblHeight = [HKCommen compulateTheHightOfAttributeLabelWithWidth:[UIScreen mainScreen].bounds.size.width-20 WithContent:[self.contentArray objectAtIndex:indexPath.row] WithFontSize:13];
        GSEvaluate* evaluate = [GSEvaluate objectWithKeyValues:[self.arrayComment objectAtIndex:indexPath.row]];
        
        CGFloat lblHeight=[self heightForConetentCellWithWidth:[UIScreen mainScreen].bounds.size.width-20 WithContent:evaluate.content];
        
        return lblHeight;
        
        
    }
    
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* DetailCellId = @"DoctorDetailCell";
    static NSString* CommentTitle=@"CommentTitleCell";
    static NSString* DoctorComment=@"DoctorCommentCell";
    
    if (indexPath.section==0) {
        DoctorDetailCell* cell = [tableView dequeueReusableCellWithIdentifier:DetailCellId];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:DetailCellId owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        cell.delegate=self;
        cell.lbl_content.text = self.expert.intro;
        cell.lbl_consultation_fee.text = [NSString stringWithFormat:@"%@元",self.expert.consultation_fee];
        cell.lbl_consultation_operation_fee.text = [NSString stringWithFormat:@"%@元",self.expert.consultation_operation_fee];
        cell.lblDooctorName.text = self.expert.name;
        
        cell.lbl_position.text = self.expert.position;
        cell.lbl_dep.text = self.expert.dept;
    
        
        [cell.btn_Diagnose addTarget:self action:@selector(goToDiagnoseInfo) forControlEvents:UIControlEventTouchUpInside];
        [cell.btn_Diagnose_opertation addTarget:self action:@selector(goToDiagnoseInfo2) forControlEvents:UIControlEventTouchUpInside];
        
        cell.btn_Diagnose.layer.cornerRadius = 4.0;
        cell.btn_Diagnose.layer.masksToBounds = YES;
        cell.btn_Diagnose_opertation.layer.cornerRadius = 4.0;
        cell.btn_Diagnose_opertation.layer.masksToBounds = YES;
        
        cell.imgHeadPhoto.layer.cornerRadius = 4.0;
        cell.imgHeadPhoto.layer.masksToBounds = YES;
        
        cell.lbl_hospital.text = self.expert.hospital;
        
        if (self.expert.doctorFiles.count != 0) {
            
            for (int i = 0; i < self.expert.doctorFiles.count; i ++) {
                
                Doctorfiles* file = [Doctorfiles  objectWithKeyValues:[self.expert.doctorFiles objectAtIndex:i]] ;
                
                if (file.type == 1) {
                    
                    
                    [cell.imgHeadPhoto sd_setImageWithURL:file.path
                                         placeholderImage:[UIImage imageNamed:@"loading-ios"] options:SDWebImageContinueInBackground];
                }
                
            }
            
        }
        
        if ([HKCommen compulateTheHightOfAttributeLabelWithWidth:self.view.frame.size.width - 20 WithContent:self.content WithFontSize:13] < 48) {
            
            cell.btn_Expand.hidden = YES;
            
        }
        
        [cell.btnRenzheng addTarget:self action:@selector(goRenzheng) forControlEvents:UIControlEventTouchUpInside];
        
        if (self.expert.counsel_type == 0) {
            
            
//            cell.btn_Diagnose_opertation.enabled = NO;
            [cell.btn_Diagnose_opertation setBackgroundColor:[UIColor grayColor]];
            
        }
        
        return cell;
    }
    else if(indexPath.section==1)
    {
        CommentTitleCell* cell = [tableView dequeueReusableCellWithIdentifier:CommentTitle];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:CommentTitle owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        return cell;
    }
    
    else if(indexPath.section==2)
    {
        DoctorCommentCell* cell = [tableView dequeueReusableCellWithIdentifier:DoctorComment];
        
        if (!cell) {
            
            NSArray* topObjects = [[NSBundle mainBundle] loadNibNamed:DoctorComment owner:self options:nil];
            
            cell = [topObjects objectAtIndex:0];
            
        }
        
        GSEvaluate* evaluate = [GSEvaluate objectWithKeyValues:[self.arrayComment objectAtIndex:indexPath.row]];
        
        
        cell.txt_comment.text= evaluate.content;
        
        cell.txt_comment.font=[UIFont systemFontOfSize:12.0];
        [cell.txt_comment setTextColor:[UIColor colorWithRed:141.0/255.0 green:141.0/255.0 blue:141.0/255.0 alpha:1.0]];

        
        if (evaluate.created_at.length >= 10) {
            
            NSString* strTemp = [evaluate.created_at substringToIndex:10];
            
            cell.lbl_data.text = strTemp;
            
        }
        
        cell.lbl_name.text = evaluate.doctor.name;
        
        for (int i = 0; i < evaluate.doctor.doctorFiles.count; i ++) {
            
            Doctorfiles* file = [evaluate.doctor.doctorFiles objectAtIndex:i];
            
            if (file.type == 1) {
                
                
                [cell.img_Head sd_setImageWithURL:file.path
                                     placeholderImage:[UIImage imageNamed:@"loading-ios"] options:SDWebImageContinueInBackground];
            }
            
        }

        
        return cell;
    }
    
    
    return nil;
}

-(void)goToDiagnoseInfo
{
    
    
    
    if ([UIScreen mainScreen].bounds.size.width>=375) {
        DiagnoseInfoCtrl *vc=[[DiagnoseInfoCtrl alloc]initWithNibName:@"SecondDiagnoseCtrl" bundle:nil];
        vc.expert = self.expert;
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        DiagnoseInfoCtrl *vc=[[DiagnoseInfoCtrl alloc]initWithNibName:@"SmallDiagnoseCtrl" bundle:nil];
        vc.expert = self.expert;
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)goToDiagnoseInfo2
{
    
    if (self.expert.counsel_type == 0) {
        
        [HKCommen addAlertViewWithTitel:@"该专家尚无手术资格"];
        
        return;
        
    }
    
    
    if ([UIScreen mainScreen].bounds.size.width>=375) {
        DiagnoseInfoCtrl *vc=[[DiagnoseInfoCtrl alloc]initWithNibName:@"SecondDiagnoseCtrl" bundle:nil];
        vc.expert = self.expert;
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        DiagnoseInfoCtrl *vc=[[DiagnoseInfoCtrl alloc]initWithNibName:@"SmallDiagnoseCtrl" bundle:nil];
        vc.expert = self.expert;
        vc.type = 1;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView * )tableView
heightForHeaderInSection:(NSInteger)section
{
    if (section==1) {
        return 12;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView=[[UIView alloc] init];
    headView.backgroundColor=[UIColor clearColor];
    return headView;
}

-(void)Expand
{
    self.isIntroExpand=!self.isIntroExpand;
    
    DoctorDetailCell *cell=(DoctorDetailCell*)[self.myTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    if (self.isIntroExpand) {
        [cell.btn_Expand setImage:[UIImage imageNamed:@"btn_normal"] forState:UIControlStateNormal];
    }
    else
    {
    [cell.btn_Expand setImage:[UIImage imageNamed:@"btn_pack-up"] forState:UIControlStateNormal];
    }
    
    
    [self.myTable beginUpdates];
    
    NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.myTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath] withRowAnimation:UITableViewRowAnimationNone];

    [self.myTable endUpdates];
    
}


- (IBAction)goConsultation:(id)sender
{
    
    
    [self performSegueWithIdentifier:@"goCousultation" sender:nil];

}



- (void)collect
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"正在加载...";
    
    
    NSDictionary* dic = @{@"doctor_id":[NSNumber numberWithInteger:[UserDataManager shareManager].user.doctor.id],@"favorite_doctor_id":[NSNumber numberWithInteger:self.expert.id]};
    
    [[NetworkManager shareMgr]server_createFavoritesWithDic:dic completeHandle:^(NSDictionary *dic) {
       
        [HKCommen addAlertViewWithTitel:@"收藏成功"];
        
        [hud hide:YES];
        
    }];

}



- (void)goRenzheng
{
    NSString* strUrl;
    
    if (self.expert.doctorFiles.count != 0) {
        
        for (int i = 0; i < self.expert.doctorFiles.count; i ++) {
            
            Doctorfiles* file = [self.expert.doctorFiles objectAtIndex:i];
            
            if (file.type == 2) {
                
                
                strUrl = file.path;
            }
            
        }
        
    }
    
    if (strUrl == nil) {
        
        [HKCommen addAlertViewWithTitel:@"未能获取到该专家的认证信息"];
        
        return;
        
    }
    
    //[HKCommen addAlertViewWithTitel:@"测试模式尚无认证信息"];
    ExpertCertificationViewController* vc = [[ExpertCertificationViewController alloc] initWithNibName:@"ExpertCertificationViewController" bundle:nil];
    
    vc.strUrl = strUrl;
    
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
