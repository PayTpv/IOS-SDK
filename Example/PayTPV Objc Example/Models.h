//
//  Models.h
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PAYTPV/PAYTPV.h"

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject<NSCoding>

#pragma mark - Properties

@property (nonatomic, copy, nullable) NSString *idUser;
@property (nonatomic, copy, nullable) NSString *tokenUser;
@property (nonatomic, copy, nullable) NSString *name;

#pragma mark - Inits

- (instancetype)initWithIdUser:(NSString *)idUser
                     tokenUser:(NSString *)tokenUser
                          name:(NSString *)name;

@end


@interface Purchase : NSObject<NSCoding>

#pragma mark - Properties

@property (nonatomic, copy, nullable) NSString *order;
@property (nonatomic, copy, nullable) NSString *authCode;
@property (nonatomic, copy, nullable) NSString *currency;
@property (nonatomic, copy, nullable) Card *card;

#pragma mark - Inits

- (instancetype)initWithOrder:(NSString *)order
                     authCode:(NSString *)authCode
                     currency:(PTPVCurrency *)currency
                         card:(Card *)card;

@end


@interface Product : NSObject

#pragma mark - Properties

@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, copy, nullable) NSNumber *price;
@property (nonatomic, copy, nullable) PTPVCurrency *currency;

#pragma mark - Inits

- (instancetype)initWithName:(NSString *)name
                       price:(NSNumber *)price
                    currency:(PTPVCurrency *)currency;

@end

NS_ASSUME_NONNULL_END
