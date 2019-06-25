//
//  ViewController.m
//  WY_SlidingMenuBar
//
//  Created by Margin on 2019/6/24.
//  Copyright © 2019 Margin. All rights reserved.
//

#import "ViewController.h"

#import "SliderMenuView.h"
#import "ShowMenuView.h"

@interface ViewController ()

@property (nonatomic, strong) SliderMenuView *menuView;

@end

#define w_Screen_Width  [UIScreen mainScreen].bounds.size.width
#define w_Screen_Height [UIScreen mainScreen].bounds.size.height

@implementation ViewController

#pragma mark ---------------LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
    //初始要侧栏要显示的View
    ShowMenuView *showMenuView = [[ShowMenuView alloc]initWithFrame:CGRectMake(0, 0, w_Screen_Width * 0.6, w_Screen_Height)];
    //生成菜单栏载体view
    SliderMenuView *sliderMenuView = [SliderMenuView initMenuViewOnSuperView:self.view MenuView:showMenuView needAnimation:YES direction:PushDirectionLeft];
    
    self.menuView = sliderMenuView;
    
}

- (void)setUpUI{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(showMenuView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
}


- (void)showMenuView{
    
    [self.menuView showSliderMenuView];
}





@end
