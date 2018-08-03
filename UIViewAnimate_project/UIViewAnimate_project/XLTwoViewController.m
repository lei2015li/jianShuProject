//
//  XLTwoViewController.m
//  UIViewAnimate_project
//
//  Created by xiaoli on 2018/8/3.
//  Copyright © 2018年 雷晓利. All rights reserved.
//

#import "XLTwoViewController.h"

@interface XLTwoViewController ()

/** <#属性说明#> */
@property (nonatomic, strong) UIButton *clickButton;

@end

@implementation XLTwoViewController

#pragma mark - LazyLoad 懒加载
- (UIButton *)clickButton {
    if (!_clickButton) {
        _clickButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width/2-30, (Main_Screen_Height-NavBarHeight-TabBarSafeHeight)/2-20, 60, 40)];
        _clickButton.backgroundColor = [UIColor orangeColor];
        [_clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clickButton setTitle:@"Begain" forState:UIControlStateNormal];
    }
    return _clickButton;
}

#pragma mark - LifeCyle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleStr;
    [self.view addSubview:self.clickButton];
    [self.clickButton addTarget:self action:@selector(clickAciton:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - Methods
- (void)clickAciton:(UIButton *)sender {
    UIView *startView = [[UIView alloc] initWithFrame:CGRectMake(0, NavBarHeight, 60, 60)];
    //startView.center = CGPointMake(30, NavBarHeight+30);
    startView.backgroundColor = randomColor;
    startView.layer.cornerRadius = 30;
    startView.layer.borderWidth = 5;
    startView.layer.borderColor = randomColor.CGColor;
    [self.view addSubview:startView];
    
    
    /*创建一个关键帧动画
     *参数1:动画时长8秒
     *参数2:动画延时0面
     *动画效果:线性 + 重复
     */
    [UIView animateKeyframesWithDuration:8 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear | UIViewAnimationOptionRepeat animations:^{
        //设计竖直方向6个位置
        CGFloat averageHeight = (Main_Screen_Height-NavBarHeight-TabBarSafeHeight-30-30)/5.0;
        for (NSInteger i=0; i<6; i++) {
            /*插入关键帧动画信息
             *参数1:表示关键帧动画开始的时刻在整个动画中的百分比
             *参数2:表示这个关键帧动画占用整个动画时长的百分比
             */
            [UIView addKeyframeWithRelativeStartTime:i/6.0 relativeDuration:1/6.0 animations:^{
                startView.center = CGPointMake(i%2==0 ? 30 : Main_Screen_Width-30 , averageHeight*i + NavBarHeight+30);
            }];
        }
        
    } completion:^(BOOL finished) {
        
    }];
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
