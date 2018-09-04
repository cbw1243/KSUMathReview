# Read CSV data.
dat <- data.table::fread('comtrade_trade_data.csv')
head(dat)


library(dplyr, warn.conflicts = FALSE)
library(tidyr, warn.conflicts = FALSE)

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
ImportShare


ImportCor <- cleanDat %>%
  select(-Quantity) %>%
  filter(Country %in% c('USA', 'Brazil')) %>%
  tidyr::spread(Country, Value)
cor(ImportCor$Brazil, ImportCor$USA)


ImportCorDif <- ImportCor %>%
  mutate(LagBrazil = lag(Brazil), LagUSA = lag(USA)) %>%
  mutate(USADif = USA - LagUSA, BrazilDif = Brazil - LagBrazil) %>%
  tidyr::drop_na()
cor(ImportCorDif$BrazilDif, ImportCorDif$USADif)







