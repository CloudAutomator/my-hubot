cronJob = require('cron').CronJob
config =
  token: process.env.CA_JOB_TOKEN
  path: process.env.CA_JOB_URL
  channel: process.env.SLACK_CHANNEL_NAME

module.exports = (robot) ->
  new cronJob
    cronTime: '0 15 * * * *'
    onTick: ->
      robot.http('https://manager.cloudautomator.com')
        .header('Authorization', "CAAuth #{config.token}")
        .path("trigger/#{config.path}")
        .post() (err, res, body) ->
          json = JSON.parse body
          if json.result == "ok"
            msg.send {room: "#{config.channel}"}, "ご心配無用にございます"
          else
            msg.send {room: "#{config.channel}"}, "ご主人様、事件です！"
    start: true
    timeZone: "Asia/Tokyo"
