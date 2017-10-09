//
//  AddCardController.h
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/21/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Models.h"

@class AddCardController;

@protocol AddCardControllerDelegate <NSObject>

- (void)addCardController:(AddCardController *)controller
      didFinishAddingCard:(Card *)card;

@end

@interface AddCardController : UIViewController

@property (nonatomic, weak) id <AddCardControllerDelegate> delegate;

@end
