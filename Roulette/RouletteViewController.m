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
@property (weak, nonatomic) IBOutlet UITableView *bettingTableView;
@property (weak, nonatomic) IBOutlet UIPickerView *betPickerView;
@property (weak, nonatomic) IBOutlet UILabel *spinLabel;

@end

@implementation RouletteViewController


long row1, row2, row3, row4, row5, row6;
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
//    NSString *rn = [aBet betText];
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

NSLog (@"Winning Numbers %@", winningNumbers);
    long bc = self.bets.count;
    int qtyOfWinningNumbers = 0;
    long wTotal = 0;
    NSString *wn1 = [NSString stringWithFormat:@"-%ld-", (long)row1];
    NSString *wn2 = [NSString stringWithFormat:@"-%ld-", (long)row2];
    NSString *wn3 = [NSString stringWithFormat:@"-%ld-", (long)row3];
    NSString *wn4 = [NSString stringWithFormat:@"-%ld-", (long)row4];
    NSString *wn5 = [NSString stringWithFormat:@"-%ld-", (long)row5];
    NSString *wn6 = [NSString stringWithFormat:@"-%ld-", (long)row6];

NSLog (@"Total Betting Numbers %ld", bc);
NSLog (@"First Winning Number %@", wn1);
    
    for(int i = 0 ; i < bc ; i++){
        Bet *aBet2 = self.bets[i];
        NSString *rn = [aBet2 betText];
//        NSLog (@"Bet Number %ld,%@", i, rn);

        if ([rn rangeOfString:wn1].location == NSNotFound) {
        } else {
//            NSLog(@"string contains bla!");
            qtyOfWinningNumbers += 1;
        }
        if ([rn rangeOfString:wn2].location == NSNotFound) {
        } else {
            qtyOfWinningNumbers += 1;
        }
        if ([rn rangeOfString:wn3].location == NSNotFound) {
        } else {
            qtyOfWinningNumbers += 1;
        }
        if ([rn rangeOfString:wn4].location == NSNotFound) {
        } else {
            qtyOfWinningNumbers += 1;
        }
        if ([rn rangeOfString:wn5].location == NSNotFound) {
        } else {
            qtyOfWinningNumbers += 1;
        }
        if ([rn rangeOfString:wn6].location == NSNotFound) {
        } else {
            qtyOfWinningNumbers += 1;
        }

//NSLog (@"Qty %d", qtyOfWinningNumbers);

        long wBTotal = 0;
        if (qtyOfWinningNumbers==3){wBTotal=1.00;}
        if (qtyOfWinningNumbers==4){wBTotal=5.00;}
        if (qtyOfWinningNumbers==5){wBTotal=20.00;}
        if (qtyOfWinningNumbers==6){wBTotal=100.00;}
        qtyOfWinningNumbers = 0;
        wTotal = wTotal + wBTotal;
    }
    self.spinLabel.text=[NSString stringWithFormat:@"Total Winnings: US$%ld", wTotal];
}



- (IBAction)placeRandomBet:(UIButton *)sender
{
    [self.bets addObject:[[Bet alloc] initWithRandomBet]];
    [self.bettingTableView reloadData];
    self.spinLabel.text=@"Select the Winning Numbers Below";
    self.spinLabel.textColor = [UIColor whiteColor];
    self.spinLabel.backgroundColor = [UIColor blueColor];

}

@end













