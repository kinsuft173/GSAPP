//
//  SignUpCtrl.m
//  GSAPP
//
//  Created by kinsuft173 on 15/6/7.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "SignUpCtrl.h"
#import <IQKeyboardManager.h>

@interface SignUpCtrl ()<UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;


@end

@implementation SignUpCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
//    for (UITextField* textFiled in [self.scrollView subviews]) {
//        
//        if ([textFiled.class isSubclassOfClass:[UITextField class]]) {
//            
//                    textFiled.delegate = self;
//            
//        }
//    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)keyboardDownToOrigin:(UITapGestureRecognizer*)gesture
{
    NSLog(@"test");
    
    for (UITextField* textFiled in [self.scrollView subviews]) {
        
        [textFiled resignFirstResponder];
        
    }
}

//UITextField的协议方法，当开始编辑时监听

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//
//{
//    
//    CGRect frame = textField.frame;
//    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 260.0);//键盘高度216
//    
//    NSTimeInterval animationDuration = 0.30f;
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    
//    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
//    if(offset > 0)
//        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
//    
//    [UIView commitAnimations];
//    
//    return YES;
//    
//}

//UITextField的协议方法，当结束编辑时监听

//- (void) textFieldDidEndEditing:(UITextField *)textField{
//    
//    [self resumeView];
//    
//}

//-(void)textFieldDidEndEditing:(UITextField *)textField
//{
//    self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//}

//恢复原始视图位置

//-(void)resumeView
//
//{
//    
//    NSTimeInterval animationDuration=0.30f;
//    
//    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
//    
//    [UIView setAnimationDuration:animationDuration];
//    
//    float width = self.view.frame.size.width;
//    
//    float height = self.view.frame.size.height;
//    
//    //如果当前View是父视图，则Y为20个像素高度，如果当前View为其他View的子视图，则动态调节Y的高度
//    
//    float Y = 20.0f;
//    
//    CGRect rect=CGRectMake(0.0f,Y,width,height);
//    
//    self.view.frame=rect;
//    
//    [UIView commitAnimations];
//    
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
