//
//  PlayingCardAttributedDescriptio.m
//  Machismo
//
//  Created by Ariel Imber on 08/11/2020.
//

#import "PlayingCardAttributedDescription.h"

@implementation PlayingCardAttributedDescription

- (NSAttributedString *)cardAttributedDescription{
  NSAttributedString * attributedString = [[NSAttributedString alloc] initWithString:self.card.contents];
  return attributedString;
}

@end
