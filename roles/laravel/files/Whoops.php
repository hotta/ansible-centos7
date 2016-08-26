<?php
if (config('app.debug'))  {
  $whoops = new \Whoops\Run;
  $whoops->pushHandler(new \Whoops\Handler\PrettyPageHandler());
  return new \Illuminate\Http\Response(
    $whoops->handleException($e),
    $e->getStatusCode(),
    $e->getHeaders()
  );
}
