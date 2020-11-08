//
//  HistoryViewController.m
//  Machismo
//
//  Created by Ariel Imber on 08/11/2020.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;


@end

@implementation HistoryViewController

- (void)viewWillAppear:(BOOL)animated {
  [super viewDidLoad];
  [self updateUI];
}

- (void)setHistoryArray:(NSArray *)historyArray {
  _historyArray = historyArray;
  [self updateUI];
}

- (void) updateUI {
  NSMutableAttributedString *historyText = [[NSMutableAttributedString alloc] initWithString:@""];
  NSMutableAttributedString *newLine = [[NSMutableAttributedString alloc] initWithString:@"\n"];
  int i = 1;
  for (NSAttributedString *historyDescription in self.historyArray) {
    NSMutableAttributedString *number = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d) ", i]];
    [historyText appendAttributedString:number];
    [historyText appendAttributedString:historyDescription];
    [historyText appendAttributedString:newLine];
    i++;
  }
  
  self.historyTextView.attributedText = (NSAttributedString*)historyText;
}

@end
