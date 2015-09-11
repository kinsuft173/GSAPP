//
//  CaseDetailCtrl.m
//  GSAPP
//
//  Created by lijingyou on 15/7/16.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "CaseDetailCtrl.h"
#import "HKCommen.h"
#import "NetWorkManager.h"
#import "GSEvaluate.h"
#import "GSRepine.h"
#import "PhotoBroswerVC.h"

@interface CaseDetailCtrl ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lbl_OrderNum;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Position;
@property (weak, nonatomic) IBOutlet UILabel *lbl_hospital;
@property (weak, nonatomic) IBOutlet UILabel *lbl_City;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Adress;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Patient;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sex;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Age;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Disease;
@property (weak, nonatomic) IBOutlet UILabel *lbl_DiseaseHistory;
@property (weak, nonatomic) IBOutlet UILabel *lbl_Sympton;
@property (weak, nonatomic) IBOutlet UILabel *lbl_FinishedTime;
@property (weak, nonatomic) IBOutlet UITextView *lbl_Addition;
@property (weak, nonatomic) IBOutlet UITextView *lbl_Purpose;
@property (weak, nonatomic) IBOutlet UITextView *txt_WriteAddition;

/**********************************************/

@property (weak, nonatomic) IBOutlet UITextView *lbl_CommentOfDoctor;
@property (weak, nonatomic) IBOutlet UITextView *lbl_Complaint;
@property (weak, nonatomic) IBOutlet UITextView *lbl_ExpertAddtion;

/**********************************************/
@property (weak, nonatomic) IBOutlet UITextView *lbl_AdditionOfExpert;
@property (weak, nonatomic) IBOutlet UITextView *lbl_MyComment;
@property (weak, nonatomic) IBOutlet UITextView *lbl_MyComplaint;


@property  BOOL isComment;
@property  BOOL isComplaint;
@property  NSInteger index;

@property (nonatomic,strong) NSArray *images;

@end

