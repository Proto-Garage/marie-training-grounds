module.exports.create = function *(next){
  var result = yield this.pg.db.client.query_(
  "SELECT * FROM create_task( '"
    +this.params.title+"', '"
    +this.params.description+"', '{"
    +this.params.labels+"}', '"
    +this.params.priority
  +"')");
  console.log(this.params);

  console.log('result:',result);

  this.body = result.rows[0];
};

module.exports.retrieve = function *(next){
  var result = yield this.pg.db.client.query_(
  "SELECT * FROM retrieve_task()");
  console.log('result:',result);

  this.body = result.rows;
}

module.exports.update = function *(next){
  var result = yield this.pg.db.client.query_(
  "SELECT * FROM update_task("
    +this.params.id+", '"
    +this.params.title+"', '"
    +this.params.description+"', '{"
    +this.params.labels+"}', '"
    +this.params.priority
  +"')");
  console.log('result:',result);

  this.body = result.rows[0];
};

module.exports.delete = function *(next){
  var result = yield this.pg.db.client.query_(
  "SELECT * FROM delete_task("+this.params.id+"))");
  console.log('result:',result);

  this.body = result.rows[0];
}
