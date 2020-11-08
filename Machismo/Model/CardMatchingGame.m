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



-(struct MoveResult)chooseCardAtIndex:(NSUInteger)index{
  
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
          
          self.score += matchScore * MATCH_BONUS;
          moveResult.moveOutcome = Matched;
          moveResult.moveScore = matchScore * MATCH_BONUS;
          
          //                  self.lastMoveScoreDetails = [self detailedScore:matchScore * MATCH_BONUS
          //                                                         usingCards:allChosenCards
          //                                                        usingReason:@"cards matched"];
          card.matched = YES;
          for (Card *otherCard in otherChosenCards){
            otherCard.matched = YES;
          }
        } else {
          self.score -= MISSMATCH_PENALTY;
          moveResult.moveOutcome = DidNotMatch;
          moveResult.moveScore = -MISSMATCH_PENALTY;
//          self.lastMoveScoreDetails = [self detailedScore:-MISSMATCH_PENALTY
//                                               usingCards:allChosenCards
//                                              usingReason:@"cards did not match"];
          for (Card *otherCard in otherChosenCards){
            otherCard.chosen = NO;
          }
        }
      }
    }
    self.score -= COST_TO_CHOOSE;
    moveResult.movePenalty = COST_TO_CHOOSE;
//    self.lastMoveScoreDetails = [NSString stringWithFormat:@ "%@Paying %d for choosing card %@.", self.lastMoveScoreDetails, -COST_TO_CHOOSE, card.contents];
    card.chosen = YES;
    
  } else {
    moveResult.moveOutcome = AlreadyMatched;
  }
  
  return moveResult;
}


@end
