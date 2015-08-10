//
//  LoginOutCell.h
//  UserManager
//
//  Created by walter on 14-9-3.
//  Copyright (c) 2014年 Stanford. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol logOut <NSObject>

- (void)logOut;

@end

@interface LoginOutCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *maskView3;

@property (weak, nonatomic) id <logOut> delegate;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginOut;

@end
