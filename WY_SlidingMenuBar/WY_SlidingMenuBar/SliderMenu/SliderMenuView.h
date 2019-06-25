//
//  SliderMenuView.h
//  WY_SlidingMenuBar
//
//  Created by Margin on 2019/6/24.
//  Copyright © 2019 Margin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger , PushDirection) {
    PushDirectionLeft  = 0,  //从左至右弹出
    PushDirectionRight = 1,  //从右至左弹出
    
};


//侧滑view显示功能集成View
@interface SliderMenuView : UIView


/**
 初始化菜单

 @param superView 菜单弹出依赖视图
 @param menuView 菜单视图
 @param animated 是否需要动画
 @param direction 弹出方式
 @return return value description
 */
+ (instancetype)initMenuViewOnSuperView:(UIView *)superView MenuView:(UIView *)menuView needAnimation:(BOOL)animated direction:(PushDirection)direction;


//显示菜单View
- (void)showSliderMenuView;
//移除菜单View
- (void)dissMissSliderMenuView;


@end

NS_ASSUME_NONNULL_END
