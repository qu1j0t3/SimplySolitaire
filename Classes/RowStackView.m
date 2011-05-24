//
//  RowStackView.m
//  SimplySolitaire
//
//  Created by Toby Thain on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
	CardListNode *c, *newCard = [[CardListNode alloc] init];

	[newCard setCard:card];

	// add to linked list as top card
	if(stack){
		// find top card
		for(c = stack; [c next]; c = [c next])
			;
		[c setNext:newCard];
	}else{
		stack = newCard;
	}
}

@end
