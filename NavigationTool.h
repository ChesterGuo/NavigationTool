//
//  NavigationTool.h
//  jmg
//
//  Created by ChesterGuo on 2017/4/1.
//  Copyright © 2017年 xinyuantec. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NavigationTool : NSObject
@property (assign, nonatomic) double latitude;
@property (assign, nonatomic) double longitude;
+ (instancetype)defaultNavigationTool;
- (void)startNavigationOnViewController:(UIViewController *)con WithLatitude:(double)latitude Longitude:(double)longitude;
@end
