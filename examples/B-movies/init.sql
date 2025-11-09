-- Initialize the movies database with sample data

-- Create movies table
CREATE TABLE IF NOT EXISTS movies (
    movie_id INTEGER PRIMARY KEY,
    movie_title VARCHAR(255) NOT NULL,
    release_year INTEGER NOT NULL,
    genre VARCHAR(100) NOT NULL
);

-- Create cast table
CREATE TABLE IF NOT EXISTS cast (
    id SERIAL PRIMARY KEY,
    movie_id INTEGER NOT NULL,
    actor_name VARCHAR(255) NOT NULL,
    role_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (movie_id) REFERENCES movies(movie_id)
);

-- Insert movies data
INSERT INTO movies (movie_id, movie_title, release_year, genre) VALUES
(1, 'The Data Heist', 2023, 'Action'),
(2, 'Machine Learning Detective', 2022, 'Thriller'),
(3, 'Cloud Atlas Returns', 2023, 'Sci-Fi'),
(4, 'The Pipeline', 2024, 'Drama'),
(5, 'Binary Sunset', 2023, 'Sci-Fi'),
(6, 'Data Warriors', 2022, 'Action'),
(7, 'The Algorithm', 2024, 'Thriller'),
(8, 'Digital Dreams', 2023, 'Drama'),
(9, 'Code Red', 2022, 'Action'),
(10, 'Syntax Error', 2024, 'Comedy');

-- Insert cast data
INSERT INTO cast (movie_id, actor_name, role_type) VALUES
(1, 'Alice Johnson', 'Lead'),
(1, 'Bob Smith', 'Lead'),
(1, 'Carol White', 'Supporting'),
(2, 'Bob Smith', 'Lead'),
(2, 'David Brown', 'Lead'),
(2, 'Alice Johnson', 'Supporting'),
(3, 'Carol White', 'Lead'),
(3, 'Eva Green', 'Lead'),
(3, 'Frank Miller', 'Supporting'),
(4, 'David Brown', 'Lead'),
(4, 'Alice Johnson', 'Lead'),
(5, 'Eva Green', 'Lead'),
(5, 'Bob Smith', 'Supporting'),
(5, 'Carol White', 'Supporting'),
(6, 'Frank Miller', 'Lead'),
(6, 'Alice Johnson', 'Lead'),
(6, 'Bob Smith', 'Supporting'),
(7, 'Carol White', 'Lead'),
(7, 'David Brown', 'Lead'),
(7, 'Eva Green', 'Supporting'),
(8, 'Alice Johnson', 'Lead'),
(8, 'Eva Green', 'Lead'),
(9, 'Bob Smith', 'Lead'),
(9, 'Frank Miller', 'Lead'),
(9, 'Alice Johnson', 'Supporting'),
(10, 'David Brown', 'Lead'),
(10, 'Carol White', 'Supporting'),
(10, 'Frank Miller', 'Supporting');

-- Create indexes for better query performance
CREATE INDEX idx_cast_movie_id ON cast(movie_id);
CREATE INDEX idx_cast_actor_name ON cast(actor_name);
CREATE INDEX idx_movies_genre ON movies(genre);
