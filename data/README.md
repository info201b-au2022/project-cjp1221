# The `\data` Directory: Project Data Summary

In our project, we use the following data files and Application Programming Interfaces:

## Data files (TODO: Update/delete for your PROJECT)
|Data File Name | Brief Description|
|---------------| -----------------|
|[SDOT_collisions](./SDOT_collisions.csv) | This file is our primary data source as it contains:
|[SDOT_other](./SDOT_other.csv) | Same as the SDOT_collisions dataframe but containing the longitude and latitude data
|[SDOT_collisions_lat_long](./SDOT_collisions_lat_long.csv) | Made by joining SDOT_collisions with SDOT_other, adding latitude and longitude data to SDOT_collisions, and removing unused files for storage.
|[seattleWeather_1948-2017](./seattleWeather_1948-2017.csv) | Contains whether it rained, how much it rained, the maximum and minimum temperatures and the date for every day from 1948-2017.

## Application Programming Interfaces (API) (TODO: Update/delete for your PROJECT)

* **New York Times Books API**. The _New York Times_ provides data for Best
Sellers lists and the books that have been reviewed in the New York Times. An overview of the API that we use in our project is available here: [Books API](https://developer.nytimes.com/docs/books-product/1/overview). For more about developing apps with New York Times data see: [NYTimes Developers](https://developer.nytimes.com/).

# Developer notes: About the `/data` Directory (TODO: Read and delete this section)

* Use the `/data` directory to store any data that you using in your project (for example, CSV files)
* Edit this `README.md` file and summarize your data files
* If you are using APIs to access data, summarize them, providing specific information
* See examples above.
* Please remember your audience (prospective employers, open source colleagues, TAs, Instructors). Therefore,
aim for clarity and conciseness.
* When done, be sure to delete these NOTE sections and the example CSV file (which are intended for you, of course, not your audience!)
