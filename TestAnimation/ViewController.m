//
//  ViewController.m
//  TestAnimation
//
//  Created by geng lei on 15/6/16.
//  Copyright (c) 2015年 com.fengche.cn. All rights reserved.
//

#import "ViewController.h"
#import "ModelAnimation.h"
#import "OneViewController.h"
@interface ViewController (){
    ModelAnimation * _modelAnimatiomController;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configeNavationItem];
    _modelAnimatiomController = [[ModelAnimation alloc]init];
    self.view.backgroundColor = [UIColor orangeColor];
    
}
#pragma mark - configNavationItem
-(void)configeNavationItem{
    self.title = @"Animation";
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * leftItem = [UIButton buttonWithType:UIButtonTypeCustom];
    leftItem.frame = CGRectMake(0, 0, 40, 30);
    [leftItem setTitle:@"选项" forState:UIControlStateNormal];
    [leftItem setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftItem addTarget:self action:@selector(option:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItem];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - btnAction
-(void)option:(UIButton*)sender{
    OneViewController * control = [[OneViewController alloc]initWithNibName:@"OneViewController" bundle:[NSBundle mainBundle]];
    control.transitioningDelegate = self;
    control.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:control animated:YES completion:nil];
    
}
#pragma mark - Transitioning Delegate (Modal)
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    _modelAnimatiomController.type = AnimationTypePresent;
    return _modelAnimatiomController;
}
-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    _modelAnimatiomController.type = AnimationTypeDismiss;
    return _modelAnimatiomController;
}
@end
