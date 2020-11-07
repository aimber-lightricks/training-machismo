//
//  SetCard.m
//  Machismo
//
//  Created by Ariel Imber on 04/11/2020.
//

#import "SetCard.h"
static const int SET_SCORE = 1;

@implementation SetCard

- (id) getAttributeFromNSString: (NSString *) attributeString {
  return [self valueForKey:attributeString];
}



- (BOOL)isSet: (NSArray *)otherCards forAttribute: (NSString *) attributeString {
  NSMutableSet * attributeSet = [[NSMutableSet alloc] init];
  [attributeSet addObject: [self getAttributeFromNSString:attributeString]];
  for (SetCard *otherCard in otherCards){
    [attributeSet addObject: [otherCard getAttributeFromNSString:attributeString]];
  }
  BOOL allTheSame = [ attributeSet count ] == 1;
  BOOL allDifferent = [ attributeSet count ] == [otherCards count] + 1;
  
  return allTheSame || allDifferent;
}


- (BOOL) isSet: (NSArray *) otherCards {
  for (NSString *attributeString in [SetCard validAttributeStrings]){
    if (![self isSet:otherCards forAttribute:attributeString]){
      return NO;
    }
  }
  return YES;
}

- (int)match:(NSArray *)otherCards{
  if (![self isSet:otherCards]) return 0;
  return SET_SCORE;
    
}

- (NSString *)contents{
  return nil;
}
@synthesize shape = _shape;

+ (NSArray*) validSahpes {
    return @[@"◼︎", @"▲", @"●"];
}

- (void)setShape:(NSString *) shape{
    if ([[SetCard validSahpes] containsObject:shape]){
        _shape = shape;
    }
}

- (NSString *)shape{
    return  _shape ? _shape : [[SetCard validSahpes] firstObject];
}

@synthesize color = _color;

+ (NSArray*) validColors {
    return @[@"red", @"blue", @"black"];
}

- (void)setColor:(NSString *)color{
    if ([[SetCard validColors] containsObject:color]){
        _color = color;
    }
}

- (NSString *)color{
    return  _color ? _color : [[SetCard validColors] firstObject];
}


@synthesize shading = _shading;

- (void)setShading:(NSNumber *)shading{
    if (([shading floatValue] < 1) && ([shading floatValue] > 0)){
        _shading = shading;
    }
}

- (NSNumber *)shading{
    return  _shading ? _shading : [NSNumber numberWithFloat:1];
}



+ (NSArray *) validAttributeStrings {
  return @[@"shape", @"color", @"shading"];
}

  
@end
