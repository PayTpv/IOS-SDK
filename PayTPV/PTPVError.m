//
//  PTPVError.m
//  PAYTPV
//
//  Created by Mihail Cristian Dumitru on 8/3/17.
//  Copyright © 2017 PAYTPV. All rights reserved.
//

#import "PTPVError.h"
#import "PTPVLocalization.h"

NSString *const PAYTPVDomain = @"com.paytpv.sdk";
NSString *const PTPVErrorCodeKey = @"com.paytpv.sdk:ErrorCodeKey";

@implementation NSError (PAYTPV)

+ (nullable NSError *)ptpv_errorFromPAYTPVResponse:(nullable NSDictionary *)jsonDictionary {
    if (jsonDictionary == nil) {
        return nil;
    }

    NSInteger errorId = [jsonDictionary[@"DS_ERROR_ID"] integerValue];
    if (errorId > 0) {
        NSError *error = [NSError ptpv_errorWithId:errorId];

        return error;
    }

    return nil;
}

+ (nonnull NSError *)ptpv_failedToParseError {
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: PTPVLocalizedString(@"There was an unexpected error. Please try again later"),
                               PTPVErrorCodeKey: [NSNumber numberWithInteger:PTPVAPIError],
                               };
    return [[self alloc] initWithDomain:PAYTPVDomain code:PTPVAPIError userInfo:userInfo];
}

