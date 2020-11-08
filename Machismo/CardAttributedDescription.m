//
//  CardAttributedDescription.m
//  Machismo
//
//  Created by Ariel Imber on 08/11/2020.
//

#import "CardAttributedDescription.h"

@interface CardAttributedDescription()

@end

@implementation CardAttributedDescription

-(instancetype)initWithCard:(Card *)card{
  self = [super init];
  if (self){
    self.card = card;
  }
  return self;
}

- (NSAttributedString *) cardAttributedDescription{
  return nil;
}

@end
