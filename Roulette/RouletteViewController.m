//
//  ViewController.m
//  Roulette
//
//  Created by Joben Gohlke on 11/28/16.
//  Copyright © 2016 The Iron Yard. All rights reserved.
//

#import "RouletteViewController.h"
#import "Bet.h"

@interface RouletteViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSMutableArray *bets;
@property (nonatomic) NSString *winningNumbers;
@property (nonatomic) long row1, row2, row3, row4, row5, row6;
@property (nonatomic) NSString *row1r, *row2r, *row3r, *row4r, *row5r, *row6r;
@property (weak, nonatomic) IBOutlet UITableView *bettingTableView;
@property (weak, nonatomic) IBOutlet UIPickerView *betPickerView;
@property (weak, nonatomic) IBOutlet UILabel *spinLabel;

@end

@implementation RouletteViewController


long row1, row2, row3, row4, row5, row6;
NSString *row1r, *row2r, *row3r, *row4r, *row5r, *row6r;
NSString *winningNumbers=@"";


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.bets = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
        return 53;
}

#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *returnString = nil;
    returnString = [NSString stringWithFormat:@"%ld", (long)row + 1];
    return returnString;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BetCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    Bet *aBet = self.bets[indexPath.row];
    cell.textLabel.text = [aBet betText];
    NSString *rn = [aBet betText];
    if ([self.row1r length]==0) {self.row1r = [rn stringByAppendingString:@"-"];
        self.row1r = [@"-" stringByAppendingString:rn];
    }
    if ([self.row2r length]==0) {self.row2r = [rn stringByAppendingString:@"-"];
        self.row2r = [@"-" stringByAppendingString:rn];}
    if ([self.row3r length]==0) {self.row3r = [rn stringByAppendingString:@"-"];
        self.row3r = [@"-" stringByAppendingString:rn];}
    if ([self.row4r length]==0) {self.row4r = [rn stringByAppendingString:@"-"];
    self.row4r = [@"-" stringByAppendingString:rn];}
    if ([self.row5r length]==0) {self.row5r = [rn stringByAppendingString:@"-"];
        self.row5r = [@"-" stringByAppendingString:rn];}
    if ([self.row6r length]==0) {self.row6r = [rn stringByAppendingString:@"-"];
        self.row6r = [@"-" stringByAppendingString:rn];}
    return cell;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    row1 = [pickerView selectedRowInComponent:0] +1;
    row2 = [pickerView selectedRowInComponent:1] +1;
    row3 = [pickerView selectedRowInComponent:2] +1;
    row4 = [pickerView selectedRowInComponent:3] +1;
    row5 = [pickerView selectedRowInComponent:4] +1;
    row6 = [pickerView selectedRowInComponent:5] +1;
    
    winningNumbers = [NSString stringWithFormat:@"-%ld-%ld-%ld-%ld-%ld-%ld-", (long)row1, (long)row2, (long)row3, (long)row4, (long)row5, (long)row6];

//NSLog (@"??? %@", winningNumbers);
    self.spinLabel.text=[@"Winning Numbers are: " stringByAppendingString:winningNumbers];
    self.spinLabel.textColor = [UIColor whiteColor];
    self.spinLabel.backgroundColor = [UIColor redColor];
}

#pragma mark - Action handlers

