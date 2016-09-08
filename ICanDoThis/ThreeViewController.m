//
//  ThreeViewController.m
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#import "ThreeViewController.h"
#import "ThreeViw.h"
#import "PurchaseCarAnimationTool.h"
#import "EASearchBar.h"
#import "EASearchView.h"

@interface ThreeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic) UITableView *tableView;
@property (strong , nonatomic) UIImageView *imageView;
@property(nonatomic, strong) EASearchBar *searchBar;
@property(nonatomic, weak) EASearchView *searchView;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSearch];
    
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"哈";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 80, 80)];
    [self.view addSubview:_imageView];
    [_imageView setImage:[UIImage imageNamed:@"qingwa"]];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 130, 42)];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clickCar) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addSearch
{
    CGSize size = CGViewGetSize(self.view);
    
    CGFloat height = [EASearchBar height];
    //搜索
    _searchBar = [[EASearchBar alloc] initWithFrame:CGRectMake(0,0,size.width,height)];
    __weak typeof(self) wself = self;
    _searchBar.start_block = ^{
        wself.searchBar.textField.placeholder = @"请输入患者姓名、诊断或手机号";
        [wself invokeSearch];
    };
    [self.view addSubview:_searchBar];
  
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,height,size.width, size.height-height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = nil;
    
    [self.view addSubview:_tableView];
    
    //绑定搜索框和列表
    [_searchBar attachWithTableView:_tableView];
    [_searchBar hideWithAnimated:NO];
    
}

- (void)invokeSearch
{
     _searchView = [EASearchView start:_searchBar onViewController:self delegate:nil];
}


-(void)clickCar
{
    [[PurchaseCarAnimationTool shareTool]startAnimationandView:_imageView andRect:_imageView.frame andFinisnRect:CGPointMake(ScreenWidth/4*2.5, ScreenHeight-49) andFinishBlock:^(BOOL finisn){
        UIView *tabbarBtn = self.tabBarController.tabBar.subviews[3];
        [PurchaseCarAnimationTool shakeAnimation:tabbarBtn];
    }];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                ];
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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

@end
