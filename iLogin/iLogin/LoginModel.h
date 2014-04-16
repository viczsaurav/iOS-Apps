//
//  LoginModel.h
//  iLogin
//
//  Created by student on 16/4/14.
//  Copyright (c) 2014 ISS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject

- (BOOL) verifyUser:(NSString *) userID andPassword:(NSString *) password;

@end
