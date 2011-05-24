//
//  CardStackView.h
//  SimplySolitaire
//
//  Created by Toby Thain on 5/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface CardListNode : NSObject {
	Card *card;
	CardListNode *next; // points to card on top of this one
}

@property (nonatomic, retain) Card *card;
@property (nonatomic, retain) CardListNode *next;

@end
