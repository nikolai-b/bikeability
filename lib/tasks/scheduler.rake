desc "Send reminder emails"
task send_reminders: :environment do
  puts "Sending reminders..."
  Booking.send_reminders
  puts "done."
end
