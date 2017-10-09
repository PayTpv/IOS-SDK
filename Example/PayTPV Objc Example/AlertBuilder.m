//
//  AlertBuilder.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/21/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "AlertBuilder.h"

@implementation AlertBuilder

- (instancetype)init {
    self = [super init];
    if (self) {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
    return self;
}

- (instancetype)setTitle:(NSString *)title {
    self.alertController.title = title;
    return self;
}

- (instancetype)setMessage:(NSString *)message {
    self.alertController.message = message;
    return self;
}

- (instancetype)addActionWithTitle:(NSString *)title
                             style:(UIAlertActionStyle)style
                           handler:(void (^ __nullable)(UIAlertAction * action))handler {
    [self.alertController addAction:[UIAlertAction actionWithTitle:title
                                                             style:style
                                                           handler:handler]];
    return self;
}

- (instancetype)addLoadingIndicator {
    UIActivityIndicatorView *indicator = [UIActivityIndicatorView new];
    indicator.translatesAutoresizingMaskIntoConstraints = false;
    [self.alertController.view addSubview:indicator];

    NSDictionary *views = @{
                            @"pending": self.alertController.view,
                            @"indicator": indicator,
                            };
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[indicator]-(-50)-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:views];
    constraints = [constraints arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[indicator]|"
                                                                                                     options:0
                                                                                                     metrics:nil
                                                                                                       views:views]];
    [self.alertController.view addConstraints:constraints];

    [indicator setUserInteractionEnabled:false];
    [indicator startAnimating];

    return self;
}

- (instancetype)presentInController:(UIViewController *)sender
                           animated:(BOOL)animated
                         completion:(void (^ __nullable)(void))completion {
    [sender presentViewController:self.alertController animated:animated completion:completion];

    return self;
}

- (void)dismissAnimated:(BOOL)animated
             completion:(void (^ __nullable)(void))completion {
    [self.alertController dismissViewControllerAnimated:animated completion:completion];
}

@end
