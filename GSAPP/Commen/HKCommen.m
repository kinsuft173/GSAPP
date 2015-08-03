//
//  HKCommen.m
//  GSAPP
//
//  Created by kinsuft173 on 15/6/6.
//  Copyright (c) 2015年 cn.kinsuft. All rights reserved.
//

#import "HKCommen.h"
#import "iToast.h"

@implementation HKCommen

//控制器的标题
+ (void)addHeadTitle: (NSString*)string whichNavigation:(UINavigationItem*)item
{
    UILabel *title=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 100)];
    title.text=string;
    [title setTextColor:[UIColor whiteColor]];
    item.titleView=title;
}

// Convert a 6-character hex color to a UIColor object
+ (UIColor *) getColor: (NSString *) hexColor
{
    NSLog(@"hexColorClass = %d",[hexColor intValue]);
    NSLog(@"要处理的hexColor = %@",hexColor);
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
    
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+ (BOOL)validatePassword:(NSString *)passWord
{
    //[33-47a-zA-Z0-9]
    NSString *passWordRegex = @"^[@A-Za-z0-9-`=///[/];',./~!@#$%^&*()_+|{}:\"<>?]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//昵称
+ (BOOL)validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"[a-zA-Z\u4e00-\u9fa5]{1}+[a-zA-Z0-9\u4e00-\u9fa5]{0,15}";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    
    return [passWordPredicate evaluateWithObject:nickname];
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL)validateMobileWithPhoneNumber:(NSString*)strPhoneNumber
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|((17[6-8]))|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:strPhoneNumber];
}

//隐藏多余的分割线
+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view         = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

+ (CGFloat)compulateTheHightOfAttributeLabelWithWidth:(CGFloat)width WithContent:(NSString*)string WithFontSize:(NSInteger)size
{
    if (![[string class] isSubclassOfClass:[NSString class]]) {
        
        return 20;
    }
    
    UILabel* lblCaculate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];

    [lblCaculate setNumberOfLines:0];

//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    
//    [paragraphStyle setLineSpacing:3];//调整行间距
//    
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [string length])];
//    
//    lblCaculate.attributedText = attributedString;
    
    lblCaculate.text = string;
    lblCaculate.font = [UIFont systemFontOfSize:size];
    
    [lblCaculate sizeToFit];

    return lblCaculate.frame.size.height;
}

+ (void)addBoardToView:(UIView*)view WithSuperView:(UIView*)superView withWidth:(CGFloat)width  withInset:(CGFloat)inset
{
    UIView* divideView1 = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y - inset, width, 0.5)];
    UIView* divideView2 = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y +  view.frame.size.height -inset, width,0.5)];
    UIView* divideView3 = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y - inset,0.5, view.frame.size.height)];
    UIView* divideView4 = [[UIView alloc] initWithFrame:CGRectMake(view.frame.origin.x + width , view.frame.origin.y - inset, 0.5, view.frame.size.height)];
    
    divideView1.backgroundColor = [HKCommen getColor:@"aaaaaa"];
    divideView2.backgroundColor = [HKCommen getColor:@"aaaaaa"];
    divideView3.backgroundColor = [HKCommen getColor:@"aaaaaa"];
    divideView4.backgroundColor = [HKCommen getColor:@"aaaaaa"];
    
    [superView addSubview:divideView1];
    [superView addSubview:divideView2];
    [superView addSubview:divideView3];
    [superView addSubview:divideView4];
    
    NSLog(@"sd");
    
}

+ (void)addAlertViewWithTitel:(NSString*)titel
{
    NSLog(@"titel = %@",titel);
    
    iToastSettings *theSettings = [iToastSettings getSharedSettings];
    
    [theSettings setDuration:iToastDurationNormal];
    
    
    
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    
    [[iToast makeText:titel] show];
    
    //    });
    
}


@end
