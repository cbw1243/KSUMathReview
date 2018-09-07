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