//
//  SetGameViewController.m
//  Machismo
//
//  Created by Ariel Imber on 06/11/2020.
//

#import "SetGameViewController.h"

#import "SetCard.h"
#import "SetCardDeck.h"
#import "SetCardAttributedDescription.h"
#import "CardMatchingGame.h"
#import "GamesViewControllersCommon.h"



@interface SetGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UILabel *lastMoveLable;
@end

@implementation SetGameViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self startNewGame];
    // Do any additional setup after loading the view.
}


- (void)startNewGame {
  
  self.game = [self createNewGame];
  [self updateUI];
}


- (CardMatchingGame *)createNewGame{
    
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:[self createDeck]
            matchingNumberOfCards: 3];
    

}

- (Deck *)createDeck{
  return [[SetCardDeck alloc] init];
}

- (Deck *)deck{
    if (!_deck) _deck = [self createDeck];
    return _deck;
}


- (CardMatchingGame *)game{
  
    if (!_game) _game = [self createNewGame];
    return _game;
}


- (IBAction)touchCardButton:(id)sender {
  NSUInteger chosenButtonIndex  = [self.cardButtons indexOfObject:sender];
  struct MoveResult moveResult = [self.game chooseCardAtIndex:chosenButtonIndex];
  SetCardAttributedDescription * setCardAttributedDescription  = [[SetCardAttributedDescription alloc] init];
  
  NSAttributedString *moveOutcomeDescription = [GamesViewControllersCommon detailedScore:moveResult withCardAttributedDescription:setCardAttributedDescription];
  [self updateUI:moveOutcomeDescription];


}

- (void)updateUI {
  NSAttributedString *emptyString = [[NSAttributedString alloc] initWithString:@""];
  [self updateUI:emptyString];
}

- (void)updateUI:lastMoveDescription{
  for (UIButton *cardButton in self.cardButtons){
    NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardIndex];
    [cardButton setBackgroundImage: [self backgroundForCard:card] forState:UIControlStateNormal];
    [cardButton setAttributedTitle: [self titleForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
  }
  self.scoreLable.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];

  NSMutableAttributedString *fullLastMoveDescription = [[NSMutableAttributedString alloc] initWithString:@"Last move: "];
  [fullLastMoveDescription appendAttributedString:lastMoveDescription];
  self.lastMoveLable.attributedText = fullLastMoveDescription;
  
}


- (NSAttributedString *)titleForCard:(Card *)card{
  SetCardAttributedDescription *setCardAttributedDescription = [[SetCardAttributedDescription alloc] initWithCard:card];
  return [setCardAttributedDescription cardAttributedDescription];
}

- (UIImage *)backgroundForCard:(Card *)card{
  return [UIImage imageNamed: card.isChosen ? @"CardChosen" : @"CardFront"] ;
}


- (IBAction)restartGameButton:(UIButton *)sender {
  [self startNewGame];
}

@end
