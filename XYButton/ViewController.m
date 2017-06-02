//
//  ViewController.m
//  KeepBtn
//
//  Created by 徐阳 on 2017/6/2.
//  Copyright © 2017年 徐阳. All rights reserved.
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 处于研究的心理写了这个按钮，如果您发现有问题，防止误人子弟请及时联系我修正！
 *
 * 作者      : 臭码农
 * 简书地址   : http://www.jianshu.com/u/b309be9a40a7
 * GitHub   : https://github.com/XuYang8026
 * QQ       : 49900037
 
 *********************************************************************************
 
 */

#import "ViewController.h"
#import "XYButton.h"
#import <YYKit.h>

@interface ViewController ()
{
    XYButton *_leftBtn;
    XYButton *_rightBtn;
    XYButton *_pauseBtn;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"584f60"];
    //创建页面
    [self createUI];
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark ————— 创建页面 —————
-(void)createUI{
    @weakify(self);
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:100];
    label.text = @"Keep";
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.centerX = self.view.centerX;
    label.top = kScreenHeight / 4;
    [self.view addSubview:label];
    
    //左边按钮
    _leftBtn = [[XYButton alloc] initWithFrame:CGRectMake(0, 0, 85, 85) backgroundColor:[UIColor colorWithHexString:@"24c789"] borderColor:[UIColor colorWithHexString:@"584f60"] title:@"开始" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] tapBlock:^(UIButton *btn) {
        //点击事件
        [weak_self leftBtnClick];
        
    }];
    _leftBtn.left = kScreenWidth / 6;
    _leftBtn.bottom = kScreenHeight - 60;
    [self.view addSubview:_leftBtn];
    
    
    //右边按钮
    _rightBtn = [[XYButton alloc] initWithFrame:CGRectMake(0, 0, 85, 85) backgroundColor:[UIColor colorWithHexString:@"f35252"] borderColor:[UIColor colorWithHexString:@"f35252"] title:@"结束" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:18] tapBlock:^(UIButton *btn) {
        //点击事件
    }];
    _rightBtn.right = kScreenWidth - kScreenWidth / 6;
    _rightBtn.bottom = kScreenHeight - 60;
    [self.view addSubview:_rightBtn];
    
    
    //暂停按钮
    _pauseBtn = [[XYButton alloc] initWithFrame:CGRectMake(0, 0, 85, 85) backgroundColor:[UIColor whiteColor] borderColor:[UIColor colorWithHexString:@"584f60"] title:@"暂停" titleColor:[UIColor colorWithHexString:@"584f60"] font:[UIFont systemFontOfSize:18] tapBlock:^(UIButton *btn) {
        //点击事件
        [weak_self pauseBtnClick];
    }];
    _pauseBtn.centerX = self.view.centerX;
    _pauseBtn.bottom = kScreenHeight - 60;
    _pauseBtn.alpha = 0 ;
    _pauseBtn.transform = CGAffineTransformMakeScale(0.3,0.3);
    [self.view addSubview:_pauseBtn];
    
}
#pragma mark ————— 左边按钮点击 —————
-(void)leftBtnClick{
    
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:10 options:0 animations:^{
        _leftBtn.centerX = _rightBtn.centerX = self.view.centerX;
        _leftBtn.alpha = _rightBtn.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            
            _pauseBtn.alpha = 1;
            _pauseBtn.transform = CGAffineTransformIdentity;
        }];
    }];
    
}
#pragma mark ————— 暂停按钮点击 —————
-(void)pauseBtnClick{
    [UIView animateWithDuration:0.3 animations:^{
        _pauseBtn.alpha = 0;
    } completion:^(BOOL finished) {
        _pauseBtn.transform = CGAffineTransformMakeScale(0.3,0.3);
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:20 options:0 animations:^{
            _leftBtn.alpha = _rightBtn.alpha = 1;
            _leftBtn.left = kScreenWidth / 6;
            _rightBtn.right = kScreenWidth - kScreenWidth / 6;
        } completion:nil];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
