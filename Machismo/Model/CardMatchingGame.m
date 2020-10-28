//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Ariel Imber on 28/10/2020.
//

#import "CardMatchingGame.h"
static const int MISSMATCH_PENALTY = 1;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (NSArray *)cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    if (self){
        for (NSInteger i=0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return index < [self.cards count] ? self.cards[index] : nil;
}


-(void)chooseCardAtIndex:(NSUInteger)index{
    
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if ([card isChosen]){
            [card setChosen:NO];
        } else {
            // match against other cards
            for (Card *otherCard in self.cards){
                if (!otherCard.isMatched && otherCard.isChosen){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                    } else {
                        self.score -= MISSMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break; //can only chose 2 cards for now
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
        
    }
}


@end
