//
//  DSAlertAction.h
//  cstApp
//
//  Created by LS on 7/6/15.
//  Copyright (c) 2015 Chansha Aijian Communication Transmit Civilization CO.,LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DSAlertActionBlock) ();

@interface DSAlertAction : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) DSAlertActionBlock alertActionBlock;

+ (id)actionWithTitle:(NSString *)title handler:(DSAlertActionBlock)alertActionBlock;

@end
