//
//  EASearchView.h
//  AshineDoctor
//
//  Created by Lipeng on 15-8-7.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EASearchBar.h"

@class EASearchView;
//搜索结果
@protocol EASearchViewDelegate <UITableViewDataSource, UITableViewDelegate>
//历史记录
- (NSArray *)historyItems;
//搜索
- (void)searchWithKeyword:(NSString *)keyword onTableView:(UITableView *)tableView;
@optional
//设置搜索View
- (void)setSearchView:(EASearchView *)searchView;
@end

@interface EASearchView : UIView
//搜索结果
@property(nonatomic, readonly) UITableView *tableView;

//需要隐藏时调用
- (void)pause;
//需要显示时调用
- (void)resume;
//强制停止
- (void)stop;
//隐藏键盘
- (void)hideKeybord;

+ (EASearchView *)start:(EASearchBar *)searchBar
       onViewController:(UIViewController *)viewController
               delegate:(id<EASearchViewDelegate>)delegate;
@end
