//
//  PTPVLocalization.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTPVLocalization : NSObject

+ (nonnull NSString *)localizedStringForKey:(nonnull NSString *)key;

@end

static inline NSString * _Nonnull PTPVLocalizedString(NSString* _Nonnull key) {
    return [PTPVLocalization localizedStringForKey:key];
}
