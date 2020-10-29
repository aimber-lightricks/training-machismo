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


-(void)chooseCardAtIndex:(NSUInteger)index{
    NSMutableString *scoreDetails;
//    for (Card *otherCard in self.cards){
//        NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex-1.1 %@ chosen %d matched %d", otherCard.contents, otherCard.chosen, otherCard.matched]);
//    }
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen =  NO;
        } else {
//            NSLog(@"chooseCardAtIndex0");
            NSMutableArray *otherChosenCards = [[NSMutableArray alloc] init];
            NSInteger numberOfChosenCards = 1; // the current card is considerd as choshen
//            NSLog(@"chooseCardAtIndex1");
            // match against other cards
            
            for (Card *otherCard in self.cards){
//                NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex1.1 %@", otherCard.contents]);
                if (!otherCard.isMatched && otherCard.isChosen){
//                    NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex1.2 %@ chosen %d matched %d", otherCard.contents, otherCard.chosen, otherCard.matched]);
                    numberOfChosenCards++;
//                    NSLog(@"chooseCardAtIndex1.3");
                    [otherChosenCards addObject:otherCard];
//                    NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex1.4 numberOfCardsToMatch %d numberOfChosenCards %d" , self.numberOfCardsToMatch, numberOfChosenCards]);
                    if (numberOfChosenCards == self.numberOfCardsToMatch){
//                        NSLog(@"chooseCardAtIndex1.5");
                        break;
                    }
                }
            }
            NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex2 %ld", numberOfChosenCards]);
            for (Card *otherCard in otherChosenCards){
                NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex2.1 %@ chosen %d matched %d", otherCard.contents, otherCard.chosen, otherCard.matched]);
            }
            if (numberOfChosenCards == self.numberOfCardsToMatch){
                NSLog(@"chooseCardAtIndex3");
                int matchScore = [card match:otherChosenCards];
                NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex3.1 match score %d ", matchScore]);
                if (matchScore){
                    NSLog(@"chooseCardAtIndex3.2");
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for (Card *otherCard in otherChosenCards){
                            otherCard.matched = YES;
                        }
                } else {
                    self.score -= MISSMATCH_PENALTY;
                    for (Card *otherCard in otherChosenCards){
                        otherCard.chosen = NO;
                    }
                }
            }
            NSLog(@"chooseCardAtIndex4");
        }
        NSLog(@"chooseCardAtIndex5");
        self.score -= COST_TO_CHOOSE;
        card.chosen = YES;
        NSLog(@"chooseCardAtIndex6");
        for (Card *otherCard in self.cards){
            NSLog(@"%@", [NSString stringWithFormat:@"chooseCardAtIndex6.1 %@ chosen %d matched %d", otherCard.contents, otherCard.chosen, otherCard.matched]);
        }
        
    }
}


@end
