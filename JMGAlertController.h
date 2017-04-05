//
//  JMGAlertController.h
//  jmg_merchant
//
//  Created by ChesterGuo on 2017/2/22.
//  Copyright © 2017年 xinyuantec. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMGAlertController : UIAlertController
+ (instancetype)alertWithTitle:(NSString *)title
                   message:(NSString *)message
                 leftStyle:(UIAlertActionStyle)lStyle
                 leftTitle:(NSString *)lTitle
                 rightStyle:(UIAlertActionStyle)rStyle
                 rightTitle:(NSString *)rTitle
               leftHandler:(void (^)(UIAlertAction *action))lHandler
              rightHandler:(void (^)(UIAlertAction *action))rHandler;
+ (instancetype)cancleAlertWithTitle:(NSString *)title
                             handler:(void (^)(UIAlertAction *action))handler;
+ (instancetype)deleteAlertWithTitle:(NSString *)title
                             handler:(void (^)(UIAlertAction *action))handler;
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message;
- (void)showInViewController:(UIViewController *)con;
+ (instancetype)optionAlertWithOptions:(NSArray *)options
                                 title:(NSString *)title
                               message:(NSString *)message
                      selectedCallback:(void (^)(NSUInteger selectedIndex))callback;
@end
