//
//  EASearchBar.h
//  AshineDoctor
//
//  Created by Lipeng on 15-7-25.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import <UIKit/UIKit.h>

//搜索框
@interface EASearchBar : UIView
//
@property(nonatomic, readonly) UITextField *textField;
//
@property(nonatomic, copy) void (^start_block)(void);
//取消
@property(nonatomic, copy) void (^cancel_block)(void);
//启动搜索
@property(nonatomic, copy) void (^invoke_block)(NSString *keyword);
//获取焦点时执行
@property(nonatomic, copy) void (^focus_block)(void);
//绑定到TableView
- (void)attachWithTableView:(UITableView *)tableView;
//隐藏
- (void)hideWithAnimated:(BOOL)animated;
//启动
- (void)invoke;
//静止
- (void)sleep;
//隐藏键盘
- (void)hideKeyboard;
//
//- (void)changeText:(NSString *)text;

//需要挂了
- (void)imDie;
+ (CGFloat)height;
@end
