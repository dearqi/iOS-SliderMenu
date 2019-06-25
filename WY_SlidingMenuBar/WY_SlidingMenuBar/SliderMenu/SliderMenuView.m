//
//  SliderMenuView.m
//  WY_SlidingMenuBar
//
//  Created by Margin on 2019/6/24.
//  Copyright © 2019 Margin. All rights reserved.
//

#import "SliderMenuView.h"

@interface SliderMenuView()<UIGestureRecognizerDelegate>

//显示的菜单view
@property (nonatomic, strong) UIView *sliderMenuView;

@property (nonatomic, assign) BOOL pushAnimated;

@property (nonatomic, assign) PushDirection pushDirection;
//当前view所在的容器view
@property (nonatomic, strong) UIView *superView;

@end

#define w_Screen_Width  [UIScreen mainScreen].bounds.size.width
#define w_Screen_Height [UIScreen mainScreen].bounds.size.height



typedef NS_ENUM(NSInteger , Frametype) {
    FrametypeShow    = 0, //显示动画
    FrametypeDismiss = 1, //隐藏动画
    
};


@implementation SliderMenuView

#pragma mark ---------------view init

+ (instancetype)initMenuViewOnSuperView:(UIView *)superView MenuView:(UIView *)menuView needAnimation:(BOOL)animated direction:(PushDirection)direction{
    
    SliderMenuView *menu = [[SliderMenuView alloc]initMenuViewOnSuperView:superView MenuView:menuView needAnimation:animated direction:direction];
    
    return menu;
}

- (instancetype)initMenuViewOnSuperView:(UIView *)superView MenuView:(UIView *)menuView needAnimation:(BOOL)animated direction:(PushDirection)direction{
    
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, w_Screen_Width, w_Screen_Height);

        //设置背景色(初始透明度为0.1)
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        //持有容器View
        self.superView = superView ? superView : [UIView new];
        //持有菜单View
        self.sliderMenuView = menuView ? menuView : [UIView new];
        

        //默认无动画
        self.pushAnimated = animated ? animated : NO;
        
        //默认左边push
        self.pushDirection = direction ? direction : PushDirectionLeft;
        
        [self addSubview:menuView];
        
        CGFloat viewWidth  = self.sliderMenuView.frame.size.width;
        CGFloat viewHeight = self.sliderMenuView.frame.size.height;
        
        //设置MenuView的初始位置
        if (direction == PushDirectionLeft) {
            menuView.frame = CGRectMake(0 - viewWidth, 0, viewWidth, viewHeight);
        }else{
            menuView.frame = CGRectMake(w_Screen_Width, 0, viewWidth, viewHeight);
        }
        
        
        //添加点击移除、侧滑手势
        [self addPanGesture];
        
    }
    
    return self;
}

#pragma mark ---------------gesture
- (void)addPanGesture{
    
    //为自身view添加点击移除手势
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(disMissView)];
    gesture.delegate = self;
    
    [self addGestureRecognizer:gesture];
    
    //为容器view添加侧滑展示手势
    UIScreenEdgePanGestureRecognizer *panGesture = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(showSliderMenuView)];
    if (self.pushDirection == PushDirectionLeft) {
        panGesture.edges = UIRectEdgeLeft;//左侧边缘响应
    }else{
        panGesture.edges = UIRectEdgeRight;//右侧边缘响应
    }
    
    [self.superView addGestureRecognizer:panGesture];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view == self) {//只有点击自身才可消失
        return YES;
    }
    return NO;
}


#pragma mark ---------------view Action
- (void)disMissView{
    //移除当前View
    [self dissMissSliderMenuView];
    
}

//获取menuView的frame
- (CGRect)getSliderMenuViewFinalRectWithAction:(Frametype )frameType{
    //获取menuView初始宽高
    CGFloat viewWidth  = self.sliderMenuView.frame.size.width;
    CGFloat viewHeight = self.sliderMenuView.frame.size.height;
    
    //设置menuView初始、结束位置
//    CGRect origialRect = CGRectMake(0, 0, viewWidth, viewHeight);
    CGRect finalRect   = CGRectMake(0, 0, viewWidth, viewHeight);
    
    if (frameType == FrametypeShow) {//view需要展示
        
        if (self.pushDirection == PushDirectionLeft) {//左边推出
            finalRect.origin.x = 0;
        }else{
            finalRect.origin.x = w_Screen_Width - viewWidth;
        }
        
    }else{//View需要消失
        
        if (self.pushDirection == PushDirectionLeft) {//左边推出
            finalRect.origin.x = 0 - viewWidth;
        }else{
            finalRect.origin.x = w_Screen_Width;
        }
        
        
    }
    return finalRect;
}


- (void)showSliderMenuView{//显示动画
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    [window addSubview:self];
    //获取结束位置
    CGRect finalRect   = [self getSliderMenuViewFinalRectWithAction:FrametypeShow];

    if (self.pushAnimated) {//是否需要动画方式展现

        [UIView animateWithDuration:0.3 animations:^{
            self.sliderMenuView.frame = finalRect;
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        }];

    }else{

        self.sliderMenuView.frame = finalRect;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];

    }

    
}


- (void)dissMissSliderMenuView{
    //获取结束位置
    CGRect finalRect   = [self getSliderMenuViewFinalRectWithAction:FrametypeDismiss];
    
    if (self.pushAnimated) {//是否需要动画方式展现
        
        [UIView animateWithDuration:0.3 animations:^{
            self.sliderMenuView.frame = finalRect;
            self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        } completion:^(BOOL finished) {
           [self removeFromSuperview];
        }];
        
    }else{
       [self removeFromSuperview];
    }
    
}


@end
