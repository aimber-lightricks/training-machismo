//
//  SetCardAttributedDescription.m
//  Machismo
//
//  Created by Ariel Imber on 08/11/2020.
//
#import "SetCardAttributedDescription.h"

#import <UIKit/UIKit.h>

#import "SetCard.h"

#define UIColorFromRGB(rgbValue, alphaValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                 blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                alpha:alphaValue]

@implementation SetCardAttributedDescription

- (NSAttributedString *)cardAttributedDescription{
  SetCard *setCard = (SetCard *)self.card;
  NSString *cardContent = setCard.shape;
  NSMutableAttributedString  *cardContentAttributed = [[NSMutableAttributedString alloc] initWithString:cardContent];
  UIColor *color = UIColorFromRGB([self colorNameToHex:setCard.color], [setCard.shading floatValue]);
  
  [cardContentAttributed addAttributes:@{NSForegroundColorAttributeName : color,
                                         
  }
                                range:NSMakeRange(0, [cardContent length])];
  
  return (NSAttributedString *)cardContentAttributed;

  
}

- (int)colorNameToHex:(NSString*)colorName {
  if ([colorName isEqualToString:@"red"]) return 0xFF0000;
  if ([colorName isEqualToString:@"green"]) return 0x008000;
  if ([colorName isEqualToString:@"blue"]) return 0x0000FF;
  if ([colorName isEqualToString:@"black"]) return 0x000000;

  return 0x000000; //black is the default
}


@end
