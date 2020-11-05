//
//  PlayngCard.m
//  Machismo
//
//  Created by Ariel Imber on 26/10/2020.
//

#import "PlayngCard.h"

@implementation PlayngCard

- (int)match:(NSArray *)otherCards{
    int score =0;
//    if ([otherCards count] == 1){
//        PlayngCard *otherCard = [otherCards firstObject];
//            if (self.rank == otherCard.rank){
//                NSLog([NSString stringWithFormat:@"Playng card score before: %d", score]);
//                score = 4;
//                NSLog([NSString stringWithFormat:@"Playng card score after: %d", score]);
//            }
//            if ([self.suit isEqualToString: otherCard.suit]) score = 1;
//        }

    NSLog(@"%@", [NSString stringWithFormat:@"PlaynyCard1 otheCards %@ ", otherCards]);
    for (PlayngCard *otherCard in otherCards){
        NSLog(@"%@", [NSString stringWithFormat:@"PlaynyCard2 otheCard %@ ", otherCard]);
        
        if (self.rank == otherCard.rank){
            score += 4;
        }
        if ([self.suit isEqualToString: otherCard.suit]) score += 1;
    }
    return score;
    
}

- (NSString *)contents{
    NSArray *rankStrings = [PlayngCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}
@synthesize suit = _suit;

+ (NSArray*) validSuits {
    return @[@"♣︎", @"♥︎", @"♦︎", @"♠︎"];
}

- (void)setSuit:(NSString *)suit{
    if ([[PlayngCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

- (NSString *)suit{
    return  _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings{
    
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9",  @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank{
    return [[PlayngCard rankStrings] count];
}

- (void) setRank:(NSUInteger)rank{
    if (rank <= [PlayngCard maxRank]){
        _rank = rank;
    }
}
@end
