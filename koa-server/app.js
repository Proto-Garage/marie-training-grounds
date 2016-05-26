
var Koa = require('koa');
var koaPg = require('koa-pg');
var taskApi = require('./task');
var router = require('koa-router')();
var app = module.exports = new Koa();

app.use(koaPg('postgres://postgres:p455w0rd@localhost:5432/Identifi'));

router.post('/task', taskApi.create);
router.get('/task', taskApi.retrieve);
router.put('/task/:id', taskApi.update);
router.del('/task/:id', taskApi.delete);

router.get('/', function *(next){
  var result = yield this.pg.db.client.query_(
  "SELECT now()");
  console.log('result:',result);
  this.body = result.rows[0];
});

app.use(router.routes())
  .use(router.allowedMethods());
app.listen(3000);
