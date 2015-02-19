cronJob = require('cron').CronJob
config =
  token: process.env.CA_JOB_TOKEN
  path: process.env.CA_JOB_URL

module.exports = (robot) ->
  new cronJob
    cronTime: '0 20 * * * *'
    onTick: ->
      robot.http('https://manager.cloudautomator.com')
        .header('Authorization', "CAAuth #{config.token}")
        .path("trigger/#{config.path}")
        .post() (err, res, body) ->
          json = JSON.parse body
          if json.result == "ok"
            robot.send {room: "notifications"}, "仰せのままに"
          else
            robot.send {room: "notifications"}, "ご主人様、事件です！"
    start: true
    timeZone: "Asia/Tokyo"
