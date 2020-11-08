//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Ariel Imber on 28/10/2020.
//

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "Card.h"

typedef NS_ENUM(NSUInteger, MoveOutcome) {
  NoMatchingRequired,
  Matched,
  DidNotMatch,
  FlippedCard,
  AlreadyMatched

};

struct MoveResult {
  MoveOutcome moveOutcome;
  NSInteger moveScore;
  NSInteger movePenalty;
  NSArray * _Nonnull moveCards;
};

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;
- (instancetype)initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck matchingNumberOfCards:(NSInteger) numOfCardsToMatch;

- (struct MoveResult)chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger) index;

@property (nonatomic) NSInteger numberOfCardsToMatch;
@property (readonly, nonatomic) NSInteger score;
@property (readonly, nonatomic) NSString *lastMoveScoreDetails;

@end

NS_ASSUME_NONNULL_END
