//
//  Card.h
//  Machismo
//
//  Created by Ariel Imber on 26/10/2020.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Card : NSObject

- (int)match:(NSArray *) otherCards;

@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

@end

NS_ASSUME_NONNULL_END
