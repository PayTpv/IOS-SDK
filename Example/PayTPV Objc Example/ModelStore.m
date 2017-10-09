//
//  ModelStore.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "ModelStore.h"

@interface ModelStore()

@end

@implementation ModelStore

static NSString *kCardStore = @"kCardStore";
static NSString *kPurchaseStore = @"kPurchaseStore";

#pragma mark - Cards

+ (nonnull NSArray *)cards {
    NSData *cardsData = [[NSUserDefaults standardUserDefaults] dataForKey:kCardStore];
    if (cardsData == nil) {
        return [NSArray new];
    }
    NSArray *cards = [NSKeyedUnarchiver unarchiveObjectWithData:cardsData];
    if (cards == nil) {
        return [NSArray new];
    }
    return cards;
}

+ (void)saveCards:(NSArray *)cards {
    NSData *cardsData = [NSKeyedArchiver archivedDataWithRootObject:cards];
    [[NSUserDefaults standardUserDefaults] setObject:cardsData forKey:kCardStore];
}

+ (void)cards:(void (^ __nullable)(NSArray * _Nonnull cards))completion {
    if (completion) {
        completion([self cards]);
    }
}

+ (void)addCard:(Card *)card
     completion:(void (^ __nullable)(void))completion {
    NSMutableArray *cards = [NSMutableArray arrayWithArray:[self cards]];
    [cards addObject:card];
    [self saveCards:cards];
    if (completion) {
        completion();
    }
}

+ (void)removeCard:(Card *)card
        completion:(void (^ __nullable)(void))completion {
    NSMutableArray *cards = [NSMutableArray arrayWithArray:[self cards]];
    [cards removeObject:card];
    [self saveCards:cards];
    if (completion) {
        completion();
    }
}

#pragma mark - Purchases

+ (nonnull NSArray *)purchases {
    NSData *purchasesData = [[NSUserDefaults standardUserDefaults] dataForKey:kPurchaseStore];
    if (purchasesData == nil) {
        return [NSArray new];
    }
    NSArray *purchases = [NSKeyedUnarchiver unarchiveObjectWithData:purchasesData];
    if (purchases == nil) {
        return [NSArray new];
    }
    return purchases;
}

+ (void)savePurchases:(NSArray *)purchases {
    NSData *purchasesData = [NSKeyedArchiver archivedDataWithRootObject:purchases];
    [[NSUserDefaults standardUserDefaults] setObject:purchasesData forKey:kPurchaseStore];
}

+ (void)purchases:(void (^ __nullable)(NSArray * _Nonnull purchases))completion {
    if (completion) {
        completion([self purchases]);
    }
}

+ (void)addPurchase:(Purchase *)purchase
         completion:(void (^ __nullable)(void))completion {
    NSMutableArray *purchases = [NSMutableArray arrayWithArray:[self purchases]];
    [purchases addObject:purchase];
    [self savePurchases:purchases];
    if (completion) {
        completion();
    }
}

+ (void)removePurchase:(Purchase *)purchase
            completion:(void (^ __nullable)(void))completion {
    NSMutableArray *purchases = [NSMutableArray arrayWithArray:[self purchases]];
    [purchases removeObject:purchase];
    [self savePurchases:purchases];
    if (completion) {
        completion();
    }
}

@end
