//
//  XLOneViewController.m
//  UIViewAnimate_project
//
//  Created by xiaoli on 2018/8/2.
//  Copyright © 2018年 雷晓利. All rights reserved.
//

#import "XLOneViewController.h"

@interface XLOneViewController ()

/** <#属性说明#> */
@property (nonatomic, strong) UIButton *clickButton;
/** <#属性说明#> */
@property (nonatomic, strong) UIImageView *animateIV;

@end

@implementation XLOneViewController


#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.titleStr;
    
    [self.view addSubview:self.clickButton];

    if (self.anmateType == XLAnimateTypeBackgroundColor) {
        self.animateIV.image = [UIImage imageNamed:@""];
        self.animateIV.backgroundColor = [UIColor redColor];
    } else {
        self.animateIV.image = [UIImage imageNamed:@"image_0"];
        self.animateIV.backgroundColor = [UIColor whiteColor];
    }
    
    
    XLWeakSelf;
    [self.clickButton block:^(id sender) {
        switch (weakSelf.anmateType) {
            case XLAnimateTypeBounds:
                [weakSelf boundsAnimation];
                break;
            case XLAnimateTypeFrame:
                [weakSelf frameAnimation];
                break;
            case XLAnimateTypeCenter:
                [weakSelf centerAnimation];
                break;
            case XLAnimateTypeBackgroundColor:
                [weakSelf backgroundAnimation];
                break;
            case XLAnimateTypeAlpha:
                [weakSelf alphaAnimation];
                break;
                
            case XLAnimateTypeTransformMoveUp: {
                [weakSelf transformMoveUpAnimate];
            }
                break;
            case XLAnimateTypeTransformMoveDown: {
                [weakSelf transformMoveDownAnimate];
            }
                break;
            case XLAnimateTypeTransformSlide: {
                [weakSelf transformSlideAnimate];
            }
                break;
            case XLAnimateTypeTransformScale: {
                [weakSelf transformScaleAnimate];
            }
                break;
            
            case XLAnimateTypeDamping:
                [weakSelf dampingAnimation];
                break;
            default:
                break;
        }
    }];
    [self.view addSubview:self.animateIV];
    
}


/*
 *MARK:- 坐标尺寸变化动画
 * bounds：修改这个属性会结合center属性重新计算frame。建议通过这个属性修改尺寸
 * frame：修改这个属性通常会导致视图形变的同时也发生移动，然后会重新设置center跟bounds属性
 * center: 设置后视图会移动到一个新位置，修改后会结合bounds重新计算frame
 */
/** 只改尺寸变化  */
- (void)boundsAnimation {
    /*
     *参数:动画时长
     *回调一:动画结束后,视图到达状态
     *回调二:动画执行完毕
     */
    [UIView animateWithDuration:0.3f animations:^{
        self.animateIV.bounds = CGRectMake(0, 0, 50, 50);
    } completion:^(BOOL finished) {
        self.animateIV.bounds = CGRectMake(0, 0, 100, 100);
    }];
}
/** 位置尺寸均变化  */
- (void)frameAnimation {
    [UIView animateWithDuration:0.3f animations:^{
        self.animateIV.frame = CGRectMake(200, NavBarHeight, 50, 50);
    } completion:^(BOOL finished) {
        self.animateIV.frame = CGRectMake(50, NavBarHeight+50, 100, 100);
    }];
}

/** 中心点变化 */
- (void)centerAnimation {
    [UIView animateWithDuration:0.3f animations:^{
        self.animateIV.center = CGPointMake(150, NavBarHeight+50+ 100);
    }];
}

/*
 *MARK:- 视图显示动画
 * backgroundColor: 修改这个属性会产生颜色渐变过渡的效果，本质上是系统不断修改了tintColor来实现的
 * alpha：修改这个属性会产生淡入淡出的效果
 */
/** 背景色变化 */
- (void)backgroundAnimation {
    [UIView animateWithDuration:1.0f  animations:^{
        self.animateIV.backgroundColor = [UIColor purpleColor];
    } completion:^(BOOL finished) {
        self.animateIV.backgroundColor = [UIColor redColor];
    }];
}

/** 透明度变化 */
- (void)alphaAnimation {
    [UIView animateWithDuration:0.3f animations:^{
        self.animateIV.alpha = 0.3f;
    } completion:^(BOOL finished) {
        self.animateIV.alpha = 1.0f;
    }];
}



/*
 *MARK:- 形态变换动画 transform(下期单讲)
 *transform：修改这个属性可以实现旋转、形变、移动、翻转等动画效果，其通过矩阵运算的方式来实现，因此更加强大 
 */
/** 向上平移 */
- (void)transformMoveUpAnimate {
    
    [UIView animateWithDuration:0.5 animations:^{
        // 使用Make,它是相对于最原始的位置做的形变,开发中，不用这个，只能移动一次，
        // 看见有Make,就只能移动一次，
        // self.animateIV.transform = CGAffineTransformMakeTranslation(0, -20);
        // 相对于上一次做形变，开发中经常使用下面的
        self.animateIV.transform = CGAffineTransformTranslate(self.animateIV.transform, 0, -20);
    }];

}
/** 向下平移 */
- (void)transformMoveDownAnimate {
    [UIView animateWithDuration:0.5 animations:^{
        //使用Make,它是相对于最原始的位置做的形变.
        //self.animateIV.transform = CGAffineTransformMakeTranslation(0, 20);
        //相对于上一次做形变.
        self.animateIV.transform = CGAffineTransformTranslate(self.animateIV.transform, 0, 20);
    }];
    
}

/** 旋转 */
- (void)transformSlideAnimate {
    [UIView animateWithDuration:0.5 animations:^{
        //旋转的度数, 是一个弧度
        //使用Make,它是相对于最原始的位置做的形变.
        //self.animateIV.transform = CGAffineTransformMakeRotation(M_PI_4);
        self.animateIV.transform = CGAffineTransformRotate(self.animateIV.transform, M_PI_4);
    }];
 
}

/** 缩放 */
- (void)transformScaleAnimate {
    [UIView animateWithDuration:0.5 animations:^{
        //使用Make,它是相对于最原始的位置做的形变.
        //self.animateIV.transform = CGAffineTransformMakeScale(0.8, 0.8);
        self.animateIV.transform = CGAffineTransformScale(self.animateIV.transform, 0.8, 0.8);
    }];
    
}

/** 阻尼动画 */
- (void)dampingAnimation {
    //随即一个高度, 50~300
    CGFloat h = arc4random() % 251 + 50;
    //带有弹跳效果的动画
    //Damping:阻尼,取值0~1
    //Velocity:速度 像素/秒
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:30 options:UIViewAnimationOptionCurveLinear animations:^{
        
        CGRect frame = self.animateIV.frame;
        frame.size.height = h;
        self.animateIV.frame = frame;
        
        //self.animateIV.ly_height = h;
    } completion:nil];
}


#pragma mark - LazyLoad 懒加载
- (UIButton *)clickButton {
    if (!_clickButton) {
        _clickButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width/2-40, Main_Screen_Height-TabBarSafeHeight-140, 80, 40)];
        _clickButton.backgroundColor = [UIColor orangeColor];
        [_clickButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_clickButton setTitle:@"开始" forState:UIControlStateNormal];
    }
    return _clickButton;
}

- (UIImageView *)animateIV {
    if (!_animateIV) {
        _animateIV = [[UIImageView alloc] initWithFrame:CGRectMake(50, NavBarHeight+50, 100, 100)];
        _animateIV.image = [UIImage imageNamed:@"image_0"];
    }
    return _animateIV;
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
