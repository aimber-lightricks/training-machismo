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
@property (nonatomic, readwrite) NSString *lastMoveScoreDetails;

@property (nonatomic, strong) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

-(void)setNumberOfCardsToMatch:(NSInteger)numberOfCardsToMatch{
    BOOL cleanCards = YES;
    for (Card *card in self.cards)
        if (card.isChosen || card.isMatched){
            cleanCards = NO;
            break;
        }
    if (cleanCards){
        _numberOfCardsToMatch = numberOfCardsToMatch;
    }
}

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
        self.lastMoveScoreDetails = @"";
    }
    
    return self;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchingNumberOfCards:(NSInteger)numOfCardsToMatch{
    self = [self initWithCardCount:count usingDeck:deck];
    if (self) self.numberOfCardsToMatch = numOfCardsToMatch;
    return self;
    
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return index < [self.cards count] ? self.cards[index] : nil;
}

- (NSString *)detailedScore:(NSInteger)score usingCards:(NSArray *)cards
          usingReason:(NSString*) reason{
    NSMutableString *detailedScore = [[NSMutableString alloc] init];
    [detailedScore appendString: [NSString stringWithFormat:@" score %ld", score]];
    if ([cards count]){
        [detailedScore appendString:@" for cards"];
        for (Card* card in cards){
            [detailedScore appendString: [NSString stringWithFormat:@" %@", card.contents]];
        }
        [detailedScore appendString: [NSString stringWithFormat:@" because %@.\n", reason]];
    }
    
    return detailedScore;
    
}

-(void)chooseCardAtIndex:(NSUInteger)index{
    
    self.lastMoveScoreDetails = @"";
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen =  NO;
        } else {
            NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
            NSInteger numberOfChosenCards = 1; // the current card is considerd as choshen
            // match against other cards
            
            for (Card *otherCard in self.cards){
                if (!otherCard.isMatched && otherCard.isChosen){
                    numberOfChosenCards++;
                    [otherChosenCards addObject:otherCard];
                    if (numberOfChosenCards == self.numberOfCardsToMatch){
                        break;
                    }
                }
            }
            NSMutableArray * allChosenCards = [[NSMutableArray alloc] init];
            [allChosenCards addObject:card];
            [allChosenCards addObjectsFromArray:otherChosenCards];
//            for (Card *otherCard in otherChosenCards){
//                NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex2.1 %@ chosen %d matched %d", otherCard.contents, otherCard.chosen, otherCard.matched]);
//            }
            if (numberOfChosenCards == self.numberOfCardsToMatch){
//                NSLog(@"chooseCardAtIndex3");
                int matchScore = [card match:otherChosenCards];
//                NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex3.1 match score %d ", matchScore]);
                if (matchScore){
                    
//                    NSLog(@"chooseCardAtIndex3.2");
                    self.score += matchScore * MATCH_BONUS;
                    self.lastMoveScoreDetails = [self detailedScore:matchScore * MATCH_BONUS
                                                         usingCards:allChosenCards
                                                        usingReason:@"cards matched"];
                    card.matched = YES;
                    for (Card *otherCard in otherChosenCards){
                            otherCard.matched = YES;
                        }
                } else {
                    self.score -= MISSMATCH_PENALTY;
                    self.lastMoveScoreDetails = [self detailedScore:-MISSMATCH_PENALTY
                                                         usingCards:allChosenCards
                                                        usingReason:@"cards did not match"];
                    for (Card *otherCard in otherChosenCards){
                        otherCard.chosen = NO;
                    }
                }
            }
            NSLog(@"chooseCardAtIndex4");
        }
        NSLog(@"chooseCardAtIndex5");
        self.score -= COST_TO_CHOOSE;
        self.lastMoveScoreDetails = [NSString stringWithFormat:@ "%@Paying %d for choosing card %@.", self.lastMoveScoreDetails, -COST_TO_CHOOSE, card.contents];
        card.chosen = YES;
        NSLog(@"chooseCardAtIndex6");
        for (Card *otherCard in self.cards){
            NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex6.1 %@ chosen %d matched %d", otherCard.contents, otherCard.chosen, otherCard.matched]);
        }
        
    }
}


@end
