#If you experience errors, remember that you can search the internet and the RStudio community for help:
#https://community.rstudio.com/#

## Step 1: Load packages

#Start by installing the required packages. If you have already installed and loaded `tidyverse`, `skimr`, and `janitor` in this session, feel free to skip the code chunks in this step.


install.packages("tidyverse")
install.packages("skimr")
install.packages("janitor")


#Once a package is installed, you can load it by running the `library()` function with the package name inside the parentheses:

library(tidyverse)
library(skimr)
library(janitor)

## Step 2: Import data
#The data in this example is originally from the article Hotel Booking Demand Datasets (https://www.sciencedirect.com/science/article/pii/S2352340918315191), written by Nuno Antonio, Ana Almeida, and Luis Nunes for Data in Brief, Volume 22, February 2019.

#The data was downloaded and cleaned by Thomas Mock and Antoine Bichat for #TidyTuesday during the week of February 11th, 2020 (https://github.com/rfordatascience/tidytuesday/blob/master/data/2020/2020-02-11/readme.md).

# You can learn more about the dataset here:
# https://www.kaggle.com/jessemostipak/hotel-booking-demand

# In the chunk below, you will use the `read_csv()` function to import data from a .csv in the project folder called "hotel_bookings.csv" and save it as a data frame called `bookings_df`:


bookings_df <- read_csv("hotel_bookings.csv")

## Step 3: Getting to know your data

# Before you start cleaning your data, take some time to explore it. You can use several functions that you are already familiar with to preview your data, including the `head()` function in the code chunk below:


head(bookings_df)


# You can summarize or preview the data with the `str()` and `glimpse()` functions to get a better understanding of the data by running the code chunks below:


str(bookings_df)



glimpse(bookings_df)


# You can also use `colnames()` to check the names of the columns in your data set. Run the code chunk below to find out the column names in this data set:


colnames(bookings_df)


# Use the `skim_without_charts()` function from the `skimr` package by running the code below:


skim_without_charts(bookings_df)

## Step 4: Cleaning your data

# Based on your notes you are primarily interested in the following variables: hotel, is_canceled, lead_time. Create a new data frame with just those columns, calling it `trimmed_df`.

trimmed_df <- bookings_df %>% 
  select(hotel, is_canceled, lead_time)


# Rename the variable 'hotel' to be named 'hotel_type' to be crystal clear on what the data is about:


trimmed_df %>% 
  select(hotel, is_canceled, lead_time) %>% 
  rename(hotel_type = hotel)


# In this example, you can combine the arrival month and year into one column using the unite() function:


example_df <- bookings_df %>%
  select(arrival_date_year, arrival_date_month) %>% 
  unite(arrival_month_year, c("arrival_date_month", "arrival_date_year"), sep = " ")


## Step 5: Another way of doing things

# You can also use the`mutate()` function to make changes to your columns. Let's say you wanted to create a new column that summed up all the adults, children, and babies on a reservation for the total number of people. Modify the code chunk below to create that new column: 

example_df <- bookings_df %>%
  mutate(guests = adults + children + babies)

head(example_df)


# Great. Now it's time to calculate some summary statistics! Calculate the total number of canceled bookings and the average lead time for booking - you'll want to start your code after the %>% symbol. Make a column called 'number_canceled' to represent the total number of canceled bookings. Then, make a column called 'average_lead_time' to represent the average lead time. Use the `summarize()` function to do this in the code chunk below:


example_df <- bookings_df %>%
  summarize(number_canceled = sum(is_canceled),
            average_lead_time = mean(lead_time))

head(example_df)


# Manipulating your data

hotel_bookings <- bookings_df
# Let's say you want to arrange the data by most lead time to least lead time because you want to focus on bookings that were made far in advance. You decide you want to try using the `arrange()` function and run the following command: 

arrange(hotel_bookings, lead_time)


# `arrange()`  automatically orders by ascending order, and you need to specifically tell it when to order by descending order, like the below code chunk below:


arrange(hotel_bookings, desc(lead_time))

head(hotel_bookings)

hotel_bookings_v2 <-
  arrange(hotel_bookings, desc(lead_time))

head(hotel_bookings_v2)

max(hotel_bookings$lead_time)
min(hotel_bookings$lead_time)
mean(hotel_bookings$lead_time)
mean(hotel_bookings_v2$lead_time)

hotel_bookings_city <- 
  filter(hotel_bookings, hotel_bookings$hotel=="City Hotel")

head(hotel_bookings_city)

mean(hotel_bookings_city$lead_time)

hotel_summary <- 
  hotel_bookings %>%
  group_by(hotel) %>%
  summarise(average_lead_time=mean(lead_time),
            min_lead_time=min(lead_time),
            max_lead_time=max(lead_time))

head(hotel_summary)

average_lead_time_any <- mean(hotel_bookings$lead_time)
average_lead_time_any
