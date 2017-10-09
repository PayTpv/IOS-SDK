//
//  PurchasesViewController.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/22/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PAYTPV/PAYTPV.h"

#import "PurchasesViewController.h"

#import "AlertBuilder.h"
#import "ModelStore.h"
#import "Models.h"

@interface PurchasesViewController ()

#pragma mark - Properties

@property (nonatomic, copy) NSArray *purchases;

@end

@implementation PurchasesViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Purchases";
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self loadRemoteData];
}

#pragma mark - Helpers

- (void)loadRemoteData {
    [ModelStore purchases:^(NSArray * _Nonnull purchases) {
        self.purchases = purchases;
        [self reloadData];
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)refundPurchase:(Purchase *)purchase {
    // add a loading indicator
    AlertBuilder *loader = [AlertBuilder new];
    [loader setTitle:@"Refunding purchase"];
    [loader addLoadingIndicator];
    [loader presentInController:self animated:true completion:nil];

    PTPVRefund *refund = [[PTPVRefund alloc] initWithAuthCode:purchase.authCode
                                                        order:purchase.order
                                                     currency:purchase.currency];
    PTPVUser *user = [[PTPVUser alloc] initWithIdUser:purchase.card.idUser
                                            tokenUser:purchase.card.tokenUser];

    // make the request to PAYTPV
    [[PTPVAPIClient sharedClient] executeRefund:refund forUser:user completion:^(PTPVRefund * _Nullable refund, NSError * _Nullable error) {
        [loader dismissAnimated:true completion:nil];

        if (error != nil) {
            AlertBuilder *alert = [AlertBuilder new];
            [alert setMessage:error.localizedDescription];
            [alert addActionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert presentInController:self animated:true completion:nil];
            return;
        }

        // remove the purchase from the backend
        [ModelStore removePurchase:purchase completion:^{
            AlertBuilder *alert = [AlertBuilder new];
            [alert setMessage:@"Purchase refunded!"];
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
    return self.purchases.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PurchaseCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"PurchaseCell"];
    }

    Purchase *purchase = [self.purchases objectAtIndex:indexPath.row];

    cell.textLabel.text = purchase.order;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Purchase *selectedPurchase = [self.purchases objectAtIndex:indexPath.row];

    // ask for user's confirmation
    AlertBuilder *alert = [AlertBuilder new];
    [alert setMessage:[NSString stringWithFormat:@"Do you want to refund the order %@?",
                       selectedPurchase.order]];
    [alert addActionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    [alert addActionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // make the refund
        [self refundPurchase:selectedPurchase];
    }];
    [alert presentInController:self animated:true completion:nil];
}

@end
