//
//  PTPVDCCConfirmation.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/7/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PTPVCurrency.h"
#import "PTPVNSDictionaryEncodable.h"

#import "PTPVDCCDetails.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Represents the dcc purchase confirmation
 */
@interface PTPVDCCConfirmation : NSObject<PTPVNSDictionaryEncodable>

/**
 Creates a PTPVDCCConfirmation

 @param order Reference of the original operation.
 @param currency Currency of the chosen transaction. It can be the PAYTPV product or the native one selected by the end user. The amount will be sent in execute_purchase_dcc if it is the same as the product and the converted one in case it is different.
 @param session The session sent in the execute_purchase_dcc process
 @return A PTPVDCCConfirmation instance populated with the provided values
 */
- (instancetype)initWithOrder:(NSString *)order
                     currency:(NSString *)currency
                      session:(NSString *)session;

/**
 Creates a PTPVDCCConfirmation

 @param details The PTPVDCCDetails received when making an execute_purchase_dcc request. The order and session will be automatically populated with the ones in the dcc details
 @param currency Currency of the chosen transaction. It can be the PAYTPV product or the native one selected by the end user. The amount will be sent in execute_purchase_dcc if it is the same as the product and the converted one in case it is different.
 @return A PTPVDCCConfirmation instance populated with the provided values
 */
- (instancetype)initWithDCCDetails:(PTPVDCCDetails *)details
                          currency:(NSString *)currency;

/**
 Reference of the original operation.
 */
@property (nonatomic, copy, nullable) NSString *order;

/**
 Currency of the chosen transaction. It can be the PAYTPV product or the native one selected by the end user. The amount will be sent in execute_purchase_dcc if it is the same as the product and the converted one in case it is different.
 */
@property (nonatomic, copy, nullable) NSString *currency;

/**
 The session sent in the execute_purchase_dcc process.
 */
@property (nonatomic, copy, nullable) NSString *session;

@end

NS_ASSUME_NONNULL_END