@implementation CaseDetailCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.myScroll.contentSize=CGSizeMake(0, 1500);
    
    self.img_circle1.layer.cornerRadius = 6.5;
    self.img_circle1.layer.masksToBounds = YES;
    self.img_circle2.layer.cornerRadius = 6.5;
    self.img_circle2.layer.masksToBounds = YES;
    self.img_circle3.layer.cornerRadius = 6.5;
    self.img_circle3.layer.masksToBounds = YES;
    self.img_circle4.layer.cornerRadius = 6.5;
    self.img_circle4.layer.masksToBounds = YES;
    self.img_circle5.layer.cornerRadius = 6.5;
    self.img_circle5.layer.masksToBounds = YES;
    self.img_circle6.layer.cornerRadius = 6.5;
    self.img_circle6.layer.masksToBounds = YES;
    
    [HKCommen addHeadTitle:@"案例详情" whichNavigation:self.navigationItem];
    
    UIButton *leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setFrame:CGRectMake(0, 0, 30, 50)];
    [leftButton setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:leftButton ];
    self.navigationItem.leftBarButtonItem=leftItem;
    
    self.lbl_OrderNum.text = [NSString stringWithFormat:@"%d",self.orderGS.id];
    self.lbl_Position.text = self.orderGS.consultation.patient_address;
    self.lbl_hospital.text = self.orderGS.consultation.patient_hospital;
    self.lbl_City.text     = self.orderGS.consultation.patient_city;
    self.lbl_Patient.text  = self.orderGS.consultation.patient_name;
    
    if (self.orderGS.consultation.patient_sex == 0) {
        
        self.lbl_Sex.text = @"男";
    }else{
    
        self.lbl_Sex.text = @"女";
    }

    self.lbl_Age.text =  [NSString stringWithFormat:@"%d",self.orderGS.consultation.patient_age];
    
    self.lbl_Disease.text = self.orderGS.consultation.patient_illness;
    self.lbl_DiseaseHistory.text =[NSString stringWithFormat:@"%d",self.orderGS.consultation.anamnesis_id] ;
    self.lbl_Sympton.text =[NSString stringWithFormat:@"%d",self.orderGS.consultation.symptom_id] ;
    self.lbl_FinishedTime.text = self.orderGS.consultation.created_at;
    
    self.lbl_Addition.text = self.orderGS.consultation.remark;
    self.lbl_Purpose.text = self.orderGS.consultation.purpose;
    
    
    if ([self.orderGS.remark isEqualToString:@""] || [[self.orderGS.remark class] isSubclassOfClass:[NSNull class]]) {
        
    }else{
        
        self.lbl_ExpertAddtion.text = self.orderGS.remark;
        self.lbl_AdditionOfExpert.text = self.orderGS.remark;
        
    }
    
    
    if ([self.type isEqualToString:@"1"]) {
        
        self.view_DoctorCaseNotFinished.hidden = YES;
        self.view_ExpertCaseFinished.hidden = YES;
        self.view_ExpertCaseNotFinished.hidden = NO;
        
        for (UIView* view in [self.view_ExpertCaseNotFinished subviews]) {
            
            if (view == self.btn_newCancel) {
                
                view.hidden = NO;
                
            }else{
            
                view.hidden = YES;
            
            }
            
            
        }
        

        
    

    
    }else    if ([self.type isEqualToString:@"2"]) {
        
//        self.vview.hidden = NO;

        
    }else    if ([self.type isEqualToString:@"3"]) {
        
        
        self.view_ExpertCaseNotFinished.hidden = NO;
        self.view_ExpertCaseFinished.hidden = YES;
        self.view_DoctorCaseNotFinished.hidden = YES;
        
        if (self.orderGS.type == 0) {
            
            self.btn_cancel.hidden = YES;
            
        }
        
    }else    if ([self.type isEqualToString:@"4"]) {
        
        
        self.view_ExpertCaseFinished.hidden = NO;
        self.view_ExpertCaseNotFinished.hidden = YES;
              self.view_DoctorCaseNotFinished.hidden = YES;
        
    }
    
    
    
    [self getComment];
    [self getComplaint];
    
    
    if (self.orderGS.consultation.consultationFiles.count != 0) {
        
        for (int i = 0; i < self.orderGS.consultation.consultationFiles.count ; i ++) {
            
            
            Consultationfiles* file =[self.orderGS.consultation.consultationFiles objectAtIndex:i];
            
            if (file.type == 1 ) {
                
                
                if (![[file.path class] isSubclassOfClass:[NSNull class]]) {
                    
                    [self.img_left sd_setImageWithURL:[NSURL URLWithString:file.path]
                                     placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
                }
                
                
            }
            
            if (file.type == 2 ) {
                
                
                if (![[file.path class] isSubclassOfClass:[NSNull class]]) {
                    
                    [self.img_middle sd_setImageWithURL:[NSURL URLWithString:file.path]
                                       placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
                }
                
                
            }
            
            if (file.type == 3 ) {
                
                
                if (![[file.path class] isSubclassOfClass:[NSNull class]]) {
                    
                    [self.img_right sd_setImageWithURL:[NSURL URLWithString:file.path]
                                      placeholderImage:[UIImage imageNamed:@"photo"] options:SDWebImageContinueInBackground];
                }
                
                
            }
            
            
        }
        
        
    }
    
    
}

- (void)getComplaint
{
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                      .id],@"and[order_id]",@"1",@"status",nil];
    
    [[NetworkManager shareMgr] server_fetchRepineWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        NSLog(@"获取的投诉数据====>%@",dic);
        
        if ([[dic objectForKey:@"success"] integerValue] == 1) {
            
            NSArray* arrayComment = [[dic objectForKey:@"data"] objectForKey:@"items"];
            
            if (arrayComment.count != 0) {
                
                self.btn_Complain.hidden = YES;
//                self.btn_Complain.alpha = 0.5;
                
                GSRepine* repine  = [GSRepine objectWithKeyValues:[arrayComment objectAtIndex:0]];
                
                self.lbl_MyComplaint.text = repine.content;
                
                self.isComplaint = YES;
                
                self.lbl_MyComplaint.userInteractionEnabled = NO;
                
                self.lbl_Complaint.text = repine.content;
                
                
                
            }
            
            
            
        }
        
    }];
}

