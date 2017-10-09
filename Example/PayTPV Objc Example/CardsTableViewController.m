//
//  CardsTableViewController.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/21/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PAYTPV/PAYTPV.h"

#import "CardsTableViewController.h"
#import "AddCardController.h"

#import "ModelStore.h"
#import "Models.h"
#import "AlertBuilder.h"

@interface CardsTableViewController () <AddCardControllerDelegate>

#pragma mark - Properties

@property (nonatomic, copy) NSArray *cards;

@end

@implementation CardsTableViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self loadRemoteData];
}

#pragma mark - Setup

- (void)setup {
    self.title = @"Cards";

    self.navigationItem.rightBarButtonItems = @[[self addButtonItem],
                                                [self editButtonItem]];
}

#pragma mark - Helpers

- (UIBarButtonItem *)addButtonItem {
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAddButtonPressed)];
}

- (void)onAddButtonPressed {
    AddCardController *controller = [AddCardController new];
    controller.delegate = self;
    [self presentViewController:controller animated:true completion:nil];
}

- (void)loadRemoteData {
    [ModelStore cards:^(NSArray * _Nonnull cards) {
        self.cards = cards;
        [self reloadData];
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CardCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CardCell"];
    }

    Card *card = [self.cards objectAtIndex:indexPath.row];

    cell.textLabel.text = card.name;

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // add a loading indicator
        AlertBuilder *loader = [AlertBuilder new];
        [loader setTitle:@"Removing card"];
        [loader addLoadingIndicator];
        [loader presentInController:self animated:true completion:nil];

        Card *selectedCard = [self.cards objectAtIndex:indexPath.row];

        // call the PAYTPV api to remove the user from the system
        PTPVUser *user = [[PTPVUser alloc] initWithIdUser:selectedCard.idUser tokenUser:selectedCard.tokenUser];
        [[PTPVAPIClient sharedClient] removeUser:user completion:^(NSError * _Nullable error) {
            [loader dismissAnimated:true completion:nil];

            if (error != nil) {
                AlertBuilder *alert = [AlertBuilder new];
                [alert setTitle:error.localizedDescription];
                [alert addActionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert presentInController:self animated:true completion:nil];
                return;
            }

            // remove the user from the backend
            [ModelStore removeCard:selectedCard completion:^{
                [self loadRemoteData];
            }];
        }];

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate) {
        [tableView deselectRowAtIndexPath:indexPath animated:true];

        Card *selectedCard = [self.cards objectAtIndex:indexPath.row];

        [self.delegate cardsTableController:self didSelectCard:selectedCard];
    }
}

#pragma mark - AddCardControllerDelegate

- (void)addCardController:(AddCardController *)controller didFinishAddingCard:(Card *)card {
    [self reloadData];
}

@end
