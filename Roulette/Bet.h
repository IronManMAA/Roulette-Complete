//
//  Bet.h
//  Roulette
//
//  Created by Joben Gohlke on 11/28/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bet : NSObject

//- (instancetype)initWithColor:(NSString *)color andNumber:(NSUInteger)number;
- (instancetype)initWithNumber:(NSString *)number;

- (instancetype)initWithRandomBet;
- (NSString *)betText;

@end
