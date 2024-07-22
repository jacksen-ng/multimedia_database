CREATE TRIGGER insert_check_performance_trigger
AFTER INSERT ON player_data
FOR EACH ROW
EXECUTE FUNCTION insert_check_performance();

CREATE TRIGGER update_check_performance_trigger
AFTER UPDATE ON player_data
FOR EACH ROW
EXECUTE FUNCTION update_check_performance();

CREATE TRIGGER delete_training_required_trigger
BEFORE DELETE ON player_data
FOR EACH ROW
EXECUTE FUNCTION delete_training_required();