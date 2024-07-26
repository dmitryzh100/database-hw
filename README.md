# README #

# Database Schema

This document provides the database schema for handling users, movies, characters, people, and related entities for our application. Below is an Entity-Relationship (ER) diagram illustrating the structure of our database.

## ER Diagram

```mermaid
erDiagram
    USERS {
        int user_id PK
        varchar username
        varchar first_name
        varchar last_name
        varchar email
        varchar password
        int avatar_id FK
        timestamp created_at
        timestamp updated_at
    }
    FILES {
        int file_id PK
        varchar file_name
        varchar mime_type
        varchar file_key
        text file_url
        timestamp created_at
        timestamp updated_at
    }
    MOVIES {
        int movie_id PK
        varchar title
        text description
        text detailed_info
        numeric budget
        date release_date
        interval duration
        int director_id FK
        varchar country
        int poster_id FK
        timestamp created_at
        timestamp updated_at
    }
    GENRES {
        int genre_id PK
        varchar name
        timestamp created_at
        timestamp updated_at
    }
    MOVIE_GENRES {
        int movie_id FK
        int genre_id FK
        timestamp created_at
        timestamp updated_at
    }
    CHARACTERS {
        int character_id PK
        varchar name
        text description
        varchar role
        int movie_id FK
        int person_id FK
        timestamp created_at
        timestamp updated_at
    }
    PEOPLE {
        int person_id PK
        varchar first_name
        varchar last_name
        text biography
        date date_of_birth
        varchar gender
        varchar country
        timestamp created_at
        timestamp updated_at
    }
    PERSON_PHOTOS {
        int photo_id PK
        int person_id FK
        int file_id FK
        boolean is_primary
        timestamp created_at
        timestamp updated_at
    }
    FAVORITE_MOVIES {
        int user_id FK
        int movie_id FK
        timestamp created_at
        timestamp updated_at
    }

    USERS ||--o{ FILES: avatar_id
    USERS ||--o{ FAVORITE_MOVIES: user_id
    MOVIES ||--o{ FILES: poster_id
    MOVIES ||--o{ PEOPLE: director_id
    MOVIES ||--o{ MOVIE_GENRES: movie_id
    MOVIES ||--o{ CHARACTERS: movie_id
    MOVIE_GENRES ||--o{ GENRES: genre_id
    CHARACTERS ||--o{ PEOPLE: person_id
    PEOPLE ||--o{ PERSON_PHOTOS: person_id
    PERSON_PHOTOS ||--o{ FILES: file_id
    FAVORITE_MOVIES ||--o{ MOVIES: movie_id
