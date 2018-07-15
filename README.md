# GameOfThronesAnalytics

### Acquiring the data
We acquired the dataset from the following website on Kaggle: https://www.kaggle.com/mylesoneill/game-of-thrones

battle_data <- read.csv("battles.csv", stringsAsFactors=FALSE)

### Modifying the dataset
* Changing the name "Brotherhood without the Banners" to just "Brotherhood" because the original name created awkward margin spacing in the charts and graphs. 
```{r }
battle_data$attacker_1[23] <- "Brotherhood"
```

* Changed all empty string values "" to NA in order to count the number of NA's in the dataset easier. There are built in functions to calculate how many NA values are in a dataframe, but not for empty strings. 
```{r }
battle_data[battle_data == ""] <- NA"
```

* The value for defender_1 was missing from the dataset because in the Sack of Saltpans, the town of Saltpans was being raided and no one was defending the town. This lack of data was cumbersome to deal with, especially in graph 3, because it leads to there being a missing value on the y-axis (the defenders_1 axis). Therefore, in order to deal with that issue, we had to add the Town of Saltpan as the defenders against the attackers: Brave Companions. 
```{r }
battle_data$defender_1[30] <- "Town of Saltpans"
```

* The value for attack_outcome was missing from the dataset on row 38. The attack outcome of the Siege of Winterfell was found on the wikipedia page for Game of Thrones. 
```{r }
battle_data$attacker_outcome[38] <- "loss"
```
 
### Missing values in the dataset
* Every value in the defender_3 and defender_4 columns is NA. Almost every value in the defender_2 column is NA. 
```{r}
> sum(is.na(battle_data$defender_2)) == nrow(battle_data)
[1] FALSE
> sum(is.na(battle_data$defender_3)) == nrow(battle_data)
[1] TRUE
> sum(is.na(battle_data$defender_4)) == nrow(battle_data)
[1] TRUE
```
* There were 19 different columns out of 25 which had more than one NA value. 
```{r}
for(i in 1:ncol(battle_data)) {
  if (any(is.na(battle_data[,i]))) {
    print(c(col_names[i], sum(is.na(battle_data[,i]))))
  }
}
[1] "attacker_king" "2"            
[1] "defender_king" "3"            
[1] "attacker_2" "28"        
[1] "attacker_3" "35"        
[1] "attacker_4" "36"        
[1] "defender_2" "36"        
[1] "defender_3" "38"        
[1] "defender_4" "38"        
[1] "battle_type" "1"          
[1] "major_death" "1"          
[1] "major_capture" "1"            
[1] "attacker_size" "14"           
[1] "defender_size" "19"           
[1] "attacker_commander" "1"                 
[1] "defender_commander" "10"                
[1] "summer" "1"     
[1] "location" "1"       
[1] "note" "33"  
```

### Analyzing by describing data 

These are the following categories used to describe the data along with their data type and examples of the data: 
```{r}
> str(battle_data)
'data.frame':	38 obs. of  25 variables:
 $ name              : chr  "Battle of the Golden Tooth" "Battle at the Mummer's Ford" "Battle of Riverrun" "Battle of the Green Fork" ...
 $ year              : int  298 298 298 298 298 298 298 299 299 299 ...
 $ battle_number     : int  1 2 3 4 5 6 7 8 9 10 ...
 $ attacker_king     : chr  "Joffrey/Tommen Baratheon" "Joffrey/Tommen Baratheon" "Joffrey/Tommen Baratheon" "Robb Stark" ...
 $ defender_king     : chr  "Robb Stark" "Robb Stark" "Robb Stark" "Joffrey/Tommen Baratheon" ...
 $ attacker_1        : chr  "Lannister" "Lannister" "Lannister" "Stark" ...
 $ attacker_2        : chr  "" "" "" "" ...
 $ attacker_3        : chr  "" "" "" "" ...
 $ attacker_4        : chr  "" "" "" "" ...
 $ defender_1        : chr  "Tully" "Baratheon" "Tully" "Lannister" ...
 $ defender_2        : chr  "" "" "" "" ...
 $ defender_3        : logi  NA NA NA NA NA NA ...
 $ defender_4        : logi  NA NA NA NA NA NA ...
 $ attacker_outcome  : chr  "win" "win" "win" "loss" ...
 $ battle_type       : chr  "pitched battle" "ambush" "pitched battle" "pitched battle" ...
 $ major_death       : int  1 1 0 1 1 0 0 0 0 0 ...
 $ major_capture     : int  0 0 1 1 1 0 0 0 0 0 ...
 $ attacker_size     : int  15000 NA 15000 18000 1875 6000 NA NA 1000 264 ...
 $ defender_size     : int  4000 120 10000 20000 6000 12625 NA NA NA NA ...
 $ attacker_commander: chr  "Jaime Lannister" "Gregor Clegane" "Jaime Lannister, Andros Brax" "Roose Bolton, Wylis Manderly, Medger Cerwyn, Harrion Karstark, Halys Hornwood" ...
 $ defender_commander: chr  "Clement Piper, Vance" "Beric Dondarrion" "Edmure Tully, Tytos Blackwood" "Tywin Lannister, Gregor Clegane, Kevan Lannister, Addam Marbrand" ...
 $ summer            : int  1 1 1 1 1 1 1 1 1 1 ...
 $ location          : chr  "Golden Tooth" "Mummer's Ford" "Riverrun" "Green Fork" ...
 $ region            : chr  "The Westerlands" "The Riverlands" "The Riverlands" "The Riverlands" ...
 $ note              : chr  "" "" "" "" ...
 ```
 
 Note: the defenders_3 and defenders_4 column are full of NA values and are thus labeled as having a logical datatype. 
 
 What is the distribution of variables across the dataset?

![pie_chart_attacking_house](https://user-images.githubusercontent.com/8938974/42578080-c96740a4-84f3-11e8-9882-51eccbbb7a1d.png)
![rplot](https://user-images.githubusercontent.com/8938974/42729540-58cc2fa4-87a9-11e8-9f0f-c3da6d49d40e.jpeg)
```{r }
ggplot(battle_data, aes(attacker_1, fill=attacker_outcome)) +
  geom_histogram(stat="count", width=0.5) +
  labs(x="House", title="Battle Outcome of Attacking Houses") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
```

![attacker_pie-3](https://user-images.githubusercontent.com/8938974/42729836-4a7e5742-87b3-11e8-99e2-22ebc55683c8.png)

* A total of 38 battles were fought between the years of 298-300
```{r} 
> years_fought <- unique(battle_data$year)
> years_fought
[1] 298 299 300 
> total_attacks <- nrow(battle_data) - sum(is.na(battle_data$attacker_1))
> total_attacks
[1] 38
```

* Out of 38 total battles, the houses of Stark and Lannister are the two that lead battles the most with each launching a total of 8
* Following them, Greyjoy launched the third most with 7

![plot 1-5](https://user-images.githubusercontent.com/8938974/42580828-6aa633da-84f9-11e8-82ab-f6bbcf13bb39.png)

* This graph dictates which houses have fought each other over the years 
* This graph does not show the number of battles that were fought between each house



