/* This file is part of SimplySolitaire, an iPhone/iPod application.
 * Copyright (C) 2011 Toby Thain <toby@telegraphics.com.au>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */

//  Created by Toby Thain on 5/16/11.

#import "DraggableCardView.h"
#import "GameView.h"

@implementation DraggableCardView

/*
- (id)initWithCoder:(NSCoder*)coder {
    if (self = [super initWithCoder:coder]) {
        // Initialization
    }
    return self;
}*/

- (CardView*)hitPile:(CGPoint)loc {
	if(CGRectContainsPoint(pile1Ctl.frame, loc))
		return pile1Ctl;
	else if(CGRectContainsPoint(pile2Ctl.frame, loc))
		return pile2Ctl;
	else if(CGRectContainsPoint(pile3Ctl.frame, loc))
		return pile3Ctl;
	else if(CGRectContainsPoint(pile4Ctl.frame, loc))
		return pile4Ctl;
	return nil;
}

- (CGAffineTransform)makeTransform:(CGPoint)touchPoint {
	return CGAffineTransformMake(1.4, 0, 0, 1.4,
								 touchPoint.x - self.center.x, 
								 touchPoint.y - self.center.y);
}

- (void)animateFirstTouchAt:(CGPoint)touchPoint {
    NSValue *touchPointValue = [[NSValue valueWithCGPoint:touchPoint] retain];
	
    [UIView beginAnimations:nil context:touchPointValue];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    self.transform = [self makeTransform:touchPoint];
	self.alpha = 0.66;
    [UIView commitAnimations];
}

- (void)dropCard:(Card*)c on:(CardView*)pile {
	[pile setCard:c];
	[mainCtlr dealCard:self];
}	
/*
- (void)animDidStop:(NSString*)animId finished:(NSNumber*)fin context:(void*)ctx {
	[self dropCard:dragCard on:targ];
}

- (void)animateDropAt:(CGPoint)touchPoint {
    NSValue *touchPointValue = [[NSValue valueWithCGPoint:touchPoint] retain];
	
    [UIView beginAnimations:nil context:touchPointValue];
    [UIView setAnimationDuration:1.2];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animDidStop:finished:context:)];
// FIXME: this transform isn't right
    self.transform = CGAffineTransformMake(1, 0, 0, 1,
										   targetPile.center.x - touchPoint.x, 
										   targetPile.center.y - touchPoint.y);
	self.alpha = 1;
    [UIView commitAnimations];
}*/

- (void)resetDrag {
	self.transform = CGAffineTransformIdentity;
	self.alpha = 1;
	[gameView highlightPile:nil];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)evt {
	UITouch *touch = [touches anyObject];

	if(card != nil){
		[self animateFirstTouchAt:[touch locationInView:gameView]];
	}
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)evt {
	UITouch *touch = [touches anyObject];
	CGPoint loc = [touch locationInView:gameView];
	CardView *target = [self hitPile:loc];

	self.transform = [self makeTransform:loc];
	if(target && ![target canDrop:card])
		target = nil;
	[gameView highlightPile:target];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)evt {
	UITouch *touch = [touches anyObject];
	CGPoint loc = [touch locationInView:gameView];
	targetPile = [self hitPile:loc];
	dragCard = [self card];
	
	if(targetPile && [targetPile canDrop:dragCard]){
		[self dropCard:dragCard on:targetPile];
		//[self animateDropAt:[touch locationInView:gameView]];
	}

	[self resetDrag];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)evt {
	[self resetDrag];
}

@end
