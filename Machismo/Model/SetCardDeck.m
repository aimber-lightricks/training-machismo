//
//  SetCardDeck.m
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck
- (instancetype)init{
    self = [super init];
    if (self){
        for (NSString *shape in [SetCard validSahpes]){
          for (NSString *color in [SetCard validColors]){
            for (NSNumber *shading in @[@0, @0.5, @1] ){
                SetCard *card = [[SetCard alloc] init];
                card.shape = shape;
                card.color = color;
              card.shading = shading;
                [self addCard:card];
            }
          }
        }
    }
    return self;
}
@end
