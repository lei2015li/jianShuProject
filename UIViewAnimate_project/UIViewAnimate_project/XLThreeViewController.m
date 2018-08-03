//
//  XLThreeViewController.m
//  UIViewAnimate_project
//
//  Created by 雷晓利 on 2018/8/3.
//  Copyright © 2018年 雷晓利. All rights reserved.
//

#import "XLThreeViewController.h"

@interface XLThreeViewController ()


@property (nonatomic, strong) UIView *baseView;

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIButton *clickButton;


@end

@implementation XLThreeViewController


#pragma mark - LifeCyle 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleStr;
    
    [self.view addSubview:self.baseView];
    [self.baseView addSubview:self.topView];
    
    [self.view addSubview:self.clickButton];
    XLWeakSelf;
    [self.clickButton block:^(id sender) {
        switch (weakSelf.tranType) {
            case XLTransitionTypeNone://没有转场动画效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionNone];
                break;
            case XLTransitionTypeFlipFromLeft://从左侧翻转效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionFlipFromLeft];
                break;
            case XLTransitionTypeFlipFromRight://从右侧翻转效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionFlipFromRight];
                break;
            case XLTransitionTypeCurlUp://向后翻页的动画过渡效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionCurlUp];
                break;
            case XLTransitionTypeCurlDown://向前翻页的动画过渡效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionCurlDown];
                break;
            case XLTransitionTypeCrossDissolve://旧视图溶解消失显示下一个新视图的效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionCrossDissolve];
                break;
            case XLTransitionTypeFlipFromTop://从上方翻转效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionFlipFromTop];
                break;
            case XLTransitionTypeFlipFromBottom://底部翻转效果
                [weakSelf makeTransitionType:UIViewAnimationOptionTransitionFlipFromBottom];
                break;
            default:
                break;
        }
        
    }];
    
    
}
#pragma mark - Methods
- (void)makeTransitionType:(UIViewAnimationOptions)animationTransitionType {
    if ([[self.baseView subviews] containsObject:self.bottomView]) {
        [UIView transitionFromView:self.bottomView toView:self.topView duration:1.0f options:animationTransitionType completion:^(BOOL finished){
            [self.bottomView removeFromSuperview];
        }];
        [self.baseView addSubview:self.topView];
    } else {
        [UIView transitionFromView:self.topView toView:self.bottomView duration:1.0f options:animationTransitionType completion:^(BOOL finished){
            [self.topView removeFromSuperview];
        }];
        [self.baseView addSubview:self.bottomView];
    }
}
#pragma mark - LazyLoad 懒加载
- (UIView *)baseView {
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(20, NavBarHeight+20, 100, 150)];
        _baseView.backgroundColor = [UIColor whiteColor];
    }
    return _baseView;
}
- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
        _topView.backgroundColor = [UIColor purpleColor];
    }
    return _topView;
}
- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
        _bottomView.backgroundColor = [UIColor yellowColor];
    }
    return _bottomView;
}
- (UIButton *)clickButton {
    if (!_clickButton) {
        _clickButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width/2-40, Main_Screen_Height-TabBarSafeHeight-140, 80, 40)];
        _clickButton.backgroundColor = [UIColor orangeColor];
        [_clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clickButton setTitle:@"开始" forState:UIControlStateNormal];
    }
    return _clickButton;
}





@end
