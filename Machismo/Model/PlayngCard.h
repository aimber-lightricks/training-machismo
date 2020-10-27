//
//  PlayngCard.h
//  Machismo
//
//  Created by Ariel Imber on 26/10/2020.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayngCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end

NS_ASSUME_NONNULL_END
