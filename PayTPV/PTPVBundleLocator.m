//
//  PTPVBundleLocator.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVBundleLocator.h"

@interface PTPVBundleLocatorInternal : NSObject
@end
@implementation PTPVBundleLocatorInternal
@end

@implementation PTPVBundleLocator

+ (NSBundle *)paytpvResourcesBundle {
    static NSBundle *ourBundle;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ourBundle = [NSBundle bundleWithPath:@"PAYTPV.bundle"];
        if (ourBundle == nil) {
            NSString *path = [[NSBundle bundleForClass:[PTPVBundleLocatorInternal class]] pathForResource:@"PAYTPV" ofType:@"bundle"];
            ourBundle = [NSBundle bundleWithPath:path];
        }

        if (ourBundle == nil) {
            ourBundle = [NSBundle bundleForClass:[PTPVBundleLocatorInternal class]];
        }

        if (ourBundle == nil) {
            ourBundle = [NSBundle mainBundle];
        }
    });

    return ourBundle;
}

@end
