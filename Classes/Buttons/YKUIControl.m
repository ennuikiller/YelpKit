//
//  YKUIControl.m
//  YelpKit
//
//  Created by Gabriel Handford on 10/27/09.
//  Copyright 2009 Yelp. All rights reserved.
//

#import "YKUIControl.h"

@implementation YKUIControl 

@synthesize target=_target, action=_action, highlightedEnabled=_highlightedEnabled, selectedEnabled=_selectedEnabled, layout=_layout, context=_context;

+ (void)removeAllTargets:(UIControl *)control {
  for (id target in [control allTargets]) {
    for (NSString *actionString in [control actionsForTarget:target forControlEvent:[control allControlEvents]]) {
      if (target == control) continue; // Skip self target so target/action still works
      [control removeTarget:target action:NSSelectorFromString(actionString) forControlEvents:[control allControlEvents]];
    }
  }
}

- (void)sharedInit { }

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self sharedInit];
  }
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self sharedInit];
  }
  return self;
}

- (void)removeAllTargets {
  [YKUIControl removeAllTargets:self];
}

+ (BOOL)touchesAllInView:(UIView *)view touches:(NSSet */*of UITouch*/)touches withEvent:(UIEvent *)event {
  // If any touch not in button, ignore
  for(UITouch *touch in touches) {
    CGPoint point = [touch locationInView:view];
    if (![view pointInside:point withEvent:event]) return NO;
  }
  return YES;
}

- (BOOL)touchesAllInView:(NSSet */*of UITouch*/)touches withEvent:(UIEvent *)event {
  return [YKUIControl touchesAllInView:self touches:touches withEvent:event];
}

- (void)setTarget:(id)target action:(SEL)action {
  [self setTarget:target action:action context:nil];
}

- (void)setTarget:(id)target action:(SEL)action context:(id)context {
  [self removeTarget:self action:@selector(_didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
  [self addTarget:self action:@selector(_didTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
  _target = target;
  _action = action;
  _context = context;
  _highlightedEnabled = YES;
}

- (void)_didTouchUpInside {
  [_target performSelector:_action withObject:(_context ? _context : self)];
  [self didTouchUpInside];
}

//
// Layout code duplicated in YKUILayoutView. If you add changes please apply them there as well.
//

#pragma mark Layout

- (void)layoutSubviews {
  [super layoutSubviews];
  YKLayoutAssert(self, _layout);
  if (_layout) {
    [_layout layoutSubviews:self.frame.size];
  }
}

- (CGSize)sizeThatFits:(CGSize)size {
  YKLayoutAssert(self, _layout);
  
  if (_layout) {
    return [_layout sizeThatFits:size];
  }
  return [super sizeThatFits:size];
}

- (void)setNeedsLayout {
  [super setNeedsLayout];
  [_layout setNeedsLayout];
}

- (void)layoutView {
  NSAssert(_layout, @"Missing layout instance");
  [_layout setNeedsLayout];
  [_layout layoutSubviews:self.frame.size];
}

#pragma mark Touches

- (void)didTouchUpInside { }

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {    
  if (_highlightedEnabled && self.userInteractionEnabled) {
    if (![self touchesAllInView:touches withEvent:event]) return; 
    self.highlighted = YES;
    [self setNeedsDisplay];
  } 
  [super touchesBegan:touches withEvent:event];
  if (_highlightedEnabled && self.userInteractionEnabled) {
    // Force runloop to redraw so highlighted control appears instantly; must come after call to super
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.1]];
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {  
  if (_selectedEnabled && [self touchesAllInView:touches withEvent:event] && self.userInteractionEnabled) {
    self.selected = !self.isSelected;
  }  
  
  [super touchesEnded:touches withEvent:event];
  
  if (_highlightedEnabled && self.userInteractionEnabled) {
    self.highlighted = NO;
    [self setNeedsDisplay];
  }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {  
  [super touchesCancelled:touches withEvent:event];
  if (_highlightedEnabled && self.userInteractionEnabled) {
    self.highlighted = NO;
    [self setNeedsDisplay];
  }  
}

@end