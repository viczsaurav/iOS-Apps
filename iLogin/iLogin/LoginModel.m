//
//  LoginModel.m
//  iLogin
//
//  Created by student on 16/4/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

- (BOOL) verifyUser:(NSString *)userID andPassword:(NSString *)password {
    if ([userID isEqualToString:password]) {
        return true;
    } else {
        return false;
    }
}

@end
