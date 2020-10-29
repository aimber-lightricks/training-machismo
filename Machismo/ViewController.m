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
@property (nonatomic) NSInteger numberOfMatchesMode;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardMatchModeSegmentControl;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLable;



@end

@implementation ViewController

- (NSInteger)numberOfMatchesMode{
    return [self.cardMatchModeSegmentControl selectedSegmentIndex] + 2;
}

- (IBAction)cardMatchModeChanged:(id)sender {
    self.game.numberOfCardsToMatch = self.numberOfMatchesMode;
    NSLog([NSString localizedStringWithFormat:@"numberOfMatchesMode %d", self.numberOfMatchesMode ]);
}

- (IBAction)restartGameButton:(UIButton *)sender {
    self.game = [self createNewGame];
    [self updateUI];
    [self.cardMatchModeSegmentControl setEnabled:YES];
}


- (CardMatchingGame *)createNewGame{
    
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]
            matchingNumberOfCards:self.numberOfMatchesMode];
    

}

-(CardMatchingGame *)game{
    if (!_game) _game = [self createNewGame];
    return _game;
}

- (Deck *) createDeck{
    return [[PlayngCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    [self.cardMatchModeSegmentControl setEnabled:NO];
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
        self.lastMoveLable.text = [NSString stringWithFormat:@"Last move: %@", self.game.lastMoveScoreDetails];
    }
}

- (NSString *) titleForCard:(Card *) card{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundForCard:(Card *) card{
    return [UIImage imageNamed: card.isChosen ? @"CardFront" : @"CardBack"];
}


@end
