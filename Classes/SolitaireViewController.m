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

#import "SolitaireViewController.h"

#import "Deck.h"
#import "SolitaireGame.h"
#import "GameView.h"

@implementation SolitaireViewController

/* The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		// Custom initialization
    }
    return self;
}*/

// Actions
- (IBAction)dealCard:(id)sender {
	[dealtCardCtl setCard:[game dealCard] dealtFrom:deckCtl];
	[timerLabel setText:
		[NSString stringWithFormat:@"%d", [[game gameDeck] cards]]];
}

- (void)startGame {
	int i, j;

	game = [[SolitaireGame alloc] init];
	[game start];
	[self dealCard:nil];
	
	for(i = 0; i < 7; ++i){
		for(j = i; j--;)
			[[stacks[i] faceDownDeck] addCard:[game dealCard]];
		[stacks[i] addFaceUpCard:[game dealCard]];
		[stacks[i] setNeedsDisplay];
	}
}

- (Card*)takeDealt {
	return [game takeDealt];
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	stacks[0] = stack1; stacks[1] = stack2; stacks[2] = stack3;
	stacks[3] = stack4; stacks[4] = stack5; stacks[5] = stack6;
	stacks[6] = stack7;
}
/*
- (void)viewDidUnload {
 // Release any retained subviews of the main view.
 // e.g. self.myOutlet = nil;
}*/
 
- (void)dealloc {
	if(game) [game release];

	[super dealloc];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return interfaceOrientation == UIInterfaceOrientationLandscapeRight
		|| interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

@end
