//
//  Card.m
//  Machismo
//
//  Created by Ariel Imber on 26/10/2020.
//

#import "Card.h"

@implementation Card
-(int)match:(NSArray *)otherCards{
    int score = 0;
    for (Card *card in otherCards){
        if ([card.contents isEqualToString:self.contents]){
            score = 1;
        }
    }
    return score;
}

@end
