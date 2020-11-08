//
//  CardAttributedDescription.h
//  Machismo
//
//  Created by Ariel Imber on 08/11/2020.
//

#import <Foundation/Foundation.h>
#import "Card.h"
NS_ASSUME_NONNULL_BEGIN

@interface CardAttributedDescription : NSObject
@property (strong, nonatomic) Card *card;
- (instancetype)initWithCard:(Card *) card;
- (NSAttributedString *) cardAttributedDescription; //abstract

@end

NS_ASSUME_NONNULL_END
