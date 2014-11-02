//
//  NymiUser.m
//  digital-id-1
//
//  Created by mchan2 on 11/1/14.
//  Copyright (c) 2014 MatthewChan. All rights reserved.
//

#import "NymiUser.h"

@implementation NymiUser
@synthesize firstName = _firstName;
@synthesize lastName = _lastName;
@synthesize dobMonth = _dobMonth;
@synthesize dobDay = _dobDay;
@synthesize dobYear = _dobYear;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.firstName = @"Jeremy";
        self.lastName = @"Carson";
        self.dobDay = @"12";
        self.dobMonth = @"3";
        self.dobYear = @"1985";
        trustScore = 97;
    }
    
    return self;
}

-(NSString *)description
{
    NSLog(@"My name is %@ and i was born in the year %@, the %@ of %@", _firstName, _dobYear, _dobDay, _dobMonth);
    
    return [NSString stringWithFormat:@"My name is %@ and i was born in the year %@, the %@ of %@. My score is %d", _firstName, _dobYear, _dobDay, _dobMonth, trustScore];
    
}
@end
