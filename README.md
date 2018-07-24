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
 
 ## What is the distribution of variables across the dataset?

### Attacking and Defending Houses
![pie_chart_attacking_house](https://user-images.githubusercontent.com/8938974/42578080-c96740a4-84f3-11e8-9882-51eccbbb7a1d.png)
* Out of 38 total battles, the houses of Stark and Lannister are the two that lead battles the most with each launching a total of 8
* Following them, Greyjoy launched the third most with 7
![defending_houses_and_oponents](https://user-images.githubusercontent.com/8938974/43089964-133fd770-8e74-11e8-924e-2177ccddb036.jpeg)
* The second graph graph dictates which houses have fought each other over the years 
* The second graph does not show the number of battles that were fought between each house

### Attacker House Battle Outcomes and Types
![outcomevstype](https://user-images.githubusercontent.com/8938974/43089100-d5e4667c-8e71-11e8-83a6-66702974c8c7.jpeg)
```{r } 
outcome_graph <- ggplot(battle_data, aes(attacker_1, fill=attacker_outcome)) +
  geom_histogram(stat="count", width=0.5) +
  labs(x="House", title="Battle Outcome of Attacking Houses") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

type_graph <- ggplot(battle_data, aes(attacker_1, fill=battle_type)) +
  geom_histogram(stat="count", width=0.5) +
  labs(x="House", title="Battle Types of Attacking Houses") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))

grid.arrange(outcome_graph, type_graph, ncol = 2)
```

* These two graphs show which attack types the different houses of Westeros used over the three years
* For example, the first graph shows that Baratheon used siege attack the most and Lannister used pitched battle the most
* The second graph shows which attack type was used the most overall in Westeros over all of the different houses

### Years of Battles
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

### Locations of Battles
![battle_locations_of_attackers](https://user-images.githubusercontent.com/8938974/43093825-2ca53646-8e7f-11e8-816d-8ab068d2c902.jpeg)
```{r }
ggplot(battle_data, aes(location, fill=attacker_1)) +
  geom_histogram(stat="count", width=0.5) +
  labs(x="Location", title="Battle Locations of Attacking Houses") +
  theme(axis.text.x = element_text(angle = 60, hjust = 1))
```
* Most of the houses who fought more than one battle in the three years also fought in more than one location (except for Baratheon who fought only in the region called Storm's End)

### Army Size In Relation To Battle Outcome
![sizeofarmiesvsattackeroutcome](https://user-images.githubusercontent.com/8938974/43091322-c4bc03fe-8e77-11e8-98e5-28c7fa891d7e.jpeg)
```{r }
ggplot(battle_data, aes(defender_size, attacker_size)) +
  geom_point(aes(color = attacker_outcome, shape = attacker_outcome), size = 4) +
  geom_smooth(method=lm , color="purple", se=TRUE) + 
  labs(x="Defender size", y="Attacker size", title="Size of Houses' Armies vs Attacker Outcome") 
```
* The purple regression line models the relationship between the size of the defender armies and the size of the attackers armies regardless of battle outcome
* The linear regression line shows a negative relation between defender army sizes and attacker army sizes 

![winsvsloses](https://user-images.githubusercontent.com/8938974/43087953-05908f02-8e6f-11e8-864e-2c09948ccf4f.jpeg)

```{r }
win <- subset(battle_data, attacker_outcome == "win")
lose <- subset(battle_data, attacker_outcome == "loss")

theme(plot.title = element_text(hjust = 0.5))
plot1 <- ggplot(win, aes(x = defender_size, y = attacker_size)) + 
           geom_point(shape = 18, size = 3) + 
           geom_smooth(method=lm , color="red", se=TRUE) + ggtitle("Wins") + 
           theme(plot.title = element_text(hjust = 0.5))
plot2 <- ggplot(lose, aes(x = defender_size, y = attacker_size)) + 
           geom_point(shape = 18, size = 3) + 
           geom_smooth(method=lm , color="red", se=TRUE) + ggtitle("Loses") + 
           theme(plot.title = element_text(hjust = 0.5))
           
grid.arrange(plot1, plot2, ncol=2)
```
* The red regression line models the relationship between the size of the defender armies and the size of the attackers armies in relation to battle outcome
* There is a positive relationship between the the size of the defender armies and the size of the attackers armies when the attacking house wins 
* There is a negative relationship between the size of the defender armies and the size of the attackers armies when the attacking house loses
* This shows that when the size of the attackering houses armies are smaller than that of the defending armies, the attacking houses tend to win

### Note:
* The confidence interval for both army size graphs are very large and sometimes the range of the values stretch far beyond the actual range of the values of the graph
* This could be because that although the points fit a general trend, they are quite varied
* In addition, the outliers/residual points differ from the "normal" points, or the other points which fit the general trend, by values reaching 10,000 (which is a lot)!
* According to Peters Rule of Thumb, there should be at least 10 observations per variable or covariate (which of course depends on the situation. There are only four points in the second army size graph labeled "Loss" so extrapolating an accurate linear regression line is difficult.
Krishna's edits coming...
