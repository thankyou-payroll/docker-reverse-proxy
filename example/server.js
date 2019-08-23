import Koa from "koa";
import logger from "koa-logger";
import serve from "koa-static";

const app = new Koa();
const title = (ctx, next) => {
  ctx.set("X-Application-Name", process.env.APP_NAME);
  return next();
};
app
  .use(title)
  .use(logger())
  .use(serve("./public/"))
  .listen(3000);
