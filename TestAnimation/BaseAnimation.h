//
//  BaseAnimation.h
//  TestAnimation
//
//  Created by geng lei on 15/6/17.
//  Copyright (c) 2015年 com.fengche.cn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum {
    AnimationTypePresent,
    AnimationTypeDismiss
}AnimationType;

@interface BaseAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic,assign) AnimationType type;

@end
