//
//  PTPVError.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PTPVErrorCode) {
    PTPVAPIError = -10,
};

@interface NSError (PAYTPV)

+ (nullable NSError *)ptpv_errorFromPAYTPVResponse:(nullable NSDictionary *)jsonDictionary;
+ (nonnull NSError *)ptpv_failedToParseError;
+ (nonnull NSError *)ptpv_errorWithId:(NSInteger)errorId;

@end

NS_ASSUME_NONNULL_END