+ (nonnull NSError *)ptpv_errorWithId:(NSInteger)errorId {
    NSString *message = nil;

    switch (errorId) {
        case 1:
            message = PTPVLocalizedString(@"Error");
            break;

        case 100:
            message = PTPVLocalizedString(@"Expired credit card");
            break;

        case 101:
            message = PTPVLocalizedString(@"Credit card blacklisted");
            break;

        case 102:
            message = PTPVLocalizedString(@"Operation not allowed for the credit card type");
            break;

        case 103:
            message = PTPVLocalizedString(@"Please, call the credit card issuer");
            break;

        case 104:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 105:
            message = PTPVLocalizedString(@"Insufficient funds");
            break;

        case 106:
            message = PTPVLocalizedString(@"Credit card not registered or not logged by the issuer");
            break;

        case 107:
            message = PTPVLocalizedString(@"Data error. Validation Code");
            break;

        case 108:
            message = PTPVLocalizedString(@"PAN Check Error");
            break;

        case 109:
            message = PTPVLocalizedString(@"Expiry date error");
            break;

        case 110:
            message = PTPVLocalizedString(@"Data error");
            break;

        case 111:
            message = PTPVLocalizedString(@"CVC2 block incorrect");
            break;

        case 112:
            message = PTPVLocalizedString(@"Please, call the credit card issuer");
            break;

        case 113:
            message = PTPVLocalizedString(@"Credit card not valid");
            break;

        case 114:
            message = PTPVLocalizedString(@"The credit card has credit restrictions");
            break;

        case 115:
            message = PTPVLocalizedString(@"Card issuer could not validate card owner");
            break;

        case 116:
            message = PTPVLocalizedString(@"Payment not allowed in off-line authorization");
            break;

        case 118:
            message = PTPVLocalizedString(@"Expired credit card. Please capture card");
            break;

        case 119:
            message = PTPVLocalizedString(@"Credit card blacklisted. Please capture card");
            break;

        case 120:
            message = PTPVLocalizedString(@"Credit card lost or stolen. Please capture card");
            break;

        case 121:
            message = PTPVLocalizedString(@"Error in CVC2. Please capture card");
            break;

        case 122:
            message = PTPVLocalizedString(@"Error en Pre-Transaction process. Try again later.");
            break;

        case 123:
            message = PTPVLocalizedString(@"Operation denied. Please capture card");
            break;

        case 124:
            message = PTPVLocalizedString(@"Closing with agreement");
            break;

        case 125:
            message = PTPVLocalizedString(@"Closing without agreement");
            break;

        case 126:
            message = PTPVLocalizedString(@"Cannot close right now");
            break;

        case 127:
            message = PTPVLocalizedString(@"Invalid parameter");
            break;

        case 128:
            message = PTPVLocalizedString(@"Transactions were not accomplished");
            break;

        case 129:
            message = PTPVLocalizedString(@"Duplicated internal reference");
            break;

        case 130:
            message = PTPVLocalizedString(@"Original operation not found. Could not refund");
            break;

        case 131:
            message = PTPVLocalizedString(@"Expired preauthorization");
            break;

        case 132:
            message = PTPVLocalizedString(@"Operation not valid with selected currency");
            break;

        case 133:
            message = PTPVLocalizedString(@"Error in message format");
            break;

        case 134:
            message = PTPVLocalizedString(@"Message not recognized by the system");
            break;

        case 135:
            message = PTPVLocalizedString(@"CVC2 block incorrect");
            break;

        case 137:
            message = PTPVLocalizedString(@"Credit card not valid");
            break;

        case 138:
            message = PTPVLocalizedString(@"Gateway message error");
            break;

        case 139:
            message = PTPVLocalizedString(@"Gateway format error");
            break;

        case 140:
            message = PTPVLocalizedString(@"Credit card does not exist");
            break;

        case 141:
            message = PTPVLocalizedString(@"Amount zero or not valid");
            break;

        case 142:
            message = PTPVLocalizedString(@"Operation canceled");
            break;

        case 143:
            message = PTPVLocalizedString(@"Authentification error");
            break;

        case 144:
            message = PTPVLocalizedString(@"Denegation by security level");
            break;

        case 145:
            message = PTPVLocalizedString(@"Error in PUC message. Please contact PAYTPV");
            break;

        case 146:
            message = PTPVLocalizedString(@"System error");
            break;

        case 147:
            message = PTPVLocalizedString(@"Duplicated transaction");
            break;

        case 148:
            message = PTPVLocalizedString(@"MAC error");
            break;

        case 149:
            message = PTPVLocalizedString(@"Settlement rejected");
            break;

        case 150:
            message = PTPVLocalizedString(@"System date/time not synchronized");
            break;

        case 151:
            message = PTPVLocalizedString(@"Invalid card expiration date");
            break;

        case 152:
            message = PTPVLocalizedString(@"Could not find any preauthorization with given data");
            break;

        case 153:
            message = PTPVLocalizedString(@"Cannot find requested data");
            break;

        case 154:
            message = PTPVLocalizedString(@"Cannot operate with given credit card");
            break;

        case 155:
            message = PTPVLocalizedString(@"This method requires activation of the VHASH protocol");
            break;

        case 500:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 501:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 502:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 504:
            message = PTPVLocalizedString(@"Transaction already cancelled");
            break;

        case 505:
            message = PTPVLocalizedString(@"Transaction originally denied");
            break;

        case 506:
            message = PTPVLocalizedString(@"Confirmation data not valid");
            break;

        case 507:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 508:
            message = PTPVLocalizedString(@"Transaction still in process");
            break;

        case 509:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 510:
            message = PTPVLocalizedString(@"Refund is not possible");
            break;

        case 511:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 512:
            message = PTPVLocalizedString(@"Card issuer not available right now. Please try again later");
            break;

        case 513:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 514:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 515:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 516:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 517:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 518:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 519:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 520:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 521:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 522:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 523:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 524:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 525:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 526:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 527:
            message = PTPVLocalizedString(@"TransactionType desconocido");
            break;

        case 528:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 529:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 530:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 531:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 532:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 533:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 534:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 535:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 536:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 537:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 538:
            message = PTPVLocalizedString(@"Not cancelable operation");
            break;

        case 539:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 540:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 541:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 542:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 543:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 544:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 545:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 546:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 547:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 548:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 549:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 550:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 551:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 552:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 553:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 554:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 555:
            message = PTPVLocalizedString(@"Could not find the previous operation");
            break;

        case 556:
            message = PTPVLocalizedString(@"Data inconsistency in cancellation validation");
            break;

        case 557:
            message = PTPVLocalizedString(@"Delayed payment code does not exists");
            break;

        case 558:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 559:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 560:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 561:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 562:
            message = PTPVLocalizedString(@"Credit card does not allow preauthorizations");
            break;

        case 563:
            message = PTPVLocalizedString(@"Data inconsistency in confirmation");
            break;

        case 564:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 565:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 567:
            message = PTPVLocalizedString(@"Refund operation not correctly specified");
            break;

        case 568:
            message = PTPVLocalizedString(@"Online communication incorrect");
            break;

        case 569:
            message = PTPVLocalizedString(@"Denied operation");
            break;

        case 1000:
            message = PTPVLocalizedString(@"Account not found. Review your settings");
            break;

        case 1001:
            message = PTPVLocalizedString(@"User not found. Please contact your administrator");
            break;

        case 1002:
            message = PTPVLocalizedString(@"External provider signature error. Contact your service provider");
            break;

        case 1003:
            message = PTPVLocalizedString(@"Signature not valid. Please review your settings");
            break;

        case 1004:
            message = PTPVLocalizedString(@"Forbidden access");
            break;

        case 1005:
            message = PTPVLocalizedString(@"Invalid credit card format");
            break;

        case 1006:
            message = PTPVLocalizedString(@"Data error: Validation code");
            break;

        case 1007:
            message = PTPVLocalizedString(@"Data error: Expiration date");
            break;

        case 1008:
            message = PTPVLocalizedString(@"Preauthorization reference not found");
            break;

        case 1009:
            message = PTPVLocalizedString(@"Preauthorization data could not be found");
            break;

        case 1010:
            message = PTPVLocalizedString(@"Could not send cancellation. Please try again later");
            break;

        case 1011:
            message = PTPVLocalizedString(@"Could not connect to host");
            break;

        case 1012:
            message = PTPVLocalizedString(@"Could not resolve proxy address");
            break;

        case 1013:
            message = PTPVLocalizedString(@"Could not resolve host");
            break;

        case 1014:
            message = PTPVLocalizedString(@"Initialization failed");
            break;

        case 1015:
            message = PTPVLocalizedString(@"Could not find HTTP resource");
            break;

        case 1016:
            message = PTPVLocalizedString(@"The HTTP options range is not valid");
            break;

        case 1017:
            message = PTPVLocalizedString(@"The POST is not correctly built");
            break;

        case 1018:
            message = PTPVLocalizedString(@"The username is not correctly formatted");
            break;

        case 1019:
            message = PTPVLocalizedString(@"Operation timeout exceeded");
            break;

        case 1020:
            message = PTPVLocalizedString(@"Insufficient memory");
            break;

        case 1021:
            message = PTPVLocalizedString(@"Could not connect to SSL host");
            break;

        case 1022:
            message = PTPVLocalizedString(@"Protocol not supported");
            break;

        case 1023:
            message = PTPVLocalizedString(@"Given URL is not correctly formatted and cannot be used");
            break;

        case 1024:
            message = PTPVLocalizedString(@"URL user is not correctly formatted");
            break;

        case 1025:
            message = PTPVLocalizedString(@"Cannot register available resources to complete current operation");
            break;

        case 1026:
            message = PTPVLocalizedString(@"Duplicated external reference");
            break;

        case 1027:
            message = PTPVLocalizedString(@"Total refunds cannot exceed original payment");
            break;

        case 1028:
            message = PTPVLocalizedString(@"Account not active. Please contact PAYTPV");
            break;

        case 1029:
            message = PTPVLocalizedString(@"Account still not certified. Please contact PAYTPV");
            break;

        case 1030:
            message = PTPVLocalizedString(@"Product is marked for deletion and cannot be used");
            break;

        case 1031:
            message = PTPVLocalizedString(@"Insufficient rights");
            break;

        case 1032:
            message = PTPVLocalizedString(@"Product cannot be used under test environment");
            break;

        case 1033:
            message = PTPVLocalizedString(@"Product cannot be used under production environment");
            break;

        case 1034:
            message = PTPVLocalizedString(@"It was not possible to send the refund request");
            break;

        case 1035:
            message = PTPVLocalizedString(@"Error in field operation origin IP");
            break;

        case 1036:
            message = PTPVLocalizedString(@"Error in XML format");
            break;

        case 1037:
            message = PTPVLocalizedString(@"Root element is not correct");
            break;

        case 1038:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_AMOUNT incorrect");
            break;

        case 1039:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_ORDER incorrect");
            break;

        case 1040:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_MERCHANTCODE incorrect");
            break;

        case 1041:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_CURRENCY incorrect");
            break;

        case 1042:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_PAN incorrect");
            break;

        case 1043:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_CVV2 incorrect");
            break;

        case 1044:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_TRANSACTIONTYPE incorrect");
            break;

        case 1045:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_TERMINAL incorrect");
            break;

        case 1046:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_EXPIRYDATE incorrect");
            break;

        case 1047:
            message = PTPVLocalizedString(@"Field DS_MERCHANT_MERCHANTSIGNATURE incorrect");
            break;

        case 1048:
            message = PTPVLocalizedString(@"Field DS_ORIGINAL_IP incorrect");
            break;

        case 1049:
            message = PTPVLocalizedString(@"Client not found");
            break;

        case 1050:
            message = PTPVLocalizedString(@"Preauthorization amount cannot be greater than previous preauthorization amount");
            break;

        case 1099:
            message = PTPVLocalizedString(@"Unexpected error");
            break;

        case 1100:
            message = PTPVLocalizedString(@"Card diary limit exceeds");
            break;

        case 1103:
            message = PTPVLocalizedString(@"ACCOUNT field error");
            break;

        case 1104:
            message = PTPVLocalizedString(@"USERCODE field error");
            break;

        case 1105:
            message = PTPVLocalizedString(@"TERMINAL field error");
            break;

        case 1106:
            message = PTPVLocalizedString(@"OPERATION field error");
            break;

        case 1107:
            message = PTPVLocalizedString(@"REFERENCE field error");
            break;

        case 1108:
            message = PTPVLocalizedString(@"AMOUNT field error");
            break;

        case 1109:
            message = PTPVLocalizedString(@"CURRENCY field error");
            break;

        case 1110:
            message = PTPVLocalizedString(@"SIGNATURE field error");
            break;

        case 1120:
            message = PTPVLocalizedString(@"Operation unavailable");
            break;

        case 1121:
            message = PTPVLocalizedString(@"Client not found");
            break;

        case 1122:
            message = PTPVLocalizedString(@"User not found. Contact PAYTPV");
            break;

        case 1123:
            message = PTPVLocalizedString(@"Invalid signature. Please check your configuration");
            break;

        case 1124:
            message = PTPVLocalizedString(@"Operation not available with the specified user");
            break;

        case 1125:
            message = PTPVLocalizedString(@"Invalid operation in a currency other than Euro");
            break;

        case 1127:
            message = PTPVLocalizedString(@"Quantity zero or invalid");
            break;

        case 1128:
            message = PTPVLocalizedString(@"Current currency conversion invalid");
            break;

        case 1129:
            message = PTPVLocalizedString(@"Invalid amount");
            break;

        case 1130:
            message = PTPVLocalizedString(@"Product not found");
            break;

        case 1131:
            message = PTPVLocalizedString(@"Invalid operation with the current currency");
            break;

        case 1132:
            message = PTPVLocalizedString(@"Invalid operation with a different article of the Euro currency");
            break;

        case 1133:
            message = PTPVLocalizedString(@"Info button corrupt");
            break;

        case 1134:
            message = PTPVLocalizedString(@"The subscription may not exceed the expiration date of the card");
            break;

        case 1135:
            message = PTPVLocalizedString(@"DS_EXECUTE can not be true if DS_SUBSCRIPTION_STARTDATE is different from today.");
            break;

        case 1136:
            message = PTPVLocalizedString(@"PAYTPV_OPERATIONS_MERCHANTCODE field error");
            break;

        case 1137:
            message = PTPVLocalizedString(@"PAYTPV_OPERATIONS_TERMINAL must be Array");
            break;

        case 1138:
            message = PTPVLocalizedString(@"PAYTPV_OPERATIONS_OPERATIONS must be Array");
            break;

        case 1139:
            message = PTPVLocalizedString(@"PAYTPV_OPERATIONS_SIGNATURE field error");
            break;

        case 1140:
            message = PTPVLocalizedString(@"Can not find any of the PAYTPV_OPERATIONS_TERMINAL");
            break;

        case 1141:
            message = PTPVLocalizedString(@"Error in the date range requested");
            break;

        case 1142:
            message = PTPVLocalizedString(@"The application can not have a length greater than 2 years");
            break;

        case 1143:
            message = PTPVLocalizedString(@"The operation state is incorrect");
            break;

        case 1144:
            message = PTPVLocalizedString(@"Error in the amounts of the search");
            break;

        case 1145:
            message = PTPVLocalizedString(@"The type of operation requested does not exist");
            break;

        case 1146:
            message = PTPVLocalizedString(@"Sort Order unrecognized");
            break;

        case 1147:
            message = PTPVLocalizedString(@"PAYTPV_OPERATIONS_SORTORDER unrecognized");
            break;

        case 1148:
            message = PTPVLocalizedString(@"Subscription start date wrong");
            break;

        case 1149:
            message = PTPVLocalizedString(@"Subscription end date wrong");
            break;

        case 1150:
            message = PTPVLocalizedString(@"Frequency error in the subscription");
            break;

        case 1151:
            message = PTPVLocalizedString(@"Invalid usuarioXML ");
            break;

        case 1152:
            message = PTPVLocalizedString(@"Invalid codigoCliente");
            break;

        case 1153:
            message = PTPVLocalizedString(@"Invalid usuarios parameter");
            break;

        case 1154:
            message = PTPVLocalizedString(@"Invalid firma parameter");
            break;

        case 1155:
            message = PTPVLocalizedString(@"Invalid usuarios parameter format");
            break;

        case 1156:
            message = PTPVLocalizedString(@"Invalid type");
            break;

        case 1157:
            message = PTPVLocalizedString(@"Invalid name");
            break;

        case 1158:
            message = PTPVLocalizedString(@"Invalid surname");
            break;

        case 1159:
            message = PTPVLocalizedString(@"Invalid email");
            break;

        case 1160:
            message = PTPVLocalizedString(@"Invalid password");
            break;

        case 1161:
            message = PTPVLocalizedString(@"Invalid language");
            break;

        case 1162:
            message = PTPVLocalizedString(@"Invalid maxamount");
            break;

        case 1163:
            message = PTPVLocalizedString(@"Invalid multicurrency");
            break;

        case 1165:
            message = PTPVLocalizedString(@"Invalid permissions_specs. Format not allowed");
            break;

        case 1166:
            message = PTPVLocalizedString(@"Invalid permissions_products. Format not allowed");
            break;

        case 1167:
            message = PTPVLocalizedString(@"Invalid email. Format not allowed");
            break;

        case 1168:
            message = PTPVLocalizedString(@"Weak or invalid password");
            break;

        case 1169:
            message = PTPVLocalizedString(@"Invalid value for type parameter");
            break;

        case 1170:
            message = PTPVLocalizedString(@"Invalid value for language parameter");
            break;

        case 1171:
            message = PTPVLocalizedString(@"Invalid format for maxamount parameter");
            break;

        case 1172:
            message = PTPVLocalizedString(@"Invalid multicurrency. Format not allowed");
            break;

        case 1173:
            message = PTPVLocalizedString(@"Invalid permission_id – permissions_specs. Not allowed");
            break;

        case 1174:
            message = PTPVLocalizedString(@"Invalid user");
            break;

        case 1175:
            message = PTPVLocalizedString(@"Invalid credentials");
            break;

        case 1176:
            message = PTPVLocalizedString(@"Account not found");
            break;

        case 1177:
            message = PTPVLocalizedString(@"User not found");
            break;

        case 1178:
            message = PTPVLocalizedString(@"Invalid signature");
            break;

        case 1179:
            message = PTPVLocalizedString(@"Account without products");
            break;

        case 1180:
            message = PTPVLocalizedString(@"Invalid product_id - permissions_products. Not allowed");
            break;

        case 1181:
            message = PTPVLocalizedString(@"Invalid permission_id -permissions_products. Not allowed");
            break;

        case 1185:
            message = PTPVLocalizedString(@"Minimun limit not allowed");
            break;

        case 1186:
            message = PTPVLocalizedString(@"Maximun limit not allowed");
            break;

        case 1187:
            message = PTPVLocalizedString(@"Daily limit not allowed");
            break;

        case 1188:
            message = PTPVLocalizedString(@"Monthly limit not allowed");
            break;

        case 1189:
            message = PTPVLocalizedString(@"Max amount (same card / last 24 h.) not allowed");
            break;

        case 1190:
            message = PTPVLocalizedString(@"Max amount (same card / last 24 h. / same IP address) not allowed");
            break;

        case 1191:
            message = PTPVLocalizedString(@"Day / IP address limit (all cards) not allowed");
            break;

        case 1192:
            message = PTPVLocalizedString(@"Country (merchant IP address) not allowed");
            break;

        case 1193:
            message = PTPVLocalizedString(@"Card type (credit / debit) not allowed");
            break;

        case 1194:
            message = PTPVLocalizedString(@"Card brand not allowed");
            break;

        case 1195:
            message = PTPVLocalizedString(@"Card Category not allowed");
            break;

        case 1196:
            message = PTPVLocalizedString(@"Authorization from different country than card issuer, not allowed");
            break;

        case 1197:
            message = PTPVLocalizedString(@"Denied. Filter: Card country issuer not allowed");
            break;

        case 1198:
            message = PTPVLocalizedString(@"Scoring limit exceeded");
            break;

        case 1200:
            message = PTPVLocalizedString(@"Denied. Filter: same card, different country last 24 h.");
            break;

        case 1201:
            message = PTPVLocalizedString(@"Number of erroneous consecutive attempts with the same card exceeded");
            break;

        case 1202:
            message = PTPVLocalizedString(@"Number of failed attempts (last 30 minutes) from the same ip address exceeded");
            break;

        case 1203:
            message = PTPVLocalizedString(@"Wrong or not configured PayPal credentials");
            break;

        case 1204:
            message = PTPVLocalizedString(@"Wrong token received");
            break;

        case 1205:
            message = PTPVLocalizedString(@"Can not perform the operation");
            break;

        case 1206:
            message = PTPVLocalizedString(@"ProviderID not available");
            break;

        case 1207:
            message = PTPVLocalizedString(@"Operations parameter missing or not in a correct format");
            break;

        case 1208:
            message = PTPVLocalizedString(@"PaytpvMerchant parameter missing");
            break;

        case 1209:
            message = PTPVLocalizedString(@"MerchatID parameter missing");
            break;

        case 1210:
            message = PTPVLocalizedString(@"TerminalID parameter missing");
            break;

        case 1211:
            message = PTPVLocalizedString(@"TpvID parameter missing");
            break;

        case 1212:
            message = PTPVLocalizedString(@"OperationType parameter missing");
            break;

        case 1213:
            message = PTPVLocalizedString(@"OperationResult parameter missing");
            break;

        case 1214:
            message = PTPVLocalizedString(@"OperationAmount parameter missing");
            break;

        case 1215:
            message = PTPVLocalizedString(@"OperationCurrency parameter missing");
            break;

        case 1216:
            message = PTPVLocalizedString(@"OperationDatetime parameter missing");
            break;

        case 1217:
            message = PTPVLocalizedString(@"OriginalAmount parameter missing");
            break;

        case 1218:
            message = PTPVLocalizedString(@"Pan parameter missing");
            break;

        case 1219:
            message = PTPVLocalizedString(@"ExpiryDate parameter missing");
            break;

        case 1220:
            message = PTPVLocalizedString(@"Reference parameter missing");
            break;

        case 1221:
            message = PTPVLocalizedString(@"Signature parameter missing");
            break;

        case 1222:
            message = PTPVLocalizedString(@"OriginalIP parameter missing or not in a correct format");
            break;

        case 1223:
            message = PTPVLocalizedString(@"Authcode / errorCode parameter missing");
            break;

        case 1224:
            message = PTPVLocalizedString(@"Product of the operation missing");
            break;

        case 1225:
            message = PTPVLocalizedString(@"The type of operation is not supported");
            break;

        case 1226:
            message = PTPVLocalizedString(@"The result of the operation is not supported");
            break;

        case 1227:
            message = PTPVLocalizedString(@"The transaction currency is not supported");
            break;

        case 1228:
            message = PTPVLocalizedString(@"The date of the transaction is not in a correct format");
            break;

        case 1229:
            message = PTPVLocalizedString(@"The signature is not correct");
            break;

        case 1230:
            message = PTPVLocalizedString(@"Can not find the associated account information");
            break;

        case 1231:
            message = PTPVLocalizedString(@"Can not find the associated product information");
            break;

        case 1232:
            message = PTPVLocalizedString(@"Can not find the associated user information");
            break;

        case 1233:
            message = PTPVLocalizedString(@"The product is not set as multicurrency");
            break;

        case 1234:
            message = PTPVLocalizedString(@"The amount of the transaction is not in a correct format");
            break;

        case 1235:
            message = PTPVLocalizedString(@"The original amount of the transaction is not in a correct format");
            break;

        case 1236:
            message = PTPVLocalizedString(@"The card does not have the correct format");
            break;

        case 1237:
            message = PTPVLocalizedString(@"The expiry date of the card is not in a correct format");
            break;

        case 1238:
            message = PTPVLocalizedString(@"Can not initialize the service");
            break;

        case 1239:
            message = PTPVLocalizedString(@"Can not initialize the service");
            break;

        case 1240:
            message = PTPVLocalizedString(@"Method not implemented");
            break;

        case 1241:
            message = PTPVLocalizedString(@"Can not initialize the service");
            break;

        case 1242:
            message = PTPVLocalizedString(@"Service can not be completed");
            break;

        case 1243:
            message = PTPVLocalizedString(@"OperationCode parameter missing");
            break;

        case 1244:
            message = PTPVLocalizedString(@"bankName parameter missing");
            break;

        case 1245:
            message = PTPVLocalizedString(@"csb parameter missing");
            break;

        case 1246:
            message = PTPVLocalizedString(@"userReference parameter missing");
            break;

        case 1247:
            message = PTPVLocalizedString(@"Can not find the associated FUC");
            break;

        case 1248:
            message = PTPVLocalizedString(@"Duplicate xref. Pending operation.");
            break;

        case 1249:
            message = PTPVLocalizedString(@"[DS_]AGENT_FEE parameter missing");
            break;

        case 1250:
            message = PTPVLocalizedString(@"[DS_]AGENT_FEE parameter is not in a correct format");
            break;

        case 1251:
            message = PTPVLocalizedString(@"DS_AGENT_FEE parameter is not correct");
            break;

        case 1252:
            message = PTPVLocalizedString(@"CANCEL_URL parameter missing");
            break;

        case 1253:
            message = PTPVLocalizedString(@"CANCEL_URL parameter is not in a correct format");
            break;

        case 1254:
            message = PTPVLocalizedString(@"Commerce with secure cardholder and cardholder without secure purchase key");
            break;

        case 1255:
            message = PTPVLocalizedString(@"Call terminated by the client");
            break;

        case 1256:
            message = PTPVLocalizedString(@"Call terminated, incorrect attempts exceeded");
            break;

        case 1257:
            message = PTPVLocalizedString(@"Call terminated, operation attempts exceeded");
            break;

        case 1258:
            message = PTPVLocalizedString(@"stationID not available");
            break;

        case 1259:
            message = PTPVLocalizedString(@"It has not been possible to establish the IVR session");
            break;

        case 1260:
            message = PTPVLocalizedString(@"merchantCode parameter missing");
            break;

        case 1261:
            message = PTPVLocalizedString(@"The merchantCode parameter is incorrect");
            break;

        case 1262:
            message = PTPVLocalizedString(@"terminalIDDebtor parameter missing");
            break;

        case 1263:
            message = PTPVLocalizedString(@" terminalIDCreditor parameter missing");
            break;
            
        case 1264:
            message = PTPVLocalizedString(@"Authorisations for carrying out the operation not available ");
            break;
            
        case 1265:
            message = PTPVLocalizedString(@"The Iban account (terminalIDDebtor) is invalid");
            break;
            
        case 1266:
            message = PTPVLocalizedString(@"The Iban account (terminalIDCreditor) is invalid");
            break;
            
        case 1267:
            message = PTPVLocalizedString(@"The BicCode of the Iban account (terminalIDDebtor) is invalid");
            break;
            
        case 1268:
            message = PTPVLocalizedString(@"The BicCode of the Iban account (terminalIDCreditor) is invalid");
            break;
            
        case 1269:
            message = PTPVLocalizedString(@"operationOrder parameter missing");
            break;
            
        case 1270:
            message = PTPVLocalizedString(@"The operationOrder parameter does not have the correct format");
            break;
            
        case 1271:
            message = PTPVLocalizedString(@"The operationAmount parameter does not have the correct format");
            break;
            
        case 1272:
            message = PTPVLocalizedString(@"The operationDatetime parameter does not have the correct format");
            break;
            
        case 1273:
            message = PTPVLocalizedString(@"The operationConcept parameter contains invalid characters or exceeds 140 characters");
            break;
            
        case 1274:
            message = PTPVLocalizedString(@"It has not been possible to record the SEPA operation");
            break;
            
        case 1275:
            message = PTPVLocalizedString(@"It has not been possible to record the SEPA operation");
            break;
            
        case 1276:
            message = PTPVLocalizedString(@"Can not create an operation token");
            break;
            
        case 1277:
            message = PTPVLocalizedString(@"Invalid scoring value");
            break;
            
        case 1278:
            message = PTPVLocalizedString(@"The language parameter is not in a correct format");
            break;
            
        case 1279:
            message = PTPVLocalizedString(@"The cardholder name is not in a correct format");
            break;
            
        case 1280:
            message = PTPVLocalizedString(@"The card does not have the correct format");
            break;
            
        case 1281:
            message = PTPVLocalizedString(@"The month does not have the correct format");
            break;
            
        case 1282:
            message = PTPVLocalizedString(@"The year does not have the correct format");
            break;
            
        case 1283:
            message = PTPVLocalizedString(@"The cvc2 does not have the correct format");
            break;
            
        case 1284:
            message = PTPVLocalizedString(@"The apiID parameter is not in a correct format");
            break;
            
        case 1288:
            message = PTPVLocalizedString(@"The splitId parameter is not valid");
            break;
            
        case 1289:
            message = PTPVLocalizedString(@"The splitId parameter is not allowed");
            break;
            
        case 1290:
            message = PTPVLocalizedString(@"This terminal don't allow split transfers");
            break;
            
        case 1291:
            message = PTPVLocalizedString(@"It has not been possible to record the split transfer operation");
            break;
            
        case 1292:
            message = PTPVLocalizedString(@"Original payment's date cannot exceed 90 days");
            break;
            
        case 1293:
            message = PTPVLocalizedString(@"Original split tansfer not found");
            break;
            
        case 1294:
            message = PTPVLocalizedString(@"Total reversal cannot exceed original split transfer");
            break;
            
        case 1295:
            message = PTPVLocalizedString(@"It has not been possible to record the split transfer reversal operation");
            break;

        default:
            message = PTPVLocalizedString(@"There was an unexpected error. Please try again later");
            break;
    }

    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: message,
                               PTPVErrorCodeKey: [NSNumber numberWithInteger:errorId],
                               };
    return [[self alloc] initWithDomain:PAYTPVDomain code:errorId userInfo:userInfo];
}

@end
