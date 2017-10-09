//
//  CardsTableViewController.h
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/21/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Models.h"

@class CardsTableViewController;

@protocol CardsTableControllerDelegate <NSObject>

- (void)cardsTableController:(CardsTableViewController *)controller
               didSelectCard:(Card *)card;

@end

@interface CardsTableViewController : UITableViewController

@property (nonatomic, weak) id <CardsTableControllerDelegate> delegate;

@end


