//
//  GamesViewControllersCommon.m
//  Machismo
//
//  Created by Ariel Imber on 07/11/2020.
//

#import "GamesViewControllersCommon.h"

#import "CardAttributedDescription.h"


@implementation GamesViewControllersCommon


+ (NSString*)moveOutcomeToString:(MoveOutcome)moveOutcome {
    NSString *result = nil;

    switch(moveOutcome) {
        case FlippedCard:
            result = @"card was only flipped";
            break;
        case NoMatchingRequired:
            result = @"not enough cards were turned to match";
            break;
        case Matched:
            result = @"cards matched";
            break;
        case DidNotMatch:
            result = @"cards did not match";
            break;
        default:
            [NSException raise:NSGenericException format:@"Unexpected FormatType."];
    }

    return result;
}


+ (NSAttributedString *)cardsDescription:(NSArray *)cards withCardAttributedDescription:(CardAttributedDescription *)cardAttributedDescription{
  
  
  NSMutableAttributedString  *cardsDescriptionString = [[NSMutableAttributedString alloc] initWithString:@""];
  NSAttributedString *comma = [[NSAttributedString alloc] initWithString:@","];
  if (cards){
    for (Card* card in cards){
      cardAttributedDescription.card = card;
//      NSAttributedString * sta = [[NSAttributedString alloc] initWithString:];
      [cardsDescriptionString appendAttributedString: [cardAttributedDescription cardAttributedDescription]];
      [cardsDescriptionString appendAttributedString: comma];

    }
  }
  return cardsDescriptionString;
}



+ (NSAttributedString *)detailedScore:(struct MoveResult) moveResult withCardAttributedDescription: (CardAttributedDescription *)cardAttributedDescription{
  
  NSMutableAttributedString  *detailedScoreStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat: @"Move score is %ld", (long)moveResult.moveScore]];
  
  NSString * st =  [NSString stringWithFormat: @" because %@.", [GamesViewControllersCommon moveOutcomeToString:moveResult.moveOutcome]];
  NSAttributedString * sta = [[NSAttributedString alloc] initWithString:st];
  [detailedScoreStr appendAttributedString: sta];
   
  st = [NSString stringWithFormat: @" Losing %ld on move itself.", (long)moveResult.movePenalty];
  sta = [[NSAttributedString alloc] initWithString:st];
  [detailedScoreStr appendAttributedString: sta];

  sta = [[NSAttributedString alloc] initWithString:@" For cards: "];
  [detailedScoreStr appendAttributedString: sta];

  [detailedScoreStr appendAttributedString: [GamesViewControllersCommon cardsDescription:moveResult.moveCards withCardAttributedDescription:cardAttributedDescription]];
  
  return detailedScoreStr;
  
}


@end
