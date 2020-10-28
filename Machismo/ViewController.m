//
//  ViewController.m
//  Machismo
//
//  Created by Ariel Imber on 26/10/2020.
//

#import "ViewController.h"
#import "PlayngCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;

@end

@implementation ViewController


-(CardMatchingGame *)game{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
    return _game;
}

- (Deck *) createDeck{
    return [[PlayngCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenButtonIndex  = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
 
    
}

- (void) updateUI{
    for (UIButton *cardButton in self.cardButtons){
        NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setBackgroundImage: [self backgroundForCard:card] forState:UIControlStateNormal];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLable.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
    }
}

- (NSString *) titleForCard:(Card *) card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundForCard:(Card *) card{
    return [UIImage imageNamed: card.isChosen ? @"CardFront" : @"CardBack"];
}


@end
