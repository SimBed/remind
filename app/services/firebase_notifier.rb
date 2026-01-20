require "googleauth"
require "net/http"
require "json"

class FirebaseNotifier
  SCOPE = "https://www.googleapis.com/auth/firebase.messaging"

  def initialize
    @project_id = ENV.fetch("FIREBASE_PROJECT_ID")
    @device_token = ENV.fetch("FCM_DEVICE_TOKEN")
    @json_path = ENV.fetch("FIREBASE_SERVICE_ACCOUNT_JSON")
  end

  def notify(title:, body:)
    access_token = fetch_access_token

    uri = URI("https://fcm.googleapis.com/v1/projects/#{@project_id}/messages:send")

    request = Net::HTTP::Post.new(uri)
    request["Authorization"] = "Bearer #{access_token}"
    request["Content-Type"] = "application/json"

    request.body = {
      message: {
        token: @device_token,
        notification: {
          title: title,
          body: body
        },
        android: {
          notification: {
            channel_id: "fcm_default_channel"
          }
        }
      }
    }.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.request(request)
  end

  private

  def fetch_access_token
    creds = Google::Auth::ServiceAccountCredentials.make_creds(
      json_key_io: File.open(@json_path),
      scope: SCOPE
    )
    creds.fetch_access_token!
    creds.access_token
  end
end
