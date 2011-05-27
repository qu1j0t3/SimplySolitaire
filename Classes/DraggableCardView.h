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

#import <Foundation/Foundation.h>

#import "SolitaireViewController.h"
#import "SuitStackView.h"

@class GameView;

@interface DraggableCardView : CardView {
	IBOutlet SuitStackView *pile1Ctl, *pile2Ctl, *pile3Ctl, *pile4Ctl;
	IBOutlet RowStackView *stack1, *stack2, *stack3, *stack4, *stack5, *stack6, *stack7;
	IBOutlet GameView *gameView;
	IBOutlet SolitaireViewController *mainCtlr;
	// set after a successful drag; used by drop animation completion method
	StackView *targetPile;
	Card *dragCard;
	NSTimeInterval dragStart;
	CGPoint dragStartLoc;
	bool dragging;
}

@end
