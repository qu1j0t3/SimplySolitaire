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

//  Created by Toby Thain on 5/12/11.

#import <UIKit/UIKit.h>

#import "CardView.h"
#import "Deck.h"
#import "RowStackView.h"

@class SolitaireGame;

@interface SolitaireViewController : UIViewController {
	SolitaireGame *game;
	IBOutlet CardView *deckCtl, *dealtCardCtl;
	IBOutlet UILabel *timerLabel;
	IBOutlet RowStackView *stack1, *stack2, *stack3, *stack4, *stack5, *stack6, *stack7;
	RowStackView *stacks[7];
}

- (IBAction)dealCard:(id)sender;
- (void)startGame;

@end

