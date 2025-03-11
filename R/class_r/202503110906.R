library(ggplot2)

transp <-c("bicyle", "bus", "bus", "walking", "bus", "bicyle", "bicyle",
          "bus", "bus", "bus", "bicyle", "bus", "bicyle", "bicyle", "walking",
          "bus", "bus", "bicyle", "bicyle", "walking", "walking",
          "bicyle", "bus", "bus", "bus", "bus", "bicyle",
          "bus", "bus", "bicyle", "bicyle", "bicyle")
dat1 <-data.frame(transp)
library(forcats)

ggplot(data = dat1)+ geom_bar(mapping = aes(x=fct_infreq(transp))) + 
  xlab("Transpotation")

# Example2 
obseity <- factor(c("underweight", "normal", "overweight", "obese"),
                  levels=c("underweight", "normal", "overweight", "obese"))

count <- c(6, 69, 27, 13)
perc <- count/sum(count) * 100

# combine to visualize
dat2 <- data.frame(obseity, count, perc)
ggplot(data = dat2) + geom_bar(mapping = aes(x = obseity, y = perc), stat = "identity") +
  xlab("Obesity") + ylab("Percentage (%)")


# round graph 

table(transp)

dat3 <- data.frame(transportation = c("bus", "bicycle", "walking"),
                   count = c(15, 13, 4))
ggplot(data = dat3) + geom_bar(mapping = aes(x = "", y = count, fill = transportation), 
                               stat = "identity") +
  coord_polar("y", start = 0) + xlab("") + ylab("") +
  theme(axis.text = element_blank(),
        axis.ticks = element_blank(),
        panel.grid = element_blank())
