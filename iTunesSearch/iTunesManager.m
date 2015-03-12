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

@synthesize podcastArray,musicArray,movieArray,ebookArray,dataArray;

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


//- (NSArray *)buscarMidias:(NSString *)termo {
//    if (!termo) {
//        termo = @"";
//    }
//    //url do JSON
//    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all", termo];
//    //arquivo NSData que armazena o conteúdo do JSON gerado pelo iTunes
//    NSData *jsonData = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
//    
//    
//    NSError *error;
//    
//    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
//                                                              options:NSJSONReadingMutableContainers
//                                                                error:&error];
//    if (error) {
//        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
//        return nil;
//    }
//    
//    NSArray *resultados = [resultado objectForKey:@"results"];
//    NSMutableArray *filmes = [[NSMutableArray alloc] init];
//    
//    for (NSDictionary *item in resultados) {
//        Filme *filme = [[Filme alloc] init];
//        [filme setNome:[item objectForKey:@"trackName"]];
//        [filme setTrackId:[item objectForKey:@"trackId"]];
//        [filme setArtista:[item objectForKey:@"artistName"]];
//        [filme setDuracao: [item objectForKey:@"trackTimeMillis"]];
//        [filme setGenero:[item objectForKey:@"primaryGenreName"]];
//        [filme setPais:[item objectForKey:@"country"]];
//        [filme setPreco: [item objectForKey:@"trackPrice"]];
//        [filmes addObject:filme];
//    }
//    
//    return filmes;
//}

#pragma mark - Implementações exercicios

-(NSArray *) buscarMidias:(NSString *)termo
{
    
    NSLog(@"antes do dictionary");
    
    NSArray *resultados = [[self results:termo] objectForKey:@"results"];
    dataArray = [[NSMutableArray alloc]init];
    podcastArray = [[NSMutableArray alloc]init];
    musicArray = [[NSMutableArray alloc]init];
    ebookArray = [[NSMutableArray alloc]init];
    movieArray = [[NSMutableArray alloc]init];
    
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
        
        if([[item objectForKey:@"kind"]  isEqual: @"podcast"] )
            [podcastArray addObject: data];
        else if([[item objectForKey:@"kind"] isEqual: @"song"])
            [musicArray addObject:data];
        else if([[item objectForKey:@"kind"]isEqual:@"feature-movie"])
            [movieArray addObject: data];
        else if([[item objectForKey:@"kind"]isEqual:@"ebook"])
            [ebookArray addObject:data];
        
        
    }
    
    //um bloco que trata especificamente do caso do ebook que não está incluído em "all"
    
    NSArray *resultadosPodcast = [[self results: termo media:@"ebook"]objectForKey:@"results"];
    
    for(NSDictionary *item in resultadosPodcast)
    {
        
        Data *data = [[Data alloc]init];
        [data setName:[item objectForKey:@"artistName"]];
        [data setTitle:[item objectForKey: @"trackName"]];
        [data setPrice:[item objectForKey: @"price"]];
        [data setCurrency:[item objectForKey:@"currency"]];
        [data setMediaType:[item objectForKey:@"kind"]];
        [data setCountry:[item objectForKey:@"country"]];
        NSLog(@"%@", data.name);
        NSLog(@"%@", data.country);
        NSLog(@"%@", data.mediaType);
        
        [dataArray addObject: data];
        if([[item objectForKey:@"kind"]isEqual:@"ebook"])
            [ebookArray addObject:data];
    }
    
    
    NSLog(@"\n\n");
        return dataArray;
}


-(NSDictionary *)results:(NSString *)termo
{
    if(!termo)
    {
        termo = @"";
    }
    NSString *url = [NSString stringWithFormat: @"https://itunes.apple.com/search?term=%@&media=all", termo];
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
    return resultado;
}

//metodo sobrecarregado para buscar outras midias
//de algum modo ebook não vem em "all"
-(NSDictionary *) results:(NSString *)termo media:(NSString *)media
{
    if(!termo)
    {
        termo = @"";
    }
    NSString *url = [NSString stringWithFormat: @"https://itunes.apple.com/search?term=%@&media=%@", termo,media];
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
    
    return resultado;
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
