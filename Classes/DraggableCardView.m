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

- (StackView*)hitPile:(CGPoint)loc {
	if(CGRectContainsPoint(pile1Ctl.frame, loc)) return pile1Ctl;
	else if(CGRectContainsPoint(pile2Ctl.frame, loc)) return pile2Ctl;
	else if(CGRectContainsPoint(pile3Ctl.frame, loc)) return pile3Ctl;
	else if(CGRectContainsPoint(pile4Ctl.frame, loc)) return pile4Ctl;
	else if(CGRectContainsPoint(stack1.frame, loc)) return stack1;
	else if(CGRectContainsPoint(stack2.frame, loc)) return stack2;
	else if(CGRectContainsPoint(stack3.frame, loc)) return stack3;
	else if(CGRectContainsPoint(stack4.frame, loc)) return stack4;
	else if(CGRectContainsPoint(stack5.frame, loc)) return stack5;
	else if(CGRectContainsPoint(stack6.frame, loc)) return stack6;
	else if(CGRectContainsPoint(stack7.frame, loc)) return stack7;
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

- (void)dropCard:(Card*)c on:(StackView*)pile {
	[pile dropCard:c];
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
	dragging = false;
	self.transform = CGAffineTransformIdentity;
	self.alpha = 1;
	[gameView highlightPile:nil];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)evt {
	UITouch *touch = [touches anyObject];
	CGPoint loc = [touch locationInView:gameView];
	
	if(card != nil){
		dragStart = evt.timestamp;
		dragStartLoc = loc;
		[self animateFirstTouchAt:loc];
		dragging = true;
	}
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)evt {
	if(dragging){
		UITouch *touch = [touches anyObject];
		CGPoint loc = [touch locationInView:gameView];
		StackView *target = [self hitPile:loc];

		self.transform = [self makeTransform:loc];
		if(target && ![target canDrop:card])
			target = nil;
		[gameView highlightPile:target];
	}
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)evt {
	if(dragging){
		UITouch *touch = [touches anyObject];
		CGPoint loc = [touch locationInView:gameView];
		targetPile = [self hitPile:loc];
		dragCard = [self card];
		CGFloat dx = loc.x - dragStartLoc.x,
				dy = loc.y - dragStartLoc.y;
		
		// was it dropped directly on a card?
		if(targetPile && [targetPile canDrop:dragCard]){
			[gameView highlightPile:nil]; // reset here, because in row stacks, rectangle changes when card added
			[self dropCard:dragCard on:targetPile];
			//[self animateDropAt:[touch locationInView:gameView]];
		} // or was it a 'toss'?
		else if((evt.timestamp - dragStart) < .4 && (dx*dx + dy*dy) > 50*50){
			// work out toss direction; is it within a certain angle range, and to the right?
			if(fabs(atan2(dy, dx)) < .25 && dx > 0){ // .25 radians = ~ 14 degrees +/- horizontal
				// find the closest suitable pile
				if([pile1Ctl canDrop:dragCard])
					targetPile = pile1Ctl;
				else if([pile2Ctl canDrop:dragCard])
					targetPile = pile2Ctl;
				else if([pile3Ctl canDrop:dragCard])
					targetPile = pile3Ctl;
				else if([pile4Ctl canDrop:dragCard])
					targetPile = pile4Ctl;
				else
					targetPile = nil;

				if(targetPile)
					[self dropCard:dragCard on:targetPile];
			}
		}

		[self resetDrag];
	}
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)evt {
	if(dragging)
		[self resetDrag];
}

@end
