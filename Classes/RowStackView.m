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

@implementation RowStackView

- (id)initWithCoder:(NSCoder*)coder {
	if(self = [super initWithCoder:coder]){
		faceDownDeck = [[Deck alloc] init];
	}
	return self;
}

- (Deck*)faceDownDeck {
	return faceDownDeck;
}

- (void)drawRect:(CGRect)r {
	CGRect r2 = [self bounds];
	CardListNode *c;
	int i;
	
	for(i = [faceDownDeck cards]; i--;){
		[Card drawFaceDownInRect:r2];
		r2 = CGRectOffset(r2, 0, 5);
	}
	for(c = stack; c; c = [c next]){
		[[c card] drawInRect:r2];
		r2 = CGRectOffset(r2, 0, 15);
	}
}

- (void)addFaceUpCard:(Card*)card {
	CardListNode *newCard = [[CardListNode alloc] init];

	[newCard setCard:card];

	// add to linked list as top card
	if(stack){
		[topCard setNext:newCard];
	}else{
		stack = newCard;
	}
	topCard = newCard;
}

- (CGRect)highlightRect {
	CGRect r2 = CGRectOffset([Card cardRectForWidth:CGRectGetWidth([self bounds])],
							 CGRectGetMinX([self frame]), CGRectGetMinY([self frame]));
	CardListNode *c;
	int i;

	for(i = [faceDownDeck cards]; i--;){
		r2 = CGRectOffset(r2, 0, 5);
	}
	for(c = stack; c; c = [c next]){
		r2 = CGRectOffset(r2, 0, 15);
	}
	return CGRectInset(r2, -6, -6);
}

- (bool)canDrop:(Card*)card {
	return (!stack && [card value] == 13)
		|| ([card value] == [[topCard card] value] - 1
			&& (([card suit] > 2) != ([[topCard card] suit] > 2)));
}

- (void)dropCard:(Card*)card {
	[self addFaceUpCard:card];
	[self setNeedsDisplay];
}

@end
