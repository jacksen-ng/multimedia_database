-- Player's Data Table
CREATE TABLE player_data (
    player_id SERIAL PRIMARY KEY,
    player_name TEXT NOT NULL,
    player_position TEXT NOT NULL,
    games_played INT NOT NULL,
    points_per_game DECIMAL(5, 2) NOT NULL,
    rebounds_per_game DECIMAL(5, 2) NOT NULL,
    assists_per_game DECIMAL(5, 2) NOT NULL,
    steals_per_game DECIMAL(5, 2) NOT NULL,
    blocks_per_game DECIMAL(5, 2) NOT NULL,
    field_goal_percentage DECIMAL(5, 2) NOT NULL
);

-- Training Table
CREATE TABLE training_table (
    training_id SERIAL PRIMARY KEY,
    player_id INT,
    training_area TEXT NOT NULL,
    recorded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (player_id) REFERENCES player_data (player_id) ON DELETE CASCADE
);

-- Adding unique constraint to training_table
ALTER TABLE training_table
ADD CONSTRAINT unique_player_training UNIQUE (player_id, training_area);

-- Training Required Table
CREATE TABLE training_required (
    id SERIAL PRIMARY KEY,
    player_id INT,
    deficiency_area TEXT NOT NULL,
    FOREIGN KEY (player_id) REFERENCES player_data (player_id) ON DELETE CASCADE
);

-- Inserting data
INSERT INTO player_data (
    player_name, player_position, games_played, points_per_game, rebounds_per_game, assists_per_game, steals_per_game, blocks_per_game, field_goal_percentage
) VALUES
    ('Luka Doncic', 'PG', 70, 33.90, 9.20, 9.80, 1.40, 0.50, 45.20),
    ('LeBron James', 'PF', 71, 25.70, 7.30, 8.30, 1.30, 0.50, 50.30),
    ('Klay Thompson', 'SG', 77, 17.90, 3.30, 2.30, 0.60, 0.50, 44.00),
    ('Giannis Antetokounmpo', 'PF', 73, 30.40, 11.50, 6.50, 1.20, 1.10, 55.30),
    ('Stephen Curry', 'PG', 74, 26.40, 4.50, 5.10, 0.70, 0.40, 47.50),
    ('Nikola Jokic', 'C', 79, 26.40, 12.40, 9.00, 1.40, 0.90, 55.00),
    ('Kawhi Leonard', 'SF', 68, 23.70, 6.10, 3.60, 1.60, 0.90, 51.20),
    ('Rudy Gobert', 'C', 76, 14.00, 12.90, 1.30, 0.70, 2.10, 66.70),
    ('Kyrie Irving', 'SG', 58, 25.60, 5.00, 5.20, 1.30, 0.50, 49.10),
    ('Jayson Tatum', 'SF', 74, 26.90, 8.10, 4.90, 1.00, 0.60, 45.80);