//
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Filme.h"
#import "Data.h"
@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    //url do JSON
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
    //arquivo NSData que armazena o conteúdo do JSON gerado pelo iTunes
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    
    NSError *error;
    
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *filmes = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in resultados) {
        Filme *filme = [[Filme alloc] init];
        [filme setNome:[item objectForKey:@"trackName"]];
        [filme setTrackId:[item objectForKey:@"trackId"]];
        [filme setArtista:[item objectForKey:@"artistName"]];
        [filme setDuracao: [item objectForKey:@"trackTimeMillis"]];
        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
        [filme setPais:[item objectForKey:@"country"]];
        [filme setPreco: [item objectForKey:@"trackPrice"]];
        [filmes addObject:filme];
    }
    
    return filmes;
}

#pragma mark - Implementações exercicios

-(NSArray *) buscarMidias:(NSString *)termo midia:(NSString *)midia
{
    if(!termo && !midia)
    {
        
        termo = @"";
        midia = @"";
    }
    NSString *url = [NSString stringWithFormat: @"https://itunes.apple.com/search?term=%@&media=%@", termo, midia];
    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
    
    NSError *error;
    NSLog(@"erro parse resultado");
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if(error)
    {
        NSLog(@"Erro: %@", error);
        return nil;
    }
    
    NSLog(@"antes do dictionary");
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
    
    for(NSDictionary *item in resultados)
    {
        
        Data *data = [[Data alloc]init];
        [data setName:[item objectForKey:@"artistName"]];
        [data setTitle:[item objectForKey: @"trackName"]];
        [data setPrice:[item objectForKey: @"trackPrice"]];
        [data setCurrency:[item objectForKey:@"currency"]];
        [data setMediaType:[item objectForKey:@"kind"]];
        [data setCountry:[item objectForKey:@"country"]];
        NSLog(@"%@", data.name);
        NSLog(@"%@", data.country);
        NSLog(@"%@", data.mediaType);
        [dataArray addObject: data];
        
        
    }
    NSLog(@"\n\n");
        return dataArray;
}






#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
