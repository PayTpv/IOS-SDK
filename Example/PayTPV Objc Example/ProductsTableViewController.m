//
//  ProductsTableViewController.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/18/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PAYTPV/PAYTPV.h"

#import "ProductsTableViewController.h"
#import "CardsTableViewController.h"
#import "PurchasesViewController.h"

#import "Models.h"
#import "AlertBuilder.h"
#import "ModelStore.h"

@interface ProductsTableViewController () <CardsTableControllerDelegate>

#pragma mark - Properties

@property (nonatomic) NSArray *products;
@property (nonatomic) Product *selectedProduct;

@end

@implementation ProductsTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)setup {
    self.title = @"Products";

    self.products = @[[[Product alloc] initWithName:@"Product A" price:@0.29 currency:PTPVCurrencyEUR],
                      [[Product alloc] initWithName:@"Product B" price:@1.99 currency:PTPVCurrencyEUR],
                      [[Product alloc] initWithName:@"Product C" price:@2.99 currency:PTPVCurrencyEUR],
                      [[Product alloc] initWithName:@"Product D" price:@3.99 currency:PTPVCurrencyEUR]
                      ];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Purchases"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self action:@selector(onPurchasesButtonPressed)];
}

#pragma mark - Helpers

- (void)onPurchasesButtonPressed {
    [self.navigationController pushViewController:[PurchasesViewController new] animated:true];
}
- (void)purchaseProduct:(Product *)product
               withCard:(Card *)card {
    // add a loading indicator
    AlertBuilder *loader = [AlertBuilder new];
    [loader setTitle:@"Executing purchase"];
    [loader addLoadingIndicator];
    [loader presentInController:self animated:true completion:nil];

    // the amount must be in integer format, so we have to convert it
    // e.g. 1.00 EURO = 100, 4.50 EUROS = 450...
    NSNumber *amount = [NSNumber numberWithLong:lround([[product price] doubleValue] * 100.0)];

    // generate unique order reference
    NSString *order = [NSString stringWithFormat:@"%.0f_%d", [[NSDate date] timeIntervalSince1970], arc4random_uniform(1000)];

    // create the purchase request
    PTPVPurchaseRequest *purchaseRequest;
    purchaseRequest = [[PTPVPurchaseRequest alloc] initWithAmount:amount
                                                            order:order
                                                         currency:product.currency
                                               productDescription:nil
                                                            owner:nil
                                                          scoring:nil];
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:card.idUser tokenUser:card.tokenUser];

    // make the request to PAYTPV
    [[PTPVAPIClient sharedClient] executePurchase:purchaseRequest forUser:user completion:^(PTPVPurchase * _Nullable purchase, NSError * _Nullable error) {
        [loader dismissAnimated:true completion:nil];

        if (error != nil) {
            AlertBuilder *alert = [AlertBuilder new];
            [alert setMessage:error.localizedDescription];
            [alert addActionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert presentInController:self animated:true completion:nil];
            return;
        }

        // send the purchase details to the backend
        Purchase *localPurchase = [[Purchase alloc] initWithOrder:purchase.order
                                                         authCode:purchase.authCode
                                                         currency:purchase.currency
                                                             card:card];
        [ModelStore addPurchase:localPurchase completion:^{
            AlertBuilder *alert = [AlertBuilder new];
            [alert setMessage:@"Product purchased!"];
            [alert addActionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popToRootViewControllerAnimated:true];
            }];
            [alert presentInController:self animated:true completion:nil];
        }];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"ProductCell"];
    }

    Product *product = [self.products objectAtIndex:indexPath.row];

    cell.textLabel.text = product.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@", product.currency, product.price];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedProduct = [self.products objectAtIndex:indexPath.row];

    CardsTableViewController *controller = [CardsTableViewController new];
    controller.delegate = self;

    [self.navigationController pushViewController:controller animated:true];
}

#pragma mark - CardsTableControllerDelegate

- (void)cardsTableController:(CardsTableViewController *)controller didSelectCard:(Card *)card {
    if (self.selectedProduct == nil) {
        return;
    }

    // ask for user's confirmation
    AlertBuilder *alert = [AlertBuilder new];
    [alert setMessage:[NSString stringWithFormat:@"Are you sure you want to purchase %@ for %@ %@",
                       self.selectedProduct.name,
                       self.selectedProduct.currency,
                       self.selectedProduct.price]];
    [alert addActionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    [alert addActionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // make the purchase
        [self purchaseProduct:self.selectedProduct withCard:card];
    }];
    [alert presentInController:self animated:true completion:nil];
}

@end
