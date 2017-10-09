//
//  ModelStore.h
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Models.h"

/// In a real production app, this should be the api connected to your backend which you can use to send the tokenized user data from PAYTPV. For the purpose of the demo, we just store it in UserDefaults
@interface ModelStore : NSObject

#pragma mark - Cards

+ (void)cards:(void (^ __nullable)(NSArray * _Nonnull cards))completion;

+ (void)addCard:(nonnull Card *)card
     completion:(void (^ __nullable)(void))completion;

+ (void)removeCard:(nonnull Card *)card
        completion:(void (^ __nullable)(void))completion;

#pragma mark - Purchases

+ (void)purchases:(void (^ __nullable)(NSArray * _Nonnull purchases))completion;

+ (void)addPurchase:(nonnull Purchase *)purchase
         completion:(void (^ __nullable)(void))completion;

+ (void)removePurchase:(nonnull Purchase *)purchase
            completion:(void (^ __nullable)(void))completion;

@end
