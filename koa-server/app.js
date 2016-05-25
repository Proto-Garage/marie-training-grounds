var Koa = require('koa');
var app = module.exports = new Koa();

app.use(function response(ctx, next){
  ctx.body = "Hello World!";
});

app.listen(3000);
