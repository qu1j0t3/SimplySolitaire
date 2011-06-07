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

//  Created by Toby Thain on 5/23/11.

#import "RowStackView.h"
#import "DraggableCardView.h"

@implementation RowStackView

@synthesize faceDownDeck;
@synthesize draggableCard;

// the vertical distance between face-down cards in the row stack
#define FACEDOWN_OFFSET 5

- (id)initWithCoder:(NSCoder*)coder {
	if(self = [super initWithCoder:coder]){
		faceDownDeck = [[Deck alloc] init];
	}
	return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event {
	// default returns YES if point is in bounds
	// recursively calls -pointInside:withEvent:. point is in frame coordinates
	return [faceUpCards hitTest:point inRect:[self bounds]] != nil;
}

- (CGRect)topCardRectFor:(CGRect)r {
	return CGRectOffset([Card cardRectForWidth:CGRectGetWidth([self bounds])],
						CGRectGetMinX(r), CGRectGetMinY(r));
}

- (void)drawRect:(CGRect)r {
	CGRect r2 = [self topCardRectFor:[self bounds]];
	int i;
	
	for(i = [faceDownDeck cards]; i--;){
		[Card drawFaceDownInRect:r2];
		r2 = CGRectOffset(r2, 0, FACEDOWN_OFFSET);
	}

	// if draggableCard is set, then only cards UNDER it will be drawn. This causes the dragged
	// cards to "disappear" from the row stack during dragging.
	[faceUpCards drawInRect:r2 cardsUnder:[draggableCard dragCards]];
}

- (void)addFaceUpCard:(Card*)card {
	CardListNode *newCard = [[CardListNode alloc] init];

	[newCard setCard:card];

	// add to linked list as top card
	if(faceUpCards)
		[topCard setNext:newCard];
	else
		faceUpCards = newCard;

	topCard = newCard;
}

- (CGRect)highlightRect {
	return [faceUpCards nextCardRect:
				CGRectOffset([self topCardRectFor:[self frame]],
							 0, [faceDownDeck cards]*FACEDOWN_OFFSET)];
}

// return whether the given card can be dropped on this stack, according to game rules
- (bool)canDrop:(Card*)card {
	return (!faceUpCards && [card value] == 13)
		|| ([card value] == [[topCard card] value] - 1
			&& (([card suit] > 2) != ([[topCard card] suit] > 2)));
}

- (void)dropCard:(Card*)card {
	[self addFaceUpCard:card];
	[self setNeedsDisplay];
}

// delegate touch handling to a new instance of DraggableCardView

- (void)resetDrag {
	if(draggableCard)
		[draggableCard removeFromSuperview];
	draggableCard = nil;
	[self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)evt {
	UITouch *touch = [touches anyObject];
	CGPoint loc = [touch locationInView:self];
	CGRect r2 = CGRectOffset([self topCardRectFor:[self bounds]],
							 0, [faceDownDeck cards]*FACEDOWN_OFFSET);
	CardListNode *hitCardList = [faceUpCards hitTest:loc inRect:r2];

	if(hitCardList){
		CGRect dragFrame = CGRectOffset([self topCardRectFor:[self frame]],
										0, [faceDownDeck cards]*FACEDOWN_OFFSET);
		draggableCard = [[DraggableCardView alloc] initWithFrame:dragFrame];
		[draggableCard setOpaque:NO];
		[draggableCard setDragCards:hitCardList];
		[gameView addSubview:draggableCard];
		[draggableCard touchesBegan:touches withEvent:evt];
		[self setNeedsDisplay]; // to hide the cards that are being dragged
	}
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)evt {
	if(draggableCard)
		[draggableCard touchesMoved:touches withEvent:evt];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)evt {
	if(draggableCard)
		[draggableCard touchesEnded:touches withEvent:evt];
	[self resetDrag];
}

- (void)touchesCancelled:(NSSet*)touches withEvent:(UIEvent*)evt {
	if(draggableCard)
		[draggableCard touchesCancelled:touches withEvent:evt];
	[self resetDrag];
}

@end
