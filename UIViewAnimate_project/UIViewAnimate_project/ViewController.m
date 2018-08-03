//
//  ViewController.m
//  UIViewAnimate_project
//
//  Created by xiaoli on 2018/8/2.
//  Copyright © 2018年 雷晓利. All rights reserved.
//

#import "ViewController.h"



#import "XLOneViewController.h"
#import "XLTwoViewController.h"
#import "XLThreeViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

/** <#属性说明#> */
@property (nonatomic, strong) UITableView *tableView;
/** <#属性说明#> */
@property (nonatomic, strong) NSMutableArray *dataArr;


@end

@implementation ViewController

#pragma mark - LifeCycle 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"main";
    [self.view addSubview:self.tableView];
}

#pragma mark - LazyLoad 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@[@"bounds", @"frame", @"center"], @[@"backgroundColor", @"alpha"], @[@"transform上移", @"transform下移", @"transform旋转", @"transform缩放"], @[@"transitionNone", @"transitionFlipFromLeft", @"transitionFlipFromRight", @"transitionCurlUp", @"transitionCurlDown", @"transitionCrossDissolve", @"transitionFlipFromTop", @"transitionFlipFromBottom"], @[@"阻尼动画"], @[@"关键帧动画"]].mutableCopy;
    }
    return _dataArr;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavBarHeight, Main_Screen_Width, Main_Screen_Height - TabBarSafeHeight - NavBarHeight) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
#pragma mark - Delegate and DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.dataArr count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataArr[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataArr[indexPath.section][indexPath.row];//[NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XLOneViewController *oneVC = [[XLOneViewController alloc] init];
    oneVC.titleStr = self.dataArr[indexPath.section][indexPath.row];
    switch (indexPath.section) {
        case 0: {
            oneVC.anmateType = indexPath.row;
            [self.navigationController pushViewController:oneVC animated:YES];
        }
            break;
        case 1: {
            if (indexPath.row == 0) {
                oneVC.anmateType = XLAnimateTypeBackgroundColor;
            } else if (indexPath.row == 1) {
                oneVC.anmateType = XLAnimateTypeAlpha;
            }
            [self.navigationController pushViewController:oneVC animated:YES];
        }
            break;
        case 2: {
            
            if (indexPath.row == 0) {
                oneVC.anmateType = XLAnimateTypeTransformMoveUp;//上移
            } else if (indexPath.row == 1) {
                oneVC.anmateType = XLAnimateTypeTransformMoveDown;//下移
            } else if (indexPath.row == 2) {
                oneVC.anmateType = XLAnimateTypeTransformSlide;//旋转
            } else if (indexPath.row == 3) {
                oneVC.anmateType = XLAnimateTypeTransformScale;//缩放
            }
            [self.navigationController pushViewController:oneVC animated:YES];
        }
            break;
        case 3: {
            XLThreeViewController *threeVC = [XLThreeViewController new];
            threeVC.tranType = indexPath.row;
            threeVC.titleStr = self.dataArr[indexPath.section][indexPath.row];
            [self.navigationController pushViewController:threeVC animated:YES];
        }
            break;
        case 4: {
            oneVC.anmateType = XLAnimateTypeDamping;
            [self.navigationController pushViewController:oneVC animated:YES];
        }
            break;
        case 5: {
            XLTwoViewController *twoVC = [XLTwoViewController new];
            twoVC.titleStr = self.dataArr[indexPath.section][indexPath.row];
            [self.navigationController pushViewController:twoVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
    
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    view.backgroundColor = RGB(237, 237, 244);
    UILabel *markLabel = [[UILabel alloc]init];
    markLabel.frame = CGRectMake(10, 5, Main_Screen_Width - 10*2, 30);
    markLabel.textColor = [UIColor darkGrayColor];
    markLabel.textAlignment = NSTextAlignmentLeft;
    markLabel.font = CHINESE_SYSTEM_REGULAR_FONT(14);
    [view addSubview:markLabel];
    switch (section) {
        case 0: {
            markLabel.text = @"坐标尺寸动画";
        }
            break;
        case 1: {
            markLabel.text = @"视图显示动画";
        }
            break;
        case 2: {
            markLabel.text = @"形态变换动画";
        }
            break;
        case 3: {
            markLabel.text = @"几种转场动画";
        }
            break;
        case 4: {
            markLabel.text = @"阻尼动画";
        }
            break;
        case 5: {
            markLabel.text = @"关键帧动画";
        }
            break;
        default:
            break;
    }
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
