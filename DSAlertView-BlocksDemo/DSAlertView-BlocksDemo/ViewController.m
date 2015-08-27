//
//  ViewController.m
//  DSAlertView-BlocksDemo
//
//  Created by LS on 8/27/15.
//  Copyright (c) 2015 LS. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertView+Blocks.h"
#import "UIActionSheet+Blocks.h"

@interface ViewController ()

- (IBAction)handleAlert:(id)sender;
- (IBAction)handleActionSheet:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleAlert:(id)sender
{
    DSAlertAction *cancelAciton = [DSAlertAction actionWithTitle:@"取消" handler:^{
        NSLog(@"你点击了取消");
    }];
    
    DSAlertAction *confirmAction = [DSAlertAction actionWithTitle:@"确定" handler:^{
        
        NSLog(@"你点击了确定");
    }];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"UIAlertView-Blocks" cancelAlertAction:cancelAciton otherAlertActions:confirmAction, nil];
    
    [alertView show];
}

- (IBAction)handleActionSheet:(id)sender
{
    DSAlertAction *cancelAciton = [DSAlertAction actionWithTitle:@"取消" handler:^{
        NSLog(@"你点击了取消");
    }];
    
    DSAlertAction *confirmAction = [DSAlertAction actionWithTitle:@"确定" handler:^{
        
        NSLog(@"你点击了确定");
    }];
    
    DSAlertAction *destructiveAction = [DSAlertAction actionWithTitle:@"特殊按钮" handler:^{
       
        NSLog(@"你点击了特殊按钮");
    }];

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"UIActionSheet-Blocks" cancelAlertAction:cancelAciton destructiveAlertAction:destructiveAction otherAlertActions:confirmAction, nil];
    [actionSheet showInView:self.view];
}

@end
