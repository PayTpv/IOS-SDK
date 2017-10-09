//
//  PTPVTestUtils.h
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/4/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#define PTPVAssertStringNotEmpty(expression, ...) \
XCTAssertNotNil(expression); \
XCTAssertFalse([expression length] == 0)

#define PTPVAssertNumberNotEmpty(expression, ...) \
XCTAssertNotNil(expression); \
XCTAssertFalse([expression isEqualToNumber:@0])
