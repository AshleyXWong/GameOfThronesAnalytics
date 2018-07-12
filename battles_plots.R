library(ggplot2)
library(plotly)

battle_data <- read.csv("battles.csv", stringsAsFactors=FALSE)
battle_data$attacker_1[23] <- "Brotherhood"
battle_data$defender_1[30] <- "Town of Saltpans"
battle_data[battle_data == ""] <- NA

attacker_main <- unique(battle_data$attacker_1)
col_names <- names(battle_data)

attacker_freq <- vector('character')
for(i in 1:length(attacker_main)) {
  freq <- sum(battle_data$attacker_1 == attacker_main[i])
  attacker_freq <- c(attacker_freq, freq)
}

for(i in 1:ncol(battle_data)) {
  if (any(is.na(battle_data[,i]))) {
    print(c(col_names[i], sum(is.na(battle_data[,i]))))
  }
}

png("main_attackers.png", width=720, height=480)
pie(as.numeric(attacker_freq), labels = attacker_main, main = "Who Attacks in Game of Thrones?")
dev.off()

#barplot(table(battle_data$attacker_1), main="Who Attacks in Game of Thrones", horiz=TRUE,
#        names.arg=attacker_main, cex.names=0.8)

p <- plot_ly(x = attacker_freq, y = attacker_main, 
             type = 'bar', orientation = 'h') %>% layout(xaxis = list(range=c(0,8)))
print(p)