- (void)getComment
{
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                      .id],@"and[order_id]",@"1",@"status",nil];
    
    [[NetworkManager shareMgr] server_fetchEvaluateWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        NSLog(@"获取的评论数据====>%@",dic);
        
        if ([[dic objectForKey:@"success"] integerValue] == 1) {
            
            NSArray* arrayComment = [[dic objectForKey:@"data"] objectForKey:@"items"];
            
            if (arrayComment.count != 0) {
                
                self.btn_Comment.hidden = YES;
                self.btn_Comment.alpha = 0.5;
                
                GSEvaluate* evaluate = [GSEvaluate objectWithKeyValues:[arrayComment objectAtIndex:0]];
                
                self.lbl_MyComment.text = evaluate.content;
                
                if (evaluate.score >4.0) {
                    
                    [self selectManyi:self.btn_feichangmanyi];
                    
                }else if (evaluate.score > 3.0){
                
                    [self selectManyi:self.btn_manyi];
                
                }else{
                
                    [self selectManyi:self.btn_yibanban];
                }
                
                self.btn_yibanban.enabled = NO;
                self.btn_feichangmanyi.enabled = NO;
                self.btn_manyi.enabled = NO;
                self.isComment = YES;
                
                self.lbl_MyComment.userInteractionEnabled = NO;
                
                self.lbl_CommentOfDoctor.text = evaluate.content;
                
                
                
            }
            
            
            
        }
        
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)goCancel:(id)sender
{
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                      .id],@"id",@4,@"status",nil];
    
    [[NetworkManager shareMgr] server_updateOrderWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    

}


- (IBAction)goFinish:(id)sender
{
    
    NSDictionary* dic = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInteger:self.orderGS
                                                                      .id],@"id",@9,@"status",nil];
    
    [[NetworkManager shareMgr] server_updateOrderWithDic:dic completeHandle:^(NSDictionary *dic) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"orderUpdate" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    

    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (textView == self.lbl_MyComment) {
        
        self.lbl_MyComment.text = @"";
        
    }
    
    
    if (textView == self.lbl_MyComplaint) {
        
        self.lbl_MyComplaint.text = @"";
        
    }


}

