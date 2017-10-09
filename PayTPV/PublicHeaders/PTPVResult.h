//
//  PTPVResult.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

/**
 API Operation result

 - PTPVResultKO: Success result
 - PTPVResultOK: Failure result
 */
typedef NS_ENUM(NSInteger, PTPVResult) {
    /**
     Failure result
     */
    PTPVResultKO = 0,

    /**
     Success result
     */
    PTPVResultOK = 1,
};