- (IBAction)checkWinningNumbers:(UIButton *)sender
{

// NSLog(@"Row2: %ld", row2);
// NSLog(@"Row3: %ld", row3);
// NSLog(@"Row4: %ld", row4);
// NSLog(@"Row5: %ld", row5);
// NSLog(@"Row6: %ld", row6);

    NSString *wn1 = [NSString stringWithFormat:@"-%ld-", (long)row1];
    NSString *wn2 = [NSString stringWithFormat:@"-%ld-", (long)row2];
    NSString *wn3 = [NSString stringWithFormat:@"-%ld-", (long)row3];
    NSString *wn4 = [NSString stringWithFormat:@"-%ld-", (long)row4];
    NSString *wn5 = [NSString stringWithFormat:@"-%ld-", (long)row5];
    NSString *wn6 = [NSString stringWithFormat:@"-%ld-", (long)row6];
    
//    NSLog(@"WN1: %@", wn1);
//    NSLog(@"WN2: %@", wn2);
//    NSLog(@"WN3: %@", wn3);
//    NSLog(@"WN4: %@", wn4);
//    NSLog(@"WN5: %@", wn5);
//    NSLog(@"WN6: %@", wn6);

    NSUInteger i=0, wTotal1=0;
    if ([self.row1r length]>0) {
        if ([self.row1r containsString:wn1]) { i=i+1;}
        if ([self.row1r containsString:wn2]) { i=i+1;}
        if ([self.row1r containsString:wn3]) { i=i+1;}
        if ([self.row1r containsString:wn4]) { i=i+1;}
        if ([self.row1r containsString:wn5]) { i=i+1;}
        if ([self.row1r containsString:wn6]) { i=i+1;}
    }
    if (i==3){wTotal1=1.00;}
    if (i==4){wTotal1=5.00;}
    if (i==5){wTotal1=20.00;}
    if (i==6){wTotal1=100.00;}
//    NSString *wnT1=[NSString stringWithFormat:@"Bet1 Wins: %ld", wTotal1];
    NSUInteger ii=0, wTotal2=0;
    if ([self.row2r length]>0) {
        if ([self.row2r containsString:wn1]) { ii=ii+1;}
        if ([self.row2r containsString:wn2]) { ii=ii+1;}
        if ([self.row2r containsString:wn3]) { ii=ii+1;}
        if ([self.row2r containsString:wn4]) { ii=ii+1;}
        if ([self.row2r containsString:wn5]) { ii=ii+1;}
        if ([self.row2r containsString:wn6]) { ii=ii+1;}
    }
    if (ii==3){wTotal2=1.00;}
    if (ii==4){wTotal2=5.00;}
    if (ii==5){wTotal2=20.00;}
    if (ii==6){wTotal2=100.00;}
//    NSString *wnT2=[NSString stringWithFormat:@"Bet2 Wins: %ld", wTotal2];
    NSUInteger iii=0, wTotal3=0;
    if ([self.row3r length]>0) {
        if ([self.row3r containsString:wn1]) { iii=iii+1;}
        if ([self.row3r containsString:wn2]) { iii=iii+1;}
        if ([self.row3r containsString:wn3]) { iii=iii+1;}
        if ([self.row3r containsString:wn4]) { iii=iii+1;}
        if ([self.row3r containsString:wn5]) { iii=iii+1;}
        if ([self.row3r containsString:wn6]) { iii=iii+1;}
    }
    if (iii==3){wTotal3=1.00;}
    if (iii==4){wTotal3=5.00;}
    if (iii==5){wTotal3=20.00;}
    if (iii==6){wTotal3=100.00;}
//    NSString *wnT3=[NSString stringWithFormat:@"Bet3 Wins: %ld", wTotal3];
    // etc .....for subsequent bets
//    NSUInteger wTotal=(wTotal1+wTotal2+wTotal3);
//    NSString *wn = [NSString stringWithFormat:@"You Win %ld Dollars!", wTotal];
    NSString *wn = [NSString stringWithFormat:@"You Win %ld Dollars!", wTotal1];

    //   wn=[wn stringByAppendingString:@" Dollar(s)!"];
//   NSLog(@"%@", wn);


//    NSLog(@"Winning Numbers: %@", winningNumbers);
//    NSLog(@"row1r: %@", self.row1r);
//    NSLog(@"row2r: %@", self.row2r);
//    NSLog(@"row3r: %@", self.row3r);
    
    self.spinLabel.text=wn;
}

- (IBAction)placeRandomBet:(UIButton *)sender
{
    // These two lines are logically equivalent to the combined line at 91
//    Bet *aBet = [[Bet alloc] initWithRandomBet];
//    [self.bets addObject:aBet];
    
    [self.bets addObject:[[Bet alloc] initWithRandomBet]];    
    [self.bettingTableView reloadData];

    
    self.spinLabel.text=@"Select the Winning Numbers Below";
    self.spinLabel.textColor = [UIColor whiteColor];
    self.spinLabel.backgroundColor = [UIColor blueColor];

}



/*
    - (IBAction)spinWheel:(UIBarButtonItem *)sender
    {
        Bet *winningBet = [[Bet alloc] initWithRandomBet];
        //    Bet *winningBet = [[Bet alloc] initWithColor:@"red" andNumber:12];
        self.spinLabel.text = [winningBet betText];
        
        for (Bet *aBet in self.bets)
        {
            BOOL winningState = [aBet compare:winningBet];
            aBet.winner = winningState;
        }
        [self.bettingTableView reloadData];
    }
*/

@end













