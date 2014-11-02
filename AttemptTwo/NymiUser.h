//
//  NymiUser.h
//  digital-id-1
//
//  Created by mchan2 on 11/1/14.
//  Copyright (c) 2014 MatthewChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NymiUser : NSObject
{
    NSString *dobYear;
    NSString *dobMonth;
    NSString *dobDay;
    NSString *firstName;
    NSString *lastName;
    int trustScore;
}

@property(nonatomic, strong) NSString *dobYear;
@property(nonatomic, strong) NSString *dobMonth;
@property(nonatomic, strong) NSString *dobDay;
@property(nonatomic, strong) NSString *firstName;
@property(nonatomic, strong) NSString *lastName;

/*

 NOTES:
 - get past visits?
 - get visit count
 - get items purchased?
 - credit card info of some kind?
 
 */

@end
