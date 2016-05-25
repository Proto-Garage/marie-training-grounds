DROP TABLE IF EXISTS task;
DROP SEQUENCE IF EXISTS task_id_sequence;
DROP FUNCTION IF EXISTS create_task(
  varchar,
  varchar,
  varchar[],
  varchar,
  varchar
);
DROP FUNCTION IF EXISTS update_task(
  int,
  varchar,
  varchar,
  varchar[],
  varchar,
  varchar
);

CREATE TABLE task(
  id int,
  title varchar,
  description varchar,
  labels varchar[],
  status varchar,
  priority varchar,
  date_time timestamp
);

CREATE SEQUENCE task_id_sequence
INCREMENT BY 1
OWNED BY task.id;

CREATE FUNCTION create_task(
  this_title varchar,
  this_description varchar,
  this_labels varchar[],
  this_status varchar,
  this_priority varchar
) RETURNS TABLE (
  id int,
  title varchar,
  description varchar,
  labels varchar[],
  status varchar,
  priority varchar
) AS $$
  DECLARE
    this_id int;
  BEGIN
    SELECT nextval('task_id_sequence')
    INTO this_id;

    INSERT INTO task (
      id,
      title,
      description,
      labels,
      status,
      priority,
      date_time
    ) VALUES (
      this_title,
      this_description,
      this_labels,
      this_status,
      this_priority,
      now()
    );

    RETURN QUERY
      SELECT *
      FROM task AS A
      WHERE A.id = this_id;
  END;
$$ LANGUAGE plpgsql;

CREATE FUNCTION update_task(
  this_id int,
  this_title varchar,
  this_description varchar,
  this_labels varchar[],
  this_status varchar,
  this_priority varchar
) RETURNS TABLE(
  id int,
  title varchar,
  description varchar,
  labels varchar[],
  status varchar,
  priority varchar
) AS $$
  BEGIN
    UPDATE task
    SET
      title = this_title,
      description = this_title,
      labels = this_labels,
      status = this_status,
      priority = this_priority
    WHERE id = this_id;

    RETURN QUERY
      SELECT *
      FROM task
      WHERE id = this_id;
  END;
$$ LANGUAGE plpgsql;
