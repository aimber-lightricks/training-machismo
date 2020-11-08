//
//  GamesViewControllersCommon.h
//  Machismo
//
//  Created by Ariel Imber on 07/11/2020.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "CardMatchingGame.h"
#import "CardAttributedDescription.h"
NS_ASSUME_NONNULL_BEGIN

@interface GamesViewControllersCommon : NSObject



+ (NSAttributedString *)detailedScore:(struct MoveResult) moveResult withCardAttributedDescription: (CardAttributedDescription *) cardAttributedDescription;

@end

NS_ASSUME_NONNULL_END
