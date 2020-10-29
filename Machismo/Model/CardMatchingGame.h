//
//  CardMatchingGame.h
//  Machismo
//
//  Created by Ariel Imber on 28/10/2020.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck;
- (instancetype)initWithCardCount:(NSUInteger) count usingDeck:(Deck *) deck matchingNumberOfCards:(NSInteger) numOfCardsToMatch;

- (void)chooseCardAtIndex:(NSUInteger) index;
- (Card *) cardAtIndex:(NSUInteger) index;
@property (nonatomic) NSInteger numberOfCardsToMatch;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *lastMoveScoreDetails;

@end

NS_ASSUME_NONNULL_END
