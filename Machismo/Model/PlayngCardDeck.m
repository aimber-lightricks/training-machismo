//
//  PlayngCardDeck.m
//  Machismo
//
//  Created by Ariel Imber on 27/10/2020.
//

#import "PlayngCardDeck.h"

#import "PlayngCard.h"

@implementation PlayngCardDeck

- (instancetype)init {
    self = [super init];
    if (self){
        for (NSString *suit in [PlayngCard validSuits]){
            for (NSUInteger rank=1; rank < [PlayngCard maxRank]; rank++ ){
                PlayngCard *card = [[PlayngCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    return self;
}
@end
