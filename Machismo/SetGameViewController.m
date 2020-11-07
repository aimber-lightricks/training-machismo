//
//  SetGameViewController.m
//  Machismo
//
//  Created by Ariel Imber on 06/11/2020.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "CardMatchingGame.h"

#define UIColorFromRGB(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:alphaValue]

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


- (void) startNewGame {
  self.game = [self createNewGame];
  [self updateUI];
}


- (CardMatchingGame *)createNewGame{
    
    return [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                             usingDeck:self.deck
            matchingNumberOfCards: 3];
    

}

-(Deck *)deck{
    if (!_deck) _deck = [[SetCardDeck alloc] init];
    return _deck;
}


-(CardMatchingGame *)game{
    if (!_game) _game = [self createNewGame];
    return _game;
}


- (IBAction)touchCardButton:(id)sender {
  NSUInteger chosenButtonIndex  = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
  [self updateUI];

  
}

- (void) updateUI{
  for (UIButton *cardButton in self.cardButtons){
      NSUInteger cardIndex = [self.cardButtons indexOfObject:cardButton];
      Card *card = [self.game cardAtIndex:cardIndex];
      [cardButton setBackgroundImage: [self backgroundForCard:card] forState:UIControlStateNormal];
      [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
      
    cardButton.enabled = !card.isMatched;
      self.scoreLable.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
      self.lastMoveLable.text = [NSString stringWithFormat:@"Last move: %@", self.game.lastMoveScoreDetails];
  }
}

- (int) colorNameToHex: (NSString*) colorName {
  if ([colorName isEqualToString:@"red"]) return 0xFF0000;
  if ([colorName isEqualToString:@"green"]) return 0x008000;
  if ([colorName isEqualToString:@"blue"]) return 0x0000FF;
  if ([colorName isEqualToString:@"black"]) return 0x000000;

  return 0x000000; //black is the default
}
- (IBAction)restartGameButton:(UIButton *)sender {
  [self startNewGame];
}

- (NSAttributedString *) titleForCard:(Card *) card{
  SetCard *setCard = (SetCard *)card;
  NSString *cardContent = setCard.shape;
  NSMutableAttributedString  *cardContentAttributed = [[NSMutableAttributedString alloc] initWithString:cardContent];
  UIColor *color  = UIColorFromRGB([self colorNameToHex:setCard.color], [setCard.shading floatValue]);
  
  [cardContentAttributed addAttributes:@{NSForegroundColorAttributeName : color,
                                         
  }
                                range:NSMakeRange(0, [cardContent length])];
  
////  card.isChosen ? card.contents : @""
  return (NSAttributedString *)cardContentAttributed;
}

- (UIImage *) backgroundForCard:(Card *) card{
  return [UIImage imageNamed: card.isChosen ? @"CardChosen" : @"CardFront"] ;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
