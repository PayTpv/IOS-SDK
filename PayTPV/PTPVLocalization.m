//
//  PTPVLocalization.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVLocalization.h"
#import "PTPVBundleLocator.h"

@implementation PTPVLocalization

+ (NSString *)localizedStringForKey:(NSString *)key {
    static BOOL useMainBundle = NO;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (![[PTPVBundleLocator paytpvResourcesBundle].preferredLocalizations.firstObject isEqualToString:[NSBundle mainBundle].preferredLocalizations.firstObject]) {
            useMainBundle = YES;
        }
    });

    NSBundle *bundle = useMainBundle ? [NSBundle mainBundle] : [PTPVBundleLocator paytpvResourcesBundle];

    NSString *translation = [bundle localizedStringForKey:key value:nil table:nil];

    return translation;
}

@end
