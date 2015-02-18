config =
  token: process.env.CA_JOB_TOKEN
  path: process.env.CA_JOB_URL

module.exports = (robot) ->
  robot.respond /cloudautomator/i, (msg) ->
    msg.http('https://manager.cloudautomator.com')
      .header('Authorization', "CAAuth #{config.token}")
      .path("trigger/#{config.path}")
      .post() (err, res, body) ->
        msg.send "#{body}"
