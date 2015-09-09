//
//  UIActionSheet+Blocks.m
//  cstApp
//
//  Created by LS on 7/6/15.
//  Copyright (c) 2015 Chansha Aijian Communication Transmit Civilization CO.,LTD. All rights reserved.
//

#import "UIActionSheet+Blocks.h"
#import <objc/runtime.h>

static NSString *ALERT_ACTIONS = @"buttons";
static NSString *DISMISS_ACTION_KEY = @"dismiss_action";

@implementation UIActionSheet (Blocks)

- (id)initWithTitle:(NSString *)title cancelAlertAction:(DSAlertAction *)cancelAlertAction destructiveAlertAction:(DSAlertAction *)destructiveAlertAction otherAlertActions:(DSAlertAction *)otherAlertAction, ...
{
    self = [self initWithTitle:title delegate:(id)self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    if(self)
    {
        NSMutableArray *alertActions = [NSMutableArray array];
        
        DSAlertAction *eachAction;
        va_list argumentList;
        if(otherAlertAction)
        {
            [alertActions addObject:otherAlertAction];
            va_start(argumentList, otherAlertAction);
            while ((eachAction = va_arg(argumentList, DSAlertAction *)))
            {
                [alertActions addObject:eachAction];
            }
            va_end(argumentList);
        }
        
        [alertActions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DSAlertAction *action = obj;
            [self addButtonWithTitle:action.title];
        }];
        
        if(destructiveAlertAction)
        {
            [alertActions addObject:destructiveAlertAction];
            NSInteger destIndex = [self addButtonWithTitle:destructiveAlertAction.title];
            [self setDestructiveButtonIndex:destIndex];
        }
        
        if(cancelAlertAction)
        {
            [alertActions addObject:cancelAlertAction];
            NSInteger cancelIndex = [self addButtonWithTitle:cancelAlertAction.title];
            [self setCancelButtonIndex:cancelIndex];
        }
        
        objc_setAssociatedObject(self, (__bridge void *)ALERT_ACTIONS, alertActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return self;
}

- (NSInteger)addAction:(DSAlertAction *)action
{
    NSMutableArray *alertActions = objc_getAssociatedObject(self, (__bridge void *)ALERT_ACTIONS);
    NSInteger buttonIndex = [self addButtonWithTitle:action.title];
    [alertActions addObject:action];
    
    return buttonIndex;
}

- (void)setDismissalAction:(void(^)())dismissalAction
{
    objc_setAssociatedObject(self, (__bridge const void *)DISMISS_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, (__bridge const void *)DISMISS_ACTION_KEY, dismissalAction, OBJC_ASSOCIATION_COPY);
}

- (void(^)())dismissalAction
{
    return objc_getAssociatedObject(self, (__bridge const void *)DISMISS_ACTION_KEY);
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0)
    {
        NSArray *buttonsArray = objc_getAssociatedObject(self, (__bridge const void *)ALERT_ACTIONS);
        DSAlertAction *item = [buttonsArray objectAtIndex:buttonIndex];
        if(item.alertActionBlock)
            item.alertActionBlock();
    }
    
    if (self.dismissalAction) self.dismissalAction();
    
    objc_setAssociatedObject(self, (__bridge const void *)ALERT_ACTIONS, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, (__bridge const void *)DISMISS_ACTION_KEY, nil, OBJC_ASSOCIATION_COPY);
}

@end
