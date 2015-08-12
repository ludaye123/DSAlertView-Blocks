//
//  DSAlertAction.m
//  cstApp
//
//  Created by LS on 7/6/15.
//  Copyright (c) 2015 Chansha Aijian Communication Transmit Civilization CO.,LTD. All rights reserved.
//

#import "DSAlertAction.h"

@implementation DSAlertAction

+ (id)actionWithTitle:(NSString *)title handler:(DSAlertActionBlock)alertActionBlock
{
    DSAlertAction *alertAction = [[DSAlertAction alloc] init];
    alertAction.title = title;
    alertAction.alertActionBlock = alertActionBlock;
    
    return alertAction;
}

@end
