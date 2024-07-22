CREATE OR REPLACE FUNCTION update_check_performance() RETURNS TRIGGER AS '
DECLARE
    standard_points_per_game CONSTANT DECIMAL(5, 2) := 10.0;
    standard_rebounds_per_game CONSTANT DECIMAL(5, 2) := 5.0;
    standard_assists_per_game CONSTANT DECIMAL(5, 2) := 3.0;
    standard_field_goal_percentage CONSTANT DECIMAL(5, 2) := 40.0;
BEGIN
    -- Check and insert deficiencies into training_required table
    IF NEW.points_per_game < standard_points_per_game THEN
        INSERT INTO training_required (player_id, deficiency_area)
        VALUES (NEW.player_id, ''Points per Game'');
    ELSE
        DELETE FROM training_required WHERE player_id = NEW.player_id AND deficiency_area = ''Points per Game'';
    END IF;

    IF NEW.rebounds_per_game < standard_rebounds_per_game THEN
        INSERT INTO training_required (player_id, deficiency_area)
        VALUES (NEW.player_id, ''Rebounds per Game'');
    ELSE
        DELETE FROM training_required WHERE player_id = NEW.player_id AND deficiency_area = ''Rebounds per Game'';
    END IF;

    IF NEW.assists_per_game < standard_assists_per_game THEN
        INSERT INTO training_required (player_id, deficiency_area)
        VALUES (NEW.player_id, ''Assists per Game'');
    ELSE
        DELETE FROM training_required WHERE player_id = NEW.player_id AND deficiency_area = ''Assists per Game'';
    END IF;

    IF NEW.field_goal_percentage < standard_field_goal_percentage THEN
        INSERT INTO training_required (player_id, deficiency_area)
        VALUES (NEW.player_id, ''Field Goal Percentage'');
    ELSE
        DELETE FROM training_required WHERE player_id = NEW.player_id AND deficiency_area = ''Field Goal Percentage'';
    END IF;

    -- Update training records into training_table
    DELETE FROM training_table WHERE player_id = NEW.player_id;
    INSERT INTO training_table (player_id, training_area, recorded_at)
    VALUES (NEW.player_id, ''Points per Game'', CURRENT_TIMESTAMP),
        (NEW.player_id, ''Rebounds per Game'', CURRENT_TIMESTAMP),
        (NEW.player_id, ''Assists per Game'', CURRENT_TIMESTAMP),
        (NEW.player_id, ''Field Goal Percentage'', CURRENT_TIMESTAMP);

    RETURN NEW;
END;
' LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_training_required() RETURNS TRIGGER AS '
BEGIN
    
    DELETE FROM training_required WHERE player_id = OLD.player_id;
    RETURN OLD;
END;
' LANGUAGE plpgsql;