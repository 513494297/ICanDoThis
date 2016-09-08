//
//  EASearchView.m
//  AshineDoctor
//
//  Created by Lipeng on 15-8-7.
//  Copyright (c) 2015年 esuizhen. All rights reserved.
//

#import "EASearchView.h"

@interface EASearchView()<UITableViewDataSource, UITableViewDelegate>

//搜索
@property(nonatomic, strong) id<EASearchViewDelegate> delegate;

@property(nonatomic) EASearchBar *searchbar;
//搜索栏的superView
@property(nonatomic) UIView *barSuperview;
//搜索历史
@property(nonatomic) UITableView *hisTableView;

@property(nonatomic, weak) UIViewController *viewController;
@end

@implementation EASearchView
- (void)dealloc
{}

- (void)startWithSearchBar:(EASearchBar *)searchbar
          onViewController:(UIViewController *)viewController
                  delegate:(id<EASearchViewDelegate>)delegate
{
    if ([delegate respondsToSelector:@selector(setSearchView:)]){
        [delegate setSearchView:self];
    }    
    _delegate = delegate;
    _viewController = viewController;
    _searchbar = searchbar;
    _barSuperview = _searchbar.superview;
    [self addSubview:searchbar];
    
    CGSize size = CGViewGetSize(self);
    CGRect frame = CGRectMake(0,CGViewGetY2(_searchbar),size.width,size.height-CGViewGetY2(_searchbar));
    _tableView = [[UITableView alloc] initWithFrame:frame];
    _tableView.delegate = delegate;
    _tableView.dataSource = delegate;
   // [_tableView initStyles:NO];
    [self addSubview:_tableView];
    
    //历史记录
    _hisTableView = [[UITableView alloc] initWithFrame:frame];
    _hisTableView.delegate = self;
    _hisTableView.dataSource = self;
 //   [_hisTableView initStyles:NO];
    _hisTableView.backgroundColor = hf_color(255, 255, 255, 1);
    _hisTableView.sectionHeaderHeight = 25;
    _hisTableView.rowHeight = 48;
    [self addSubview:_hisTableView];
    
    __weak typeof (self) wself = self;
    _searchbar.cancel_block = ^{
        [wself stopPlaying];
    };
    _searchbar.focus_block = ^{
        wself.hisTableView.hidden = NO;
    };
    _searchbar.invoke_block = ^(NSString *keyword){
        wself.hisTableView.hidden = YES;
        wself.searchbar.textField.text = keyword;
        [wself.searchbar hideKeyboard];
        [wself.delegate searchWithKeyword:keyword onTableView:wself.tableView];
        [wself.hisTableView reloadData];
    };
    
    [self startPlaying];
}

- (void)startPlaying
{
    UIView *bar = _viewController.navigationController.navigationBar;
    CGFloat dy = -CGViewGetHeight(bar);
    self.backgroundColor = hf_color(255,255,255,0);
    _tableView.alpha = 0;
    _hisTableView.alpha = 0;
    [UIView animateWithDuration:.2f animations:^{
        self.backgroundColor = hf_color(255,255,255,.95);
        _tableView.alpha = 1;
        _tableView.transform = CGAffineTransformMakeTranslation(0, dy);
        _hisTableView.alpha = 1;
        _hisTableView.transform = CGAffineTransformMakeTranslation(0, dy);
        
        _searchbar.transform = CGAffineTransformMakeTranslation(0, dy);
        bar.transform = CGAffineTransformMakeTranslation(0, dy - (1.f/[UIScreen mainScreen].scale));
        [_searchbar invoke];
    } completion:^(BOOL finished) {
        CGSize size = CGViewGetSize(self);
        _tableView.frame    = CGRectMake(0,CGViewGetY2(_searchbar),size.width,size.height-CGViewGetY2(_searchbar));
        _hisTableView.frame = CGRectMake(0,CGViewGetY2(_searchbar),size.width,size.height-CGViewGetY2(_searchbar));;

    }];
}

- (void)stopPlaying
{
    UIView *bar = _viewController.navigationController.navigationBar;
    [UIView animateWithDuration:.2f animations:^{
        self.backgroundColor = hf_color(255,255,255,0);
        _tableView.alpha = 0;
        _tableView.transform = CGAffineTransformIdentity;
        
        _hisTableView.alpha = 0;
        _hisTableView.transform = CGAffineTransformIdentity;
        
        _searchbar.transform = CGAffineTransformIdentity;
        bar.transform = CGAffineTransformIdentity;
        [_searchbar sleep];
    } completion:^(BOOL finished) {
        _searchbar.cancel_block = nil;
        _searchbar.invoke_block = nil;
        _searchbar.frame = [_barSuperview convertRect:_searchbar.bounds fromView:_searchbar];
        [_barSuperview addSubview:_searchbar];
        [self removeFromSuperview];
    }];
}

- (void)showHistory
{
    _hisTableView.hidden = NO;
}

- (void)hideHistory
{
    _hisTableView.hidden = YES;
}

- (void)stop
{
    [self stopPlaying];
}

- (void)hideKeybord
{
    [_searchbar hideKeyboard];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

}

//需要隐藏时调用
- (void)pause
{
    _viewController.navigationController.navigationBar.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:.2f animations:^{
        self.transform = CGAffineTransformMakeTranslation(-CGViewGetWidth(self), 0);
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication].keyWindow sendSubviewToBack:self];
    }];
}

//需要显示时调用
- (void)resume
{

    UIView *bar = _viewController.navigationController.navigationBar;
    bar.transform = CGAffineTransformMakeTranslation(0, -CGViewGetHeight(bar)-(1.f/[UIScreen mainScreen].scale));
    self.transform = CGAffineTransformIdentity;
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
}

#pragma mark 搜索记录

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_searchbar hideKeyboard];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(CGViewGetWidth(tableView),25);
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0,0,size.width,size.height)];
    v.backgroundColor =  hf_color(246,246,246,1);
   // [v drawBoxAsLayer];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 25)];
    //[EAViewUtil setLabel:textLabel :NSTextAlignmentLeft :ea_color_gray_154 :ea_font(12)];
    [v addSubview:textLabel];
    textLabel.text = @"搜索历史";
    return v;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_delegate historyItems].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (nil == cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
   
    cell.textLabel.textColor = hf_color(51,51,51,1);
    cell.textLabel.text = _delegate.historyItems[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = _delegate.historyItems[indexPath.row];
    _searchbar.invoke_block(key);
}

+ (EASearchView *)start:(EASearchBar *)searchBar
       onViewController:(UIViewController *)viewController
               delegate:(id<EASearchViewDelegate>)delegate
{
    UIView *window = [UIApplication sharedApplication].keyWindow;
    EASearchView *sv = [[EASearchView alloc] initWithFrame:window.bounds];
    searchBar.frame = [window convertRect:searchBar.bounds fromView:searchBar];
    [window addSubview:sv];
    [sv startWithSearchBar:searchBar onViewController:viewController delegate:delegate];
    return sv;
}
@end
