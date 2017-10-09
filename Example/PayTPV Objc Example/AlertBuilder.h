//
//  AlertBuilder.h
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/21/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertBuilder : NSObject

@property (nonatomic, copy) UIAlertController *alertController;

- (instancetype)setTitle:(nullable NSString *)title;
- (instancetype)setMessage:(nullable NSString *)message;
- (instancetype)addActionWithTitle:(nullable NSString *)title
                             style:(UIAlertActionStyle)style
                           handler:(void (^ __nullable)(UIAlertAction * action))handler;
- (instancetype)addLoadingIndicator;
- (instancetype)presentInController:(UIViewController *)sender
                           animated:(BOOL)animated
                         completion:(void (^ __nullable)(void))completion;
- (void)dismissAnimated:(BOOL)animated
             completion:(void (^ __nullable)(void))completion;

@end

NS_ASSUME_NONNULL_END
