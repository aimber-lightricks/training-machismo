//
//  SetCard.h
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetCard : Card

+ (NSArray*) validSahpes;
+ (NSArray*) validColors;

@property (nonatomic, strong) NSString *shape;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSNumber *shading;

@end

NS_ASSUME_NONNULL_END
