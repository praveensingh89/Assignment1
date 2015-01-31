//
//  main.m
//  AnagramSample
//
//  Created by Abhijeet Shegokar on 30/01/15.
//  Copyright (c) 2015 Praveen singh. All rights reserved.
//

#import <Cocoa/Cocoa.h>


int main(int argc, char * argv[]) {
    

    // getting the file path
    NSString *path = [NSString stringWithUTF8String:argv[1]];
    NSString* contents =
    [NSString stringWithContentsOfFile:path
                              encoding:NSUTF8StringEncoding error:nil];
    
    // getting each word 
    NSArray* rawString =
    [contents componentsSeparatedByCharactersInSet:
     [NSCharacterSet newlineCharacterSet]];
    // getting the total count of words in the file
    NSUInteger countOfWords = [rawString count];
    NSMutableArray *orderedChar = [[NSMutableArray alloc] initWithArray:rawString];
    
    
    for(int i=0;i<countOfWords;i++ )
    {
        // gettig each word from the main raw string
        NSString *eachWord = [rawString objectAtIndex:(i)];
        NSMutableArray *charArrayToSort = [NSMutableArray arrayWithCapacity:eachWord.length];
        for (int i=0; i<eachWord.length; ++i) {
            NSString *charStr = [eachWord substringWithRange:NSMakeRange(i, 1)];
            [charArrayToSort addObject:charStr];
        }
        //sorting the char array
        [charArrayToSort sortUsingComparator:^(NSString *a, NSString *b){
            return [a compare:b];
        }];
        
        NSMutableString * result = [[NSMutableString alloc] init];
        for (NSObject * obj in charArrayToSort)
        {
            [result appendString:[obj description]];
        }
        [orderedChar replaceObjectAtIndex:i withObject:result];
        
    }
    
    NSMutableDictionary *tableDir = [[NSMutableDictionary alloc] initWithCapacity:countOfWords];
    
    for (int i=0; i<countOfWords; i++) {
        
        
        NSString *singleKey = [orderedChar objectAtIndex:i];
        if(i==0)
        {
            [tableDir setObject:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:i], nil] forKey:singleKey];
        }
        else
        {
            if([tableDir objectForKey:singleKey])
            {
                NSMutableArray *ref = tableDir[singleKey];
                [ref addObject:[NSNumber numberWithInt:i]];
                [tableDir setObject:ref forKey:singleKey];
                
            }
            else
            {
                [tableDir setObject:[[NSMutableArray alloc] initWithObjects:[NSNumber numberWithInt:i], nil] forKey:singleKey];
            }
            
        }
        
        
    }
    
    NSMutableString *largest_anagram = [[NSMutableString alloc] initWithString:@"test"];
    int bigOneIs=0;
    NSArray *keys=[tableDir allKeys];
    
    for(int i=1; i<[keys count]; i++)
    {
        
        if([[tableDir objectForKey:[keys objectAtIndex:i]] count]>bigOneIs)
        {
            bigOneIs=[[tableDir objectForKey:[keys objectAtIndex:i]] count];
            
            largest_anagram = [keys objectAtIndex:i];
        }
        
    }
    
    
    NSArray *biggestAnagram = [tableDir objectForKey:largest_anagram];
    NSLog(@"---numbers of anagrams present are : ---%d", [tableDir count]);

    NSLog(@"-----biggest anagram length is: ---%d",[biggestAnagram count]);
    //findind the word which forms biggest anagram
    for (int i=0; i<[biggestAnagram count]; i++) {
        NSLog(@"%@---The biggest anagram is:  ", [rawString objectAtIndex:[[biggestAnagram objectAtIndex:i] integerValue]]);
    }
    
    return 0;
}
