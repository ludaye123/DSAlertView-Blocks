//
//  UIAlertView+Blocks.h
//  cstApp
//
//  Created by LS on 7/6/15.
//  Copyright (c) 2015 Chansha Aijian Communication Transmit Civilization CO.,LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DSAlertAction.h"

@interface UIAlertView (Blocks)

-(id)initWithTitle:(NSString *)title message:(NSString *)message cancelAlertAction:(DSAlertAction *)cancelAlertAction otherAlertActions:(DSAlertAction *)otherAlertActions, ... NS_REQUIRES_NIL_TERMINATION;

- (NSInteger)addAction:(DSAlertAction *)action;

@end
