//
//  ViewController.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Data.h"

@interface TableViewController () {
    NSArray *midias;
    NSString *termo;
    NSString *tipoMidia;
    iTunesManager *itunes;
    NSString *mediaType;

}


@end



@implementation TableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    termo = @"Apple";
    mediaType = @"all";
    UINib *nib = [UINib nibWithNibName:@"TableViewCell" bundle:nil];
    [self.tableview registerNib:nib forCellReuseIdentifier:@"celulaPadrao"];
     NSLog(@" %@", termo);
    itunes = [iTunesManager sharedInstance];
    midias = [itunes buscarMidias:termo];
    
    
    
#warning Necessario para que a table view tenha um espaco em relacao ao topo, pois caso contrario o texto ficara atras da barra superior
  //self.tableview.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 20.0f, self.tableview.bounds.size.width, 60.0f)];
    
    

    
    
    
    
    
    /* HEADER VIEW */
    
//    UITextField *teste = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 200.0f, 25.0f)];
//    [teste setBackgroundColor:[UIColor whiteColor]];
    
//    [_tableview.tableHeaderView setBackgroundColor:[[UIColor redColor]colorWithAlphaComponent:0.5f]];
//    _tableview.tableHeaderView.layer.borderColor=[UIColor blackColor].CGColor;
//    _tableview.tableHeaderView.layer.borderWidth=1.0f;
//    
//    [_tableview addSubview: teste];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Metodos do UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [midias count] ;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[midias objectAtIndex:section]count];
        }

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
       if(section == 0)
           return @"podcast";
       else if (section ==1)
           return @"music";
       else if (section == 2)
           return @"movies";
       else if (section ==3)
           return @"ebook";
       else
           return @"all";
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Implementação de aula
     
//    TableViewCell *celula = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
//    
//    Filme *filme = [midias objectAtIndex:indexPath.row];
//    
//    [celula.nome setText:filme.nome];
//    [celula.tipo setText:@"Filme"];
//    [celula.pais setText: filme.pais];
//    //[celula.duracao setText:[NSString stringWithFormat:@"$: %@", filme.duracao]];
//    [celula.duracao setText: [NSString stringWithFormat:@"preco: %@", filme.preco]];
//
//    return celula;
//     
    
    //Minha implementação
        TableViewCell *cell = [self.tableview dequeueReusableCellWithIdentifier:@"celulaPadrao"];
    
        Data *data = [[midias objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    
        //uma flag que controla o conteudo selecionado na segment control
    
    
        NSLog(@"\n\n nome: %@", data.name);
        [cell.nome setText: data.title];
        [cell.tipo setText: data.mediaType];
        [cell.pais setText: data.country];
        [cell.duracao setText: [NSString stringWithFormat:@" %@: %@", data.currency,  data.price]];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_textField resignFirstResponder];
}


#pragma mark - implementações extras

- (IBAction)searchButton:(id)sender {
    termo = [[self textField]text];
    NSString *urlTerm = [termo stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    NSLog(@"texto: %@", [[self textField]text]);
    midias = [itunes buscarMidias:urlTerm];
    [_tableview reloadData];
    

}

-(IBAction)segControlClicked:(id)sender
{
    if (_segControl.selectedSegmentIndex == 0)
    {
        termo =[[self textField]text];
        [_tableview reloadData];
        
    }
    
    else
    if( _segControl.selectedSegmentIndex == 1)
    {
        
        termo =[[self textField]text];
        [_tableview reloadData];
        
    }
    else
    if(_segControl.selectedSegmentIndex == 2)
    {
        termo =[[self textField]text];
        [_tableview reloadData];
        
    }
    else
    if (_segControl.selectedSegmentIndex == 3)
    {

        termo =[[self textField]text];
        [_tableview reloadData];
        
    }
}



@end
