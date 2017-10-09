//
//  AddCardController.m
//  PAYTPV Objc Example
//
//  Created by Mihail Cristian Dumitru on 8/21/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "AddCardController.h"
#import "AlertBuilder.h"
#import "Models.h"
#import "ModelStore.h"

@interface AddCardController () <UITextFieldDelegate>

#pragma mark - IBOutlets

@property (weak, nonatomic) IBOutlet UITextField *panTextField;
@property (weak, nonatomic) IBOutlet UITextField *monthTextField;
@property (weak, nonatomic) IBOutlet UITextField *yearTextField;
@property (weak, nonatomic) IBOutlet UITextField *cvvTextField;

@end

@implementation AddCardController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

#pragma mark - Setup

- (void)setup {
    self.title = @"Add a card";

    [self setupTextFields];
}

- (void)setupTextFields {
    self.panTextField.delegate = self;
    self.monthTextField.delegate = self;
    self.yearTextField.delegate = self;
    self.cvvTextField.delegate = self;
}

#pragma mark - Helpers

- (NSString *)expiryDate {
    return [NSString stringWithFormat:@"%@%@", self.monthTextField.text, self.yearTextField.text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:true];
}

- (BOOL)string:(NSString *)string
  matchesRegex:(NSString *)regexString {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    return [regex numberOfMatchesInString:string options:0 range:NSMakeRange(0, string.length)];
}

- (BOOL)validPan:(NSString *)pan {
    return [self string:pan matchesRegex:@"^[0-9]{0,19}$"];
}

- (BOOL)validMonth:(NSString *)month {
    return [self string:month matchesRegex:@"(^0[1-9]?$)|(^1[012]?$)"];
}

- (BOOL)validYear:(NSString *)year {
    return [self string:year matchesRegex:@"(1[6-9]?$)|(^[2-9][0-9]?$)"];
}

- (BOOL)validCvv:(NSString *)cvv {
    return [self string:cvv matchesRegex:@"^[0-9]{0,4}$"];
}

#pragma mark - IBActions

- (IBAction)onCancelButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)onAddCardButtonPressed:(UIButton *)sender {
    // add a loading indicator
    AlertBuilder *loader = [AlertBuilder new];
    [loader setTitle:@"Adding card"];
    [loader addLoadingIndicator];
    [loader presentInController:self animated:true completion:nil];

    // make the request to PAYTPV
    PTPVCard *card = [[PTPVCard alloc] initWithPan:self.panTextField.text
                                    expiryDate:[self expiryDate]
                                           cvv:self.cvvTextField.text];
    [[PTPVAPIClient sharedClient] addUser:card completion:^(PTPVUser * _Nullable user, NSError * _Nullable error) {
        [loader dismissAnimated:true completion:^{
            if (user == nil) {
                if (error != nil) {
                    AlertBuilder *alert = [AlertBuilder new];
                    [alert setMessage:error.localizedDescription];
                    [alert addActionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                      handler:nil];
                    [alert presentInController:self animated:true completion:nil];
                    return;
                }
                AlertBuilder *alert = [AlertBuilder new];
                [alert setMessage:@"There was an unexpected error. Please try again later."];
                [alert addActionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                  handler:nil];
                [alert presentInController:self animated:true completion:nil];
                return;
            }

            // send the user token to the backend
            Card *card = [[Card alloc] initWithIdUser:user.idUser tokenUser:user.tokenUser name:self.panTextField.text];
            [ModelStore addCard:card completion:^{
                [self dismissViewControllerAnimated:true completion:^{
                    if (self.delegate) {
                        [self.delegate addCardController:self didFinishAddingCard:card];
                    }
                }];
            }];
        }];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if(newLength == 0) return YES;

    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    if (textField == self.panTextField) {
        return [self validPan:newString];
    } else if (textField == self.monthTextField) {
        return [self validMonth:newString];
    } else if (textField == self.yearTextField) {
        return [self validYear:newString];
    } else if (textField == self.cvvTextField) {
        return [self validCvv:newString];
    }

    return true;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.panTextField) {
        [self.monthTextField becomeFirstResponder];
    } else if (textField == self.monthTextField) {
        [self.yearTextField becomeFirstResponder];
    } else if (textField == self.yearTextField) {
        [self.cvvTextField becomeFirstResponder];
    }

    return true;
}

@end
