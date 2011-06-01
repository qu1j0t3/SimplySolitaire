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

- (void)drawRect:(CGRect)r {
	CGRect r2 = [self bounds];
	int i;
	
	for(i = [faceDownDeck cards]; i--;){
		[Card drawFaceDownInRect:r2];
		r2 = CGRectOffset(r2, 0, 5);
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
	CGRect r2 = CGRectOffset([Card cardRectForWidth:CGRectGetWidth([self bounds])],
							 CGRectGetMinX([self frame]), CGRectGetMinY([self frame]));
	int i;

	for(i = [faceDownDeck cards]; i--;)
		r2 = CGRectOffset(r2, 0, 5);

	return [faceUpCards nextCardRect:r2];
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
	CardListNode *hitCardList = [faceUpCards hitTest:loc inRect:[self bounds]];

	if(hitCardList){
		draggableCard = [[DraggableCardView alloc] init];
		[draggableCard setDragCards:hitCardList];
		[self addSubview:draggableCard];
		[draggableCard touchesBegan:touches withEvent:evt];
		[self setNeedsDisplay];
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
