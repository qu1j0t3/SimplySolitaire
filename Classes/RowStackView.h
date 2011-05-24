//
//  RowStackView.h
//  SimplySolitaire
//
//  Created by Toby Thain on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Deck.h"
#import "CardListNode.h"

@interface RowStackView : UIView {
	Deck *faceDownDeck;
	CardListNode *stack; // points to bottom face up card
}

- (Deck*)faceDownDeck;
- (void)addFaceUpCard:(Card*)card;

@end