- (IBAction)goAddComment:(id)sender
{
    if (self.isComment == YES) {
        
        [HKCommen addAlertViewWithTitel:@"您已经对此案例发表过评价了"];
        
        return;
        
    }
    
    
    if ([self.lbl_MyComment.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请输入评价内容"];
        
        return;
    }
    
    
    NSString* strScore;
    
    if (self.index == 0 ) {
        
        strScore = @"5";
        
    }else if(self.index == 1){
        
        strScore = @"4";
    
    }else if(self.index == 2){
        
        strScore = @"3";
        
    }
    
    NSDictionary *parameters = @{@"doctor_id":[NSNumber numberWithInteger:self.orderGS.doctor_id],@"evaluated_doctor_id":[NSNumber numberWithInteger:self.orderGS.order_doctor_id],@"order_id":[NSNumber numberWithInteger:self.orderGS.id],@"score":@"4",@"content":self.lbl_MyComment.text};

    [[NetworkManager shareMgr] server_createEvaluateWithDic:parameters completeHandle:^(NSDictionary *dic) {
        
        if ([[dic objectForKey:@"success"] integerValue] == 1) {
            
            [HKCommen addAlertViewWithTitel:@"评价成功"];
            
            self.isComment = YES;
            
            self.lbl_MyComment.userInteractionEnabled = NO;
            
            return ;
            
            
        }
        
        
    }];

}



- (IBAction)goAddRepine:(id)sender
{
    if (self.isComplaint == YES) {
        
        [HKCommen addAlertViewWithTitel:@"您已经投诉过此案例了"];
        
        return;
        
    }
    
    
    if ([self.lbl_MyComplaint.text isEqualToString:@""]) {
        
        [HKCommen addAlertViewWithTitel:@"请输入投诉内容"];
        
        return;
    }
    
    NSDictionary *parameters = @{@"doctor_id":[NSNumber numberWithInteger:self.orderGS.doctor_id],@"repined_doctor_id":[NSNumber numberWithInteger:self.orderGS.order_doctor_id],@"order_id":[NSNumber numberWithInteger:self.orderGS.id],@"score":@"4",@"content":self.lbl_MyComplaint.text};
    
    [[NetworkManager shareMgr] server_createRepineWithDic:parameters completeHandle:^(NSDictionary *dic) {
        
        if ([[dic objectForKey:@"success"] integerValue] == 1) {
            
            [HKCommen addAlertViewWithTitel:@"已经收到您的投诉"];
            
            self.isComplaint = YES;
            
            self.lbl_MyComplaint.userInteractionEnabled = NO;
            
            return ;
            
            
        }
        
        
    }];
    
}



- (IBAction)selectManyi:(UIButton*)sender{

    if (sender == self.btn_feichangmanyi) {
        
        self.index = 0;
        
        self.img_feichangmanyi.image = [UIImage imageNamed:@"btn_pre.png"];
        self.img_manyi.image = [UIImage imageNamed:@"btn_nom.png"];
        self.img_yibanban.image = [UIImage imageNamed:@"btn_nom.png"];
        
    }else if (sender == self.btn_manyi) {
        
        self.index = 1;
        
        self.img_feichangmanyi.image = [UIImage imageNamed:@"btn_nom.png"];
        self.img_manyi.image = [UIImage imageNamed:@"btn_pre.png"];
        self.img_yibanban.image = [UIImage imageNamed:@"btn_nom.png"];
        
        
    }else if (sender == self.btn_yibanban) {
        
        self.index = 2;
        
        self.img_feichangmanyi.image = [UIImage imageNamed:@"btn_nom.png"];
        self.img_manyi.image = [UIImage imageNamed:@"btn_nom.png"];
        self.img_yibanban.image = [UIImage imageNamed:@"btn_pre.png"];
        
        
    }

}

- (IBAction)SeeMyImage:(UIButton *)sender {
    [self localImageShow:sender.tag];
}

/*
 *  本地图片展示
 */
-(void)localImageShow:(NSUInteger)index{
    
    __weak typeof(self) weakSelf=self;
    
    [PhotoBroswerVC show:self type:PhotoBroswerVCTypeZoom index:index photoModelBlock:^NSArray *{
        
        NSArray *localImages = weakSelf.images;
        
        NSMutableArray *modelsM = [NSMutableArray arrayWithCapacity:localImages.count];
        for (NSUInteger i = 0; i< localImages.count; i++) {
            
            PhotoModel *pbModel=[[PhotoModel alloc] init];
            pbModel.mid = i + 1;
            pbModel.image = localImages[i];
            
            if (index==0) {
                pbModel.sourceImageView = self.img_left;
            }
            else if (index==1)
            {
                pbModel.sourceImageView = self.img_middle;
            }
            else
            {
                pbModel.sourceImageView = self.img_right;
            }
            
            [modelsM addObject:pbModel];
        }
        
        return modelsM;
    }];
}

-(NSArray *)images{
    
    if(_images ==nil){
        NSMutableArray *arrayM = [NSMutableArray array];
        
        
        [arrayM addObject:self.img_left.image];
        [arrayM addObject:self.img_middle.image];
        [arrayM addObject:self.img_right.image];
        
        _images = arrayM;
    }
    
    return _images;
}


@end
