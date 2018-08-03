//
//  UIButton+Block.m
//  UIViewAnimate_project
//
//  Created by xiaoli on 2018/8/2.
//  Copyright © 2018年 雷晓利. All rights reserved.
//

#import "UIButton+Block.h"

static const char *overviewKey = "buttonActionKey";

@implementation UIButton (Block)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(ActionBlock)block {
    //这个方法的是意思是为UIButton这个类添加一个属性叫block,overviewKey是键值
    objc_setAssociatedObject(self, overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:event];
}

- (void)block:(ActionBlock)block{
    objc_setAssociatedObject(self, overviewKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(callActionBlock:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)callActionBlock:(id)sender {
    ActionBlock block = (ActionBlock)objc_getAssociatedObject(self, overviewKey);
    if (block) {
        block(sender);
    }
}


@end
