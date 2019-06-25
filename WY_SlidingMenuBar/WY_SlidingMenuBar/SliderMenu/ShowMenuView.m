
//
//  ShowMenuView.m
//  WY_SlidingMenuBar
//
//  Created by Margin on 2019/6/24.
//  Copyright © 2019 Margin. All rights reserved.
//

#import "ShowMenuView.h"

@interface ShowMenuView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *mainTableView;

@property (nonatomic, strong) NSMutableArray *dataArr;;

@end


#define w_Screen_Width  [UIScreen mainScreen].bounds.size.width
#define w_Screen_Height [UIScreen mainScreen].bounds.size.height

static NSString *const cellID = @"tableViewCellIdentifier";

@implementation ShowMenuView

#pragma mark ---------------view LifeCycle
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        //设置UI
        [self setUpUI];
        
        //加载数据
        [self loadData];

        
    }
    return self;
}

//setUpUI
- (void)setUpUI{
    
    self.mainTableView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.mainTableView];
    
}


- (void)loadData{
    self.dataArr = @[].mutableCopy;
    
    for (int i = 0; i<11; i++) {
        NSString *imageName = [NSString stringWithFormat:@"person-icon%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        
        NSString *title = [NSString stringWithFormat:@"功能选择项%d",i];
        
        NSDictionary *dic = @{@"image":image , @"title" : title};
        
        [self.dataArr addObject:dic];
    }
    
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    NSDictionary *dic = self.dataArr[indexPath.row];
    
    cell.imageView.image = [dic objectForKey:@"image"];
    cell.textLabel.text = [dic objectForKey:@"title"];
    
    
    
    
    return cell;
}


#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //填充sectionHeader
    UIView *placeHolderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w_Screen_Width, 80)];
    placeHolderView.backgroundColor = [UIColor redColor];
    
    return placeHolderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 80;
}


#pragma mark ---------------LazyLoading
- (UITableView *)mainTableView{
    
    if (_mainTableView == nil) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate   = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = [UIColor whiteColor];
        
        // 注册cell
        [_mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        
    }
    return _mainTableView;
}


@end
