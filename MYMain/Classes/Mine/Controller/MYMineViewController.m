//
//  MYMineViewController.m
//  MYMain
//
//  Created by admin on 16/6/23.
//  Copyright © 2016年 XiChuan. All rights reserved.
//

#import "MYMineViewController.h"
#import "EMSDK.h"
#import "MYLoginViewController.h"

// 顶部图片的高度
#define MYTopViewH  (HEIGHT*0.20)

@interface MYMineViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property  (strong,nonatomic)  UITableView *tableView;
/** 顶部View */
@property   (strong,nonatomic) UIView *tableHeaderView;
/** 顶部View 上的背景 UIImageView */
@property  (strong,nonatomic)  UIImageView *topImageView;
/** 背景UIImageView 上的buttton */
@property  (strong,nonatomic)  UIButton *circleBtn;
/** 背景UIImageView 上的label */
@property  (strong,nonatomic)  UILabel *textLabel;

@end

@implementation MYMineViewController

static NSString *ID = @"inmine";

#pragma mark - 懒加载 tableView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64,WIDTH, HEIGHT-64)];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        //点击cell移动，不显示竖直方向的滚动条
        _tableView.showsVerticalScrollIndicator=NO;
        // 自动调整view的宽和高，保证上下左右边距不变。如把tableView设置为此属性，那么无论viewController的view是多大，都能自动铺满
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    }
    return _tableView;
}

#pragma mark - 懒加载 顶部View
-(UIView *)tableHeaderView{
    if (!_tableHeaderView) {
        _tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, MYTopViewH)];
        // 用户交互
        _tableHeaderView.userInteractionEnabled = YES;
    }
    return _tableHeaderView;
}

#pragma mark - 懒加载 顶部View 上的背景 UIImageView
-(UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, MYTopViewH)];
        // 自动调整image的宽和高，保证上下左右边距不变
        _topImageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        // 图片边界剪切
        _topImageView.clipsToBounds=YES;
        // 高度改变宽度也跟着改变 重点（不设置那将只会被纵向拉伸）
        _topImageView.contentMode=UIViewContentModeScaleAspectFill;
        
        _topImageView.image=[UIImage imageNamed:@"123.jpg"];
        // 用户交互
        _topImageView.userInteractionEnabled = YES;
    }
    return _topImageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 界面的互相添加
    [self.tableHeaderView addSubview:self.topImageView];
    self.tableView.tableHeaderView=self.tableHeaderView;
    [self.view addSubview:self.tableView];
    
    // 头像
    _circleBtn = [[UIButton alloc] init];
    _circleBtn.layer.cornerRadius = 7.5f;
    [_circleBtn setImage:[UIImage imageNamed:@"123.jpg"] forState:UIControlStateNormal];
    _circleBtn.clipsToBounds = YES;
    _circleBtn.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [_circleBtn addTarget:self action:@selector(personalCenterBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.topImageView addSubview:_circleBtn];
    [_circleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topImageView.mas_centerX);
        make.centerY.equalTo(self.topImageView.mas_centerY);
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
    }];
    
    // 用户名
    _textLabel = [[UILabel alloc] init];
    _textLabel.textColor = [UIColor whiteColor];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.text = @"退出登录";
    _textLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;//自动布局，自适应顶部
    [self.topImageView addSubview:_textLabel];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topImageView.mas_centerX);
        make.top.equalTo(_circleBtn.mas_bottom);
        make.width.equalTo(@(120));
        make.height.equalTo(@(30));
    }];
    
}

#pragma  mark - 顶部图片拉大效果
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect =self.tableHeaderView.frame;
        rect.origin.y = offset.y;
        rect.size.height =CGRectGetHeight(rect)-offset.y;
        self.topImageView.frame = rect;
        self.tableHeaderView.clipsToBounds=NO;
    }
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"第-%ld-天 ",indexPath.row];
    return cell;
}

#pragma mark - 用户登录设置
- (void)personalCenterBtn{
    
    EMError *error = [[EMClient sharedClient] logout:YES];
    if (!error) {
        MYLog(@"退出登录");
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        MYLoginViewController *loginVC = [[MYLoginViewController alloc] init];
        window.rootViewController = loginVC;
     
    }
}


@end
