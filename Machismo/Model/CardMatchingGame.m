//
//  CardMatchingGame.m
//  Machismo
//
//  Created by Ariel Imber on 28/10/2020.
//

#import "CardMatchingGame.h"

static const int kMissMatchPenalty = 1;
static const int kMatchBonus = 4;
static const int kCostToChoose = 1;


@interface CardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards; //of Card
@end

@implementation CardMatchingGame

- (void)setNumberOfCardsToMatch:(NSInteger)numberOfCardsToMatch {
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

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
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

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matchingNumberOfCards:(NSInteger)numOfCardsToMatch {
    self = [self initWithCardCount:count usingDeck:deck];
    if (self) self.numberOfCardsToMatch = numOfCardsToMatch;
    return self;
    
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index] : nil;
}

- (struct MoveResult)chooseCardAtIndex:(NSUInteger)index {
  
  struct MoveResult moveResult;
  moveResult.moveOutcome = NoMatchingRequired;
  moveResult.moveScore = 0;
  moveResult.movePenalty = 0;

  Card *card = [self cardAtIndex:index];
  moveResult.moveCards = @[card];
  if (!card.isMatched){
    if (card.isChosen){
      card.chosen =  NO;
      moveResult.moveOutcome = FlippedCard;
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
      moveResult.moveCards = allChosenCards;
      if (numberOfChosenCards == self.numberOfCardsToMatch){
        int matchScore = [card match:otherChosenCards];
        if (matchScore){
          
          self.score += matchScore * kMatchBonus;
          moveResult.moveOutcome = Matched;
          moveResult.moveScore = matchScore * kMatchBonus;
          
          //                  self.lastMoveScoreDetails = [self detailedScore:matchScore * MATCH_BONUS
          //                                                         usingCards:allChosenCards
          //                                                        usingReason:@"cards matched"];
          card.matched = YES;
          for (Card *otherCard in otherChosenCards){
            otherCard.matched = YES;
          }
        } else {
          self.score -= kMissMatchPenalty;
          moveResult.moveOutcome = DidNotMatch;
          moveResult.moveScore = -kMissMatchPenalty;
          for (Card *otherCard in otherChosenCards) {
            otherCard.chosen = NO;
          }
        }
      }
    }
    self.score -= kCostToChoose;
    moveResult.movePenalty = kCostToChoose;
    card.chosen = YES;
    
  } else {
    moveResult.moveOutcome = AlreadyMatched;
  }
  
  return moveResult;
}


@end
