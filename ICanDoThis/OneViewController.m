//
//  OneViewController.m
//  ICanDoThis
//
//  Created by THF on 16/8/16.
//  Copyright © 2016年 thf. All rights reserved.
//

#define headH 200
#define headMinH 64
#define tabBarH 44

#import "UIImage+Image.h"
#import "OneViewController.h"
#import "ModelOne.h"

typedef enum {
    SexMale,
    SexFemale
}Sex;

@interface OneViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSArray * array;

@property (nonatomic, weak) UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHCons;

@property (nonatomic, assign) CGFloat lastOffsetY;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

  //  [self createBtn];
    
    [self testModel];
    
    [self testXiaLa];
    
}

- (void)testXiaLa
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _lastOffsetY = -(headH + tabBarH);
    
    self.tableView.contentInset = UIEdgeInsetsMake(headH + tabBarH, 0, 0, 0);

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 给导航条的背景图片传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 隐藏底部阴影条，传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = @"U Can Do Too";
    [nameLabel sizeToFit];
    self.navigationItem.titleView = nameLabel;
    _nameLabel = nameLabel;
    nameLabel.alpha = 0;
}


- (void)testModel
{
//    NSDictionary * dict  = @{
//                             @"name":@"hf",
//                             @"icon" : @"lufy.png",
//                             @"age" : @20,
//                             @"height" : @"1.55",
//                             @"money" : @100.9,
//                             @"sex" : @(SexFemale),
//                             @"gay" : @"true",
//                             };

   // ModelOne * modelone = [ModelOne mj_objectWithKeyValues:dict];
    
    NSDictionary * dict  = @{
                             @"name":@"hf",
                           
                             };

    ModelOne * modelone = [[ModelOne alloc]init];
    [modelone setValuesForKeysWithDictionary:dict];
    NSLog(@"%@",modelone.name);
    
}


- (void)createBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(100, 100, 100, 100);
    
    btn.backgroundColor = [UIColor blackColor];
    
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)btnclick
{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat delta = offsetY - _lastOffsetY;
   
    
    // 往上拖动，高度减少。
    CGFloat height = headH - delta;//height就是头视图的高度
    
    NSLog(@" offsetY%f  delta %f  height %f",offsetY,delta,height);
    
    if (height < headMinH) {
        height = headMinH;
    }
    
    _headHCons.constant = height;
    
    // 设置导航条的背景图片
    CGFloat alpha = delta / (headH - headMinH);
    
    // 当alpha大于1，导航条半透明，因此做处理，大于1，就直接=0.99
    if (alpha >= 1) {
        alpha = 0.99;
    }
    _nameLabel.alpha = alpha;
    // 设置导航条的背景图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:0.9 alpha:alpha]];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    
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
