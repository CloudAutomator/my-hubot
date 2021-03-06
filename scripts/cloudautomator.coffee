config =
  token: process.env.CA_JOB_TOKEN
  path: process.env.CA_JOB_URL

module.exports = (robot) ->
  robot.respond /cloudautomator 開発環境起動してね/i, (msg) ->
    msg.http('https://manager.cloudautomator.com')
      .header('Authorization', "CAAuth #{config.token}")
      .path("trigger/#{config.path}")
      .post() (err, res, body) ->
        json = JSON.parse body
        if json.result == "ok"
          msg.send "仰せのままに"
        else
          msg.send "なんかおかしいよ"
