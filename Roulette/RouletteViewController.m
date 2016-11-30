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

    winningNumbers = [NSString stringWithFormat:@"%ld-%ld-%ld-%ld-%ld-%ld", (long)row1, (long)row2, (long)row3, (long)row4, (long)row5, (long)row6];

//NSLog (@"??? %@", winningNumbers);
    self.spinLabel.text=[@"Winning Numbers are: " stringByAppendingString:winningNumbers];
    self.spinLabel.textColor = [UIColor whiteColor];
    self.spinLabel.backgroundColor = [UIColor redColor];
}

#pragma mark - Action handlers

- (IBAction)placeBet:(UIButton *)sender
{
 NSLog(@"Row1: %@", winningNumbers);
 NSLog(@"Row1: %ld", row1);
 NSLog(@"Row2: %ld", row2);
 NSLog(@"Row3: %ld", row3);
 NSLog(@"Row4: %ld", row4);
 NSLog(@"Row5: %ld", row5);
 NSLog(@"Row6: %ld", row6);
        
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

- (IBAction)spinWheel:(UIBarButtonItem *)sender
{
    
}

@end













