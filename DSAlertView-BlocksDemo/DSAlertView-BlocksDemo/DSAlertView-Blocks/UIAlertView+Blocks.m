//
//  UIAlertView+Blocks.m
//  cstApp
//
//  Created by LS on 7/6/15.
//  Copyright (c) 2015 Chansha Aijian Communication Transmit Civilization CO.,LTD. All rights reserved.
//

#import "UIAlertView+Blocks.h"
#import <objc/runtime.h>


static NSString * const ALERT_ACTIONS = @"buttons";

@implementation UIAlertView (Blocks)

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelAlertAction:(DSAlertAction *)cancelAlertAction otherAlertActions:(DSAlertAction *)otherAlertActions, ...
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelAlertAction.title otherButtonTitles:nil, nil];
    if(self)
    {
        NSMutableArray *alertActions = [self alertActions];
        DSAlertAction *eachAction;
        va_list argumentsList;
        if(otherAlertActions)
        {
            [alertActions addObject:otherAlertActions];
            va_start(argumentsList, otherAlertActions);
            while ((eachAction = va_arg(argumentsList, DSAlertAction *)))
            {
                [alertActions addObject:eachAction];
            }
            va_end(argumentsList);
        }
        
        [alertActions enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           
            DSAlertAction *action = obj;
            [self addButtonWithTitle:action.title];
        }];
        
        if(cancelAlertAction)
        {
            [alertActions insertObject:cancelAlertAction atIndex:0];
        }
        self.delegate = self;
    }
    
    return self;
}


- (NSInteger)addAction:(DSAlertAction *)action
{
    NSInteger buttonIndex = [self addButtonWithTitle:action.title];
    [[self alertActions] addObject:action];
    
    if(!self.delegate)
        self.delegate = self;
    
    return buttonIndex;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex >= 0)
    {
        NSArray *alertActions = objc_getAssociatedObject(self, (__bridge void *)ALERT_ACTIONS);
        DSAlertAction *alertAction = alertActions[buttonIndex];
        if(alertAction.alertActionBlock)
            alertAction.alertActionBlock();
    }    
    objc_setAssociatedObject(self, (__bridge void *)ALERT_ACTIONS, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)alertActions
{
    NSMutableArray *alertActions = objc_getAssociatedObject(self, (__bridge void *)ALERT_ACTIONS);
    if(!alertActions)
    {
        alertActions = [NSMutableArray array];
        objc_setAssociatedObject(self, (__bridge void *)ALERT_ACTIONS, alertActions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return alertActions;
}

@end
