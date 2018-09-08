setwd('D:/RSession')

library(dplyr)
library(tidyr)
library(data.table)
library(readxl)

rm(list=ls())

# Read CSV data.
dat <- data.table::fread('comtrade_trade_data.csv')
head(dat)

CtyCodeDat <- readxl::read_xls('UN Comtrade Country List.xls',
                               sheet = 1, range = 'A1:I294') %>%
  dplyr::select(1, 2)


cleanDat <- dat %>%
  dplyr::select(1, 4, 9, 10) %>%
  left_join(., CtyCodeDat, by = c('Partner Code' = 'ctyCode')) %>%
  filter(`Partner Code` != 0) %>%
  dplyr::rename(Country = `cty Name English`,
                Quantity = `Netweight (kg)`) %>%
  mutate(Country = ifelse(Country %in% c('Brazil', 'Argentina', 'USA'),
                          Country, 'ROW')) %>%
  group_by(Country, Year) %>%
  summarise(Value = sum(Value), Quantity = sum(Quantity)) %>%
  mutate(Value = as.numeric(Value),
         Quantity = as.numeric(Quantity)) %>%
  arrange(Year)


ImportShare <- cleanDat %>%
  filter(Year >= 2014, Year <= 2016) %>%
  group_by(Year) %>%
  mutate(Total = sum(Value)) %>%
  mutate(Share = Value/Total) %>%
  group_by(Country) %>%
  summarise(Share = mean(Share))


library(ggplot2)
g1 <- ggplot(data = ImportShare) +
  geom_bar(mapping = aes(Country, Share), stat = 'identity')
g1



g2 <- ggplot(data = ImportShare) +
  geom_bar(mapping = aes(Country, 100*Share), stat = 'identity', col = 'black',
           fill = 'white', width = 0.8) +
  geom_text(mapping = aes(Country, 100*Share + 2,
                          label = paste0(round(100*Share, 0), '%'))) +
  labs(x = '', y = 'Import Share (%)',
       title = "Figure. China's import share of soybean in 2014-2016 by \n source country",
       subtitle = "Data source: UN Comtrade") +
  theme_classic() +
  scale_y_continuous(limits = c(0, 60)) +
  scale_x_discrete(limits = c('USA', 'Brazil', 'Argentina', 'ROW')) +
  theme(axis.text = element_text(color = 'black', size = 11),
        axis.title = element_text(color = 'black', size = 11))
g2



USBrazilImport <- filter(cleanDat, Country %in% c('Brazil', 'USA'))

g3 <-
  ggplot(data = USBrazilImport) +
  geom_line(mapping = aes(Year, Value/1000000000, color = Country), size = 1.2) +
  theme_classic() +
  labs(x = '', y = 'Import value, billion USD') +
  scale_color_manual(values = c('blue', 'purple')) +
  theme(legend.position = 'bottom',
        legend.title = element_blank())

g3



g4 <-
  ggplot(data = USBrazilImport) +
  geom_line(mapping = aes(Year, Value/1000000000), size = 1.2) +
  theme_classic() +
  labs(x = '', y = 'Import value, billion USD') +
  facet_wrap(~Country) +
  theme(legend.position = 'bottom',
        legend.title = element_blank())

g4


# Specify the domain.
x <- seq(0, 10, by = 0.01)

y1 <- 2*x + 1


# A linear function.
y1 <- sapply(x, function(i) 2*i + 1)   # y = 2x + 1
plot(x, y1, type = 'l', col = 'purple')

# A quadratic function.
y2 <- sapply(x, function(i) 2*i^2 - 4*i + 1)  # y = 2x^2 - 4x + 1
plot(x, y2, type = 'l', col = 'purple')

# A polynomial function.
y3 <- sapply(x, function(i) 2*i^4 - i^3 + 5*i - 5) # y = 2x^4 - x^3 + 5x - 5
plot(x, y3, type = 'l', col = 'purple')



# Plot all the functions in one graph.
plot(x, y1, type = 'l', main = 'Figure. Graph of functions',
     col = 'purple', lwd = 3, xlim = c(0, 10), ylim = c(-10, 50),
     xlab = 'x', ylab = 'y')
lines(x, y2, col = 'blue', lwd = 3)
lines(x, y3,  col = 'red', lwd = 3)

legend('topright', legend=c("Linear", "Quadratic", "Polynomial"),
       col=c("purple", "blue", 'red'),
       lwd = 3, cex = 0.8, ncol = 2, text.width = 1)


# Specify the domain
x <- seq(-5, 5, by = 0.01)

# Concave function
y1 <- sapply(x, function(i) -i^2+i+30)   # y = -x^2+x+30
plot(x, y1, type = 'l', col = 'purple', lwd = 3, xlab = 'x', ylab = 'y')
text(-3.5, 25, labels = 'y = -x^2 + x + 30', cex = 0.7)
