# Racing_Database

## Overview

This project is designed to manage and store data for various racing events, including information about races, series, tracks, teams, drivers, pit stops, and weather conditions. The database aims to provide an efficient way to store and query key details of racing events across different series, with particular emphasis on driver performance, team strategies, and race statistics.

The database uses a relational schema, with well-defined relationships between tables to ensure data integrity and support fast querying.

### Key Features:
- **Races**: Information about various races including series, tracks, and race-specific details.
- **Drivers and Teams**: Data related to drivers, teams, and their participation in races.
- **Pit Stops**: Detailed tracking of pit stops including duration, driver, and race information.
- **Weather Conditions**: Weather data, including the chance of rain during the races.
- **Track Data**: Information about the tracks where races are held, including location and characteristics.
- **Series Information**: Data about different racing series, including the year and series name.

## Database Structure

### Entity-Relationship Diagram (ERD)

The ERD visualizes the entities and relationships in the database. The diagram includes key entities such as `Race`, `Driver`, `Team`, `Pit_Stop`, `Weather_Cond`, `Track`, and `Series`, with their relationships clearly illustrated. The diagram will be useful in understanding the connections between the tables and how data flows in the system.

### Relational Schema (RS)

The relational schema defines the structure of the database in terms of tables, columns, and the relationships between them. This schema describes each table's attributes and keys to maintain the integrity of the data.

You can find the full ERD and RS documents in the project repository for a detailed view of the database design.

## Features

- **Table Creation**: Scripts are included to create tables for `Race`, `Driver`, `Team`, `Pit_Stop`, `Weather_Cond`, `Track`, and `Series` entities.
- **Data Insertion**: Scripts provide sample data to populate the tables and help you start querying immediately.
- **Indexing**: Indexes are created on frequently queried fields to optimize the performance of complex queries. For example, indexing `Driver_ID`, `Race_ID`, and `Series_ID` allows for faster lookups across large datasets.
- **Functions**: Functions for calculating statistics such as average pit stop duration, total race time, and driver performance.
- **Views**: Predefined views provide simplified access to common queries such as race results, pit stop summaries, and weather conditions.
